import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_event.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_state.dart';
import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/services/device_location_service.dart';
import 'package:assignment0/services/search_city_service.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationInitialState()) {
    on<LocationEvent>((event, emit) async {
      // get it stuff
      final locator = GetIt.instance;
      final deviceLocationService = locator.get<DeviceLocationService>();
      final searchCityService = locator.get<SearchCityService>();

      // hive stuff

      Box<LocationInfo> locationBox;
      locationBox = Hive.box('location');

      if (event is DeviceLocationStartupEvent) {
        // sqflite if hive not working.

        // final list = await SqliteController.getLocationItems();

        final hiveList = locationBox.values.toList().reversed.toList();
        debugPrint("DeviceLocationStartup Location Bloc :: Hive");
        for (var item in hiveList) {
          debugPrint("${item.loc} ${item.location}");
        }
        if (hiveList.isEmpty) {
          emit(
            const WeatherDataEmptyState(msg: "Weather data not found in DB"),
          );
        }

        emit(LocationStartupState(locationInfo: hiveList));
      } else if (event is DeviceLocationEvent) {
        emit(const LocationLoadingState(isLoading: true));

        Position? position;

        await deviceLocationService.getDeviceLocation().then((value) {
          debugPrint("All is well.");
          position = value;
        }).onError((error, stackTrace) {
          debugPrint("Error : $error :: StackTrace :: $stackTrace");

          emit(LocationErrorState(msg: error.toString()));

          return Future.error(error ?? "Can't get device location");
        });

        debugPrint("position :: $position");

        if (position != null) {
          // fetch weather info
          final lat = position!.latitude;
          final longtd = position!.longitude;

          final weatherResponse =
              await searchCityService.getPlaceWeatherBasisLatAndLong(
            lat: lat,
            longtd: longtd,
          );

          debugPrint("weatherData :: $weatherResponse");

          if (weatherResponse != null) {
            final locationInfo = LocationInfo(
              loc: LocationEnum.curLoc.getLabel,
              weatherCondition: weatherResponse.weather[0].description,
              temperature: weatherResponse.main?.temp.toString() ?? "",
              location: weatherResponse.name,
              countryCode: weatherResponse.sys?.country ?? "",
            );

            await locationBox.put(
              LocationEnum.curLoc.getLabel,
              locationInfo,
            );

// sqflite if hive not working.

            // final isDbInitialized = await SqliteController.dbInit();

            // if (isDbInitialized) {
            //   await SqliteController.createLocationRecord(locationInfo);
            // }

            emit(WeatherDataState(weatherResponse: weatherResponse));
          } else {
            emit(const WeatherDataEmptyState(msg: "Weather data not found"));
          }
        } else {
          emit(const LocationErrorState(msg: "Something went wrong"));
        }
      }
    });
  }
}
