
import 'package:assignment0/services/google_sign_in_service.dart';
import 'package:assignment0/services/search_city_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void registerServices() {
  // TODO : add dependencies
  debugPrint("Registering services");

  locator.registerLazySingleton(
    () => GoogleAuthService(),
  );

  locator.registerLazySingleton<SearchCityService>(
    () => SearchCityService(),
  );
}
