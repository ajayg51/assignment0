import 'package:assignment0/blocs/search_city_bloc/search_city_event.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_state.dart';
import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/services/search_city_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchCityBloc extends Bloc<CityEvent, CityState> {
  SearchCityBloc() : super(const CityInitialState()) {
    on<CityEvent>((event, emit) async {
      Box<LocationInfo> locationBox;
      locationBox = Hive.box('location');

      final locator = GetIt.instance;
      final searchCityService = locator.get<SearchCityService>();

      if (event is SearchCityStartupEvent) {
        // sqflite if hive not working.

        // List<LocationInfo> list = await SqliteController.getLocationItems();
        // list = list.reversed.toList();
        // debugPrint("BLoC :: search city startup data  ");
        // for (var item in list) {
        //   debugPrint(item.location);
        //   debugPrint(item.countryCode);
        // }

        final hiveList = locationBox.values.toList().reversed.toList();
        
        debugPrint("CitySearchStartUp Location Bloc :: Hive");

        // final hiveKeyList = locationBox.keys.toList().reversed.toList();
        // for (var item in hiveKeyList) {
        //   debugPrint("CitySearchBlocKey :: $item");
        // }

        for (var item in hiveList) {
          debugPrint("CitySearchBloc loc :: ${item.loc}");
          debugPrint("CitySearchBloc weather :: ${item.weatherCondition}");
          debugPrint("CitySearchBloc temp :: ${item.temperature}");
          debugPrint("CitySearchBloc country :: ${item.countryCode}");
          debugPrint("CitySearchBloc location :: ${item.location}");
        }

        emit(CityStartupState(locationInfo: hiveList));
      }

      if (event is SearchCityEvent) {
        emit(const CityLoadingState(isLoading: true));

        final city = searchCityService.searchedPlace;
        debugPrint("City bloc :: $city");
        emit(SearchCityState(city: searchCityService.searchedPlace));

        // const LoadingState(isLoading: false);
      }

      if (event is FetchCityWeatherEvent) {
        emit(const CityLoadingState(isLoading: true));
        await searchCityService.getLocationInfoForSearchedPlace(
          place: searchCityService.searchedPlace,
        );
        final weatherResponse = searchCityService.weatherResponse;

        debugPrint("BLOC weather data :: $weatherResponse");

        if (weatherResponse == null) {
          emit(const SearchCityWeatherEmptyState(msg: "data not found"));
        } else {
          final country = searchCityService.country;
          debugPrint("flag :: $country");

          emit(SearchCityWeatherState(
            weatherResponse: weatherResponse,
            country: country!,
          ));
        }
      }
    });
  }
}
