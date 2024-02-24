import 'package:assignment0/blocs/search_city_bloc/search_city_event.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_state.dart';
import 'package:assignment0/controllers/city_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCityBloc extends Bloc<CityEvent, CityState> {
  SearchCityBloc() : super(const CityInitialState()) {
    on<CityEvent>((event, emit) async {
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
          final flag = CitySearchController.countryFlag;
          debugPrint("flag :: $flag");
          
          emit(SearchCityWeatherState(
            weatherResponse: weatherResponse,
            flag: flag!,
          ));
        }
      }
    });
  }
}
