import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_state.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_event.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_state.dart';
import 'package:assignment0/controllers/city_search_controller.dart';
import 'package:assignment0/controllers/sqlite_controller.dart';
import 'package:assignment0/models/location_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCityBloc extends Bloc<CityEvent, CityState> {
  SearchCityBloc() : super(const CityInitialState()) {
    on<CityEvent>((event, emit) async {
      if (event is SearchCityStartupEvent) {
        List<LocationInfo> list = await SqliteController.getLocationItems();
        list = list.reversed.toList();
        debugPrint("BLoC :: search city startup data  ");
        for (var item in list) {
          debugPrint(item.location);
          debugPrint(item.countryCode);
        }
        emit(CityStartupState(locationInfo: list));
      }

      if (event is SearchCityEvent) {
        emit(const CityLoadingState(isLoading: true));

        final city = CitySearchController.searchedPlace;
        debugPrint("bloc :: $city");
        emit(SearchCityState(city: CitySearchController.searchedPlace));

        // const LoadingState(isLoading: false);
      }

      if (event is FetchCityWeatherEvent) {
        emit(const CityLoadingState(isLoading: true));
        await CitySearchController.getLocationInfoForSearchedPlace(
          place: CitySearchController.searchedPlace,
        );
        final weatherResponse = CitySearchController.weatherResponse;

        debugPrint("BLOC weather data :: $weatherResponse");

        if (weatherResponse == null) {
          emit(const SearchCityWeatherEmptyState(msg: "data not found"));
        } else {
          final country = CitySearchController.country;
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
