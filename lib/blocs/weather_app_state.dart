import 'package:assignment0/models/place_weather_response.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherAppState extends Equatable {
  const WeatherAppState();
}

class WeatherAppInitialState extends WeatherAppState {
  const WeatherAppInitialState();

  @override
  List<Object> get props => [];
}

class LoadingState extends WeatherAppState {
  final bool? isLoading;

  const LoadingState({this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class ErrorState extends WeatherAppState {
  final String? msg;

  const ErrorState({this.msg});

  @override
  List<Object?> get props => [msg];
}

class UserLoggedInState extends WeatherAppState {
  final UserCredential? userCredential;

  const UserLoggedInState({this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class DeviceLocationState extends WeatherAppState {
  final Position? position;

  const DeviceLocationState({this.position});

  @override
  List<Object?> get props => [position];
}

class WeatherDataState extends WeatherAppState {
  final PlaceWeatherResponse? weatherResponse;

  const WeatherDataState({this.weatherResponse});

  @override
  List<Object?> get props => [weatherResponse];
}

class WeatherDataEmptyState extends WeatherAppState {
  final String? msg;

  const WeatherDataEmptyState({this.msg});

  @override
  List<Object?> get props => [msg];
}
