import 'package:assignment0/blocs/login_bloc/login_event.dart';
import 'package:assignment0/blocs/login_bloc/login_state.dart';
// import 'package:assignment0/controllers/sqlite_controller.dart';
import 'package:assignment0/models/logged_in_user_info.dart';
import 'package:assignment0/services/google_sign_in_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      // locator stuff

      final locator = GetIt.instance;
      final loginService = locator.get<GoogleAuthService>();

      // Hive stuff

      Box<LoggedInUserInfo> userBox;
      userBox = Hive.box('user');

      if (event is UserLoginStartupEvent) {
        // sqflite if hive not working.

        // final list = await SqliteController.getUserItems();

        final hiveList = userBox.values.toList().reversed.toList();
        debugPrint("Login Bloc :: Hive");
        for (var item in hiveList) {
          debugPrint(item.displayName);
        }

        emit(UserLoggedInStartupState(list: hiveList));
      }

      if (event is UserLoginEvent) {
        emit(const LoginLoadingState(isLoading: true));

        String loginError = "";
        UserCredential? userCredential;
        
        await loginService.googleSignIn().then(
          (value) {
            debugPrint("login Bloc :: here $value");
            userCredential = value;
            loginError += userCredential.toString();
          },
        ).onError((error, stackTrace) {
          debugPrint("Login bloc ::  Error :: $error");

          loginError += " :: $error :: $stackTrace";

          emit(
            LoginErrorState(
              msg: error.toString() + " " + stackTrace.toString(),
            ),
          );

          return Future.error("Error $error");
        });

        if (userCredential != null) {
          final loggedinUser = userCredential!.user;

          if (loggedinUser != null) {
            final data = LoggedInUserInfo(
              displayName: loggedinUser.displayName ?? "",
              email: loggedinUser.email ?? "",
              photoUrl: loggedinUser.photoURL ?? "",
              uid: loggedinUser.uid,
            );

            // sqflite if hive not working.

            // final isDbInitialized = await SqliteController.dbInit();

            // if (isDbInitialized) {
            //   await SqliteController.createUserRecord(data);
            // }

            // put things in hive

            await userBox.put(loggedinUser.uid, data);
          }

          emit(UserLoggedInState(userCredential: userCredential));
        } else {
          emit(LoginErrorState(msg: "$loginError Something went wrong!"));
        }
      }

      if (event is UserLogoutEvent) {
        // TODO : add loaderstate

        await loginService.signOut();

        final currentUser = FirebaseAuth.instance.currentUser;

        // delete user from hive

        if (currentUser != null) {
          final key = currentUser.uid;
          await userBox.delete(key);
        }

        emit(const UserLoggedOutState());
      }
    });
  }
}
