import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_event.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_state.dart';
import 'package:assignment0/controllers/city_search_controller.dart';
import 'package:assignment0/controllers/device_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationInitialState()) {
    on<LocationEvent>((event, emit) async {
      emit(const LocationLoadingState(isLoading: true));

      Position? position;

      await DeviceLocationController.getDeviceLocation().then((value) {
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
            await CitySearchController.getPlaceWeatherBasisLatAndLong(
          lat: lat,
          lon: longtd,
        );

        debugPrint("weatherData :: $weatherResponse");
        if (weatherResponse != null) {
          emit(WeatherDataState(weatherResponse: weatherResponse));
        } else {
          emit(const WeatherDataEmptyState(msg: "No data found"));
        }
      } else {
        emit(const LocationErrorState(msg: "Something went wrong"));
      }
    });
  }
}
