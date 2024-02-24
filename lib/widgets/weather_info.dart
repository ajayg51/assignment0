import 'package:assignment0/models/place_weather_response.dart';
import 'package:assignment0/utils/boiler_plate_tile.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/separator.dart';
import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    super.key,
    this.weatherResponse,
    this.flag = Country.india,
  });

  final PlaceWeatherResponse? weatherResponse;
  final Country flag;
  @override
  Widget build(BuildContext context) {
    if (weatherResponse == null) {
      return const Center(
        child: Text("No data"),
      ).padSymmetric(horizontalPad: 12);
    }
    return LocationWeatherInfo(
      data: weatherResponse,
      flag: flag,
    ).padSymmetric(horizontalPad: 12);
  }
}

class LocationWeatherInfo extends StatelessWidget {
  const LocationWeatherInfo({
    super.key,
    this.data,
    this.isShowNoDataTile,
    required this.flag,
  });

  final PlaceWeatherResponse? data;
  final Country flag;
  final bool? isShowNoDataTile;

  @override
  Widget build(BuildContext context) {
    if (isShowNoDataTile == true) {
      return const BoilerPlateTile(
        child: Center(
          child: Text("No data"),
        ),
      );
    }

    final countryCode = data?.sys?.country ?? "err";
    final double temperature = data?.main?.temp ?? 0;

    return BoilerPlateTile(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all()),
                child: ClipOval(
                  child: Image.asset(
                    flag.getAssetPath,
                    height: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return Text("Code : $countryCode").padAll(value: 5);
                    },
                  ),
                ),
              ),
              12.horizontalSpace,
              const Expanded(
                child: Text(
                  "Current weather details",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          6.verticalSpace,
          const Separator(
            color: Colors.black,
          ),
          12.verticalSpace,
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                LabelInfo(
                  label: "Weather condition : ",
                  info: data != null && data!.weather.isNotEmpty
                      ? data!.weather[0].description
                      : "will update",
                ),
                12.verticalSpace,
                LabelInfo(
                  label: "Temperature : ",
                  info: data != null
                      ? "${temperature >= 273.16 ? (temperature - 273.16).toInt() : 0} \u2103"
                      : "will update",
                ),
                12.verticalSpace,
                LabelInfo(
                  label: "Location : ",
                  info: data != null ? data!.name : "will update",
                ),
              ],
            ).padAll(value: 10),
          ),
        ],
      ).padSymmetric(horizontalPad: 12),
    );
  }
}

class LabelInfo extends StatelessWidget {
  const LabelInfo({
    super.key,
    required this.label,
    required this.info,
  });

  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Text(
            info,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
