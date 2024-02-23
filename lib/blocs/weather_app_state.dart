import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class WeatherAppState extends Equatable {
  const WeatherAppState();
}

class WeatherAppInitialState extends WeatherAppState {
  const WeatherAppInitialState();

  @override
  List<Object> get props => [];
}

class UserLoggedInState extends WeatherAppState {
  final UserCredential? userCredential;

  const UserLoggedInState({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}
