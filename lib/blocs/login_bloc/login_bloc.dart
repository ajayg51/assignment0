import 'package:assignment0/blocs/login_bloc/login_event.dart';
import 'package:assignment0/blocs/login_bloc/login_state.dart';
import 'package:assignment0/controllers/log_in_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      if (event is UserLoginEvent) {
        emit(const LoginLoadingState(isLoading: true));

        UserCredential? userCredential;
        await LogInController.googleSignIn()
            .then((value) => userCredential = value)
            .onError((error, stackTrace) {
          debugPrint("Login Error :: $error");

          emit(LoginErrorState(msg: error.toString()));

          return Future.error("Error $error");
        });

        if (userCredential != null) {
          emit(UserLoggedInState(userCredential: userCredential));
        }

        // const LoadingState(isLoading: false);
      }

      if (event is UserLogoutEvent) {
        // TODO : add loaderstate

        await LogInController.signOut();
        emit(const UserLoggedOutState());
      }
    });
  }
}
