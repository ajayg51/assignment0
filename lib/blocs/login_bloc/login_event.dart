import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class UserLoginEvent extends LoginEvent {
  final UserCredential? userCredential;

  const UserLoginEvent({this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class UserLogoutEvent extends LoginEvent {
  const UserLogoutEvent();

  @override
  List<Object?> get props => [];
}
