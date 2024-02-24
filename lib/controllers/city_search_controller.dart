import 'package:assignment0/models/place_lat_longtd_response.dart';
import 'package:assignment0/models/place_weather_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CitySearchController {
  static final dio = Dio();

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

  Future<PlaceLatLongtdResponse?> getLatLongtdForPlace({
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
