import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/models/place_weather_response.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable {
  const LocationState();
}

class LocationInitialState extends LocationState {
  const LocationInitialState();

  @override
  List<Object> get props => [];
}

class LocationStartupState extends LocationState {
  final List<LocationInfo> locationInfo;

  const LocationStartupState({required this.locationInfo});

  @override
  List<Object> get props => [locationInfo];
}

class LocationLoadingState extends LocationState {
  final bool isLoading;

  const LocationLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class LocationErrorState extends LocationState {
  final String msg;

  const LocationErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class DeviceLocationState extends LocationState {
  final Position? position;

  const DeviceLocationState({this.position});

  @override
  List<Object?> get props => [position];
}

class WeatherDataState extends LocationState {
  final PlaceWeatherResponse? weatherResponse;

  const WeatherDataState({this.weatherResponse});

  @override
  List<Object?> get props => [weatherResponse];
}

class WeatherDataEmptyState extends LocationState {
  final String msg;

  const WeatherDataEmptyState({required this.msg});

  @override
  List<Object> get props => [msg];
}
