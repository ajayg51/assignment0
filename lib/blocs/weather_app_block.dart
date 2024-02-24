import 'package:assignment0/blocs/weather_app_event.dart';
import 'package:assignment0/blocs/weather_app_state.dart';
import 'package:assignment0/controllers/city_search_controller.dart';
import 'package:assignment0/controllers/device_location_controller.dart';
import 'package:assignment0/controllers/log_in_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class WeatherAppBloc extends Bloc<WeatherAppEvent, WeatherAppState> {
  WeatherAppBloc() : super(const WeatherAppInitialState()) {
    on<WeatherAppEvent>(eventStateMapper);
  }

  void eventStateMapper(
    WeatherAppEvent event,
    Emitter<WeatherAppState> emit,
  ) async {
    if (event is UserLogInEvent) {
      UserCredential? userCredential = await LogInController.googleSignIn();
      emit(UserLoggedInState(userCredential: userCredential));
    } else if (event is DeviceLocationEvent) {
      emit(const LoadingState(isLoading: true));
      Position? position;
      
      await DeviceLocationController.getDeviceLocation().then((value) {
        debugPrint("All is well.");

        position = value;


      }).onError((error, stackTrace) {
        debugPrint(error.toString() + " :: " + stackTrace.toString());

        emit(ErrorState(msg: error.toString()));

        return Future.error(error ?? "Can't get device location");
      });

      debugPrint("position :: $position");

      if (position != null) {
        final lat = position!.latitude;
        final longtd = position!.longitude;

        final weatherResponse =
            await CitySearchController.getPlaceWeatherBasisLatAndLong(
          lat: lat,
          lon: longtd,
        );

        debugPrint("weatherData :: $weatherResponse");
        if (weatherResponse != null) {
          emit(WeatherDataState(weatherResponse: weatherResponse));
        } else {
          emit(const WeatherDataEmptyState(msg: "No data found"));
        }
      }
      const LoadingState(isLoading: false);
    }
  }
}
