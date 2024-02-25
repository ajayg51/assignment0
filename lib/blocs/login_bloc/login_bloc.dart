import 'package:assignment0/blocs/login_bloc/login_event.dart';
import 'package:assignment0/blocs/login_bloc/login_state.dart';
import 'package:assignment0/controllers/log_in_controller.dart';
import 'package:assignment0/controllers/sqlite_controller.dart';
import 'package:assignment0/models/logged_in_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      // Box<LoggedInUserInfo> userBox;
      // userBox = Hive.box('user');
      if (event is UserLoginStartupEvent) {
        final list = await SqliteController.getUserItems();
        emit(UserLoggedInStartupState(list: list));
      }

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
          final loggedinUser = userCredential?.user;

          if (loggedinUser != null) {
            final data = LoggedInUserInfo(
              displayName: loggedinUser.displayName ?? "",
              email: loggedinUser.email ?? "",
              photoUrl: loggedinUser.photoURL ?? "",
              uid: loggedinUser.uid,
            );
            final isDbInitialized = await SqliteController.dbInit();
            
            if (isDbInitialized) {
              await SqliteController.createUserRecord(data);
            }

            // await userBox.put(loggedinUser.uid, data);
          }

          emit(UserLoggedInState(userCredential: userCredential));
        }

        // const LoadingState(isLoading: false);
      }

      if (event is UserLogoutEvent) {
        // TODO : add loaderstate

        await LogInController.signOut();
        final currentUser = FirebaseAuth.instance.currentUser;

        // if (currentUser != null) {
        //   final key = currentUser.uid;
        //   // await userBox.delete(key);
        // }

        emit(const UserLoggedOutState());
      }
    });
  }
}
