import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class WeatherAppEvent extends Equatable {
  const WeatherAppEvent();
}

class UserLogInEvent extends WeatherAppEvent {
  final UserCredential? userCredential;

  const UserLogInEvent({this.userCredential});

  @override
  List<Object?> get props =>  [userCredential];
}
