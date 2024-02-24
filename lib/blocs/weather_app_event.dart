import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherAppEvent extends Equatable {
  const WeatherAppEvent();
}

class UserLogInEvent extends WeatherAppEvent {
  final UserCredential? userCredential;

  const UserLogInEvent({this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class DeviceLocationEvent extends WeatherAppEvent {
  final Position? position;

  const DeviceLocationEvent({this.position});

  @override
  List<Object?> get props => [position];
}
