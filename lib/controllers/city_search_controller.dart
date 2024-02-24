import 'dart:async';

import 'package:assignment0/models/place_lat_longtd_response.dart';
import 'package:assignment0/models/place_weather_response.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CitySearchController {
  static final dio = Dio();
  static String searchedPlace = "";
  static PlaceWeatherResponse? weatherResponse;
  static Country? countryFlag;

  static const latLongtdUrl = "https://api.openweathermap.org/geo/1.0/direct";
  static const cityWeatherUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  static const apiKey = "647ad5b09c950c3826811d25cc07baca";

  static Future<PlaceWeatherResponse?> getPlaceWeatherBasisLatAndLong({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await dio.get(
        cityWeatherUrl,
        queryParameters: {
          "lat": lat,
          "lon": lon,
          "appid": apiKey,
        },
      );

      if (response.statusCode == 200) {
        debugPrint("All OK");
        debugPrint(response.data.toString());
        return PlaceWeatherResponse.fromJson(response.data);
      } else {
        debugPrint("Status code : ");
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint("Error $e");
    }

    return null;
  }

  static void onSearchIconTap({
    required Country flag,
    required String place,
  }) {
    if (place.isEmpty || place == searchedPlace) return;
    searchedPlace = place;
    countryFlag = flag;
  }

  static Future<void> getLocationInfoForSearchedPlace(
      {required String place}) async {
    // CustomDialog.showAlertDialog(
    //   context: context,
    //   msg: "Fetching data...",
    // );

    final latLongtdData = await getLatLongtdForPlace(
      place: place,
      countryCode: countryFlag!.getISOCountryCodes,
    );

    if (latLongtdData != null && latLongtdData.list.isNotEmpty) {
      debugPrint("got data");

      await getWeatherData(
        lat: latLongtdData.list[0].lat,
        lon: latLongtdData.list[0].lon,
      );

      // if (context.mounted) {
      //   Future.delayed(const Duration(seconds: 1));
      //   Navigator.pop(context);
      //   CustomDialog.showAlertDialog(
      //     context: context,
      //     msg: "Success",
      //   );
      // }
    } else {
      // if (context.mounted) {
      //   Future.delayed(const Duration(seconds: 1));
      //   Navigator.pop(context);
      //   CustomDialog.showAlertDialog(
      //     context: context,
      //     msg: "Failure!",
      //   );
      // }
      // Future.delayed(const Duration(seconds: 1));
      // if (context.mounted) {
      //   Navigator.pop(context);
      // }
    }
  }

  static Future<void> getWeatherData({
    bool? isFetchCurrentLocData,
    required double lat,
    required double lon,
  }) async {
    final weatherData = await getPlaceWeatherBasisLatAndLong(
      lat: lat,
      lon: lon,
    );

    if (weatherData != null) {
      final String countryCode = weatherData.sys?.country ?? "";
      debugPrint("country :: $countryCode");
      countryFlag = countryCode.getCountryEnumFromString;
      weatherResponse = weatherData;
    }
  }

  static Future<PlaceLatLongtdResponse?> getLatLongtdForPlace({
    required String place,
    required String countryCode,
  }) async {
    try {
      debugPrint(place);
      debugPrint(countryCode);

      final response = await dio.get(
        latLongtdUrl,
        queryParameters: {
          "q": "$place,$countryCode",
          "appid": apiKey,
        },
      );

      if (response.statusCode == 200) {
        debugPrint("All OK");
        debugPrint(response.data.toString());
        return PlaceLatLongtdResponse.fromList(response.data);
      } else {
        debugPrint("Status code : ");
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint("Error $e");
    }

    return null;
  }
}
