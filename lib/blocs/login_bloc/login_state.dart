import 'package:assignment0/models/logged_in_user_info.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitialState extends LoginState {
  const LoginInitialState();

  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  const LoginLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class LoginErrorState extends LoginState {
  final String msg;

  const LoginErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class UserLoggedInStartupState extends LoginState {
  final List<LoggedInUserInfo> list;

  const UserLoggedInStartupState({required this.list});

  @override
  List<Object?> get props => [list];
}

class UserLoggedInState extends LoginState {
  final UserCredential? userCredential;

  const UserLoggedInState({this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class UserLoggedOutState extends LoginState {
  
  const UserLoggedOutState();

  @override
  List<Object?> get props => [];
}
