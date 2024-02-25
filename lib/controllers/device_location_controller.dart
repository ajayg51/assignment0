import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DeviceLocationController {
   Future<Position> getDeviceLocation() async {
    debugPrint("here 0");
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrint("here 1");
    if (!isServiceEnabled) {
      Future.error("Geo location service is not enabled");
      debugPrint("here 2");
    } else {
      debugPrint("here 3");
      LocationPermission permission = await Geolocator.checkPermission();
      debugPrint("here 4");
      if (permission == LocationPermission.denied) {
        debugPrint("here 5");
        permission = await Geolocator.requestPermission();
        debugPrint("here 6");
        if (permission == LocationPermission.denied) {
          debugPrint("here 7");
          Future.error("Geo location permission got denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint("here 8");
        Future.error("Geo location permission got denied permanently");
      }
    }

    debugPrint("here 9");
    return await Geolocator.getCurrentPosition();
  }
}
