import 'package:assignment0/models/place_weather_response.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:equatable/equatable.dart';

abstract class CityState extends Equatable {
  const CityState();
}

class CityInitialState extends CityState {
  const CityInitialState();

  @override
  List<Object> get props => [];
}

class CityLoadingState extends CityState {
  final bool isLoading;

  const CityLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class CityErrorState extends CityState {
  final String msg;

  const CityErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class SearchCityState extends CityState {
  final String? city;

  const SearchCityState({this.city});

  @override
  List<Object?> get props => [city];
}

class SearchCityWeatherState extends CityState {
  final PlaceWeatherResponse? weatherResponse;
  final Country flag;

  
  const SearchCityWeatherState({
    this.weatherResponse,
    this.flag = Country.india,
  });

  @override
  List<Object?> get props => [weatherResponse];
}

class SearchCityWeatherEmptyState extends CityState {
  final String msg;

  const SearchCityWeatherEmptyState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
