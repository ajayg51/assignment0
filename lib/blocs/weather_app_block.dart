import 'package:assignment0/blocs/weather_app_event.dart';
import 'package:assignment0/blocs/weather_app_state.dart';
import 'package:assignment0/controllers/log_in_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherAppBloc extends Bloc<WeatherAppEvent, WeatherAppState> {
  WeatherAppBloc() : super(const WeatherAppInitialState()) {
    on<WeatherAppEvent>(
      (event, emit) async {
        if (event is UserLogInEvent) {
          UserCredential? userCredential = await LogInController.googleSignIn();
          emit(UserLoggedInState(userCredential: userCredential));
        }
      },
    );
  }
}
