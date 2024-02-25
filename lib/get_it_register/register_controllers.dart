import 'package:assignment0/controllers/device_location_controller.dart';
import 'package:assignment0/controllers/log_in_controller.dart';
import 'package:assignment0/controllers/select_flag_controller.dart';
import 'package:assignment0/db/hive.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void registerControllers() {
  // TODO : add dependencies
  debugPrint("Setting up locator");
  
  final locator = GetIt.instance;

  locator.registerLazySingleton<HiveController>(
    () => HiveController(),
  );

  locator.registerLazySingleton<LogInController>(
    () => LogInController(),
  );

  locator.registerLazySingleton<DeviceLocationController>(
    () => DeviceLocationController(),
  );

  locator.registerLazySingleton<SelectFlagController>(
    () => SelectFlagController(),
  );

}
