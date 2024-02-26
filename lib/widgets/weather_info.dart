import 'package:assignment0/models/place_weather_response.dart';
import 'package:assignment0/utils/boiler_plate_tile.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/separator.dart';
import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    super.key,
    this.isDbDataAvailed,
    this.weatherResponse,
    this.weatherCondition,
    this.temperature,
    this.location,
    this.country = Country.india,
  });
  final PlaceWeatherResponse? weatherResponse;
  final bool? isDbDataAvailed;
  final String? weatherCondition;
  final String? temperature;
  final String? location;
  final Country country;
  @override
  Widget build(BuildContext context) {
    if (isDbDataAvailed == true) {
      return LocationWeatherInfo(
        weatherCondition: weatherCondition,
        temperature: temperature,
        location: location,
        country: country,
      );
    }
    if (weatherResponse == null) {
      return Center(
        child: Text(
          "No data",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ).padSymmetric(horizontalPad: 12);
    }
    return LocationWeatherInfo(data: weatherResponse, country: country)
        .padSymmetric(horizontalPad: 12);
  }
}

class LocationWeatherInfo extends StatelessWidget {
  const LocationWeatherInfo({
    super.key,
    this.data,
    this.isShowNoDataTile,
    this.weatherCondition,
    this.temperature,
    this.location,
    required this.country,
  });

  final PlaceWeatherResponse? data;
  final Country country;
  final bool? isShowNoDataTile;
  final String? weatherCondition;
  final String? temperature;
  final String? location;

  @override
  Widget build(BuildContext context) {
    if (isShowNoDataTile == true) {
      return BoilerPlateTile(
        child: Center(
          child: Text(
            "No data",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      );
    }

    final countryCode = data?.sys?.country ?? "err";
    final double apiTemperature = data?.main?.temp ?? 0;
    final double dbTemperature = double.tryParse(temperature ?? "") ?? 0;
    final countryAssetPath = country.getAssetPath;

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
                  child: countryAssetPath.isEmpty
                      ? Text(
                          "Code : ${country.getISOCountryCodes}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ).padAll(value: 5)
                      : Image.asset(
                          country.getAssetPath,
                          height: 50,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) {
                            return Text(
                              "Code : $countryCode",
                              style: Theme.of(context).textTheme.titleMedium,
                            ).padAll(value: 5);
                          },
                        ),
                ),
              ),
              12.horizontalSpace,
              Text(
                "Current weather details",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
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
                  label: "Weather condition",
                  info: data == null
                      ? weatherCondition != null
                          ? weatherCondition!
                          : "will update"
                      : data!.weather.isNotEmpty
                          ? data!.weather[0].description
                          : "will update",
                ),
                12.verticalSpace,
                LabelInfo(
                  label: "Temperature",
                  info: data == null
                      ? "${dbTemperature >= 273.16 ? (dbTemperature - 273.16).toInt() : 0} \u2103"
                      : "${apiTemperature >= 273.16 ? (apiTemperature - 273.16).toInt() : 0} \u2103",
                ),
                12.verticalSpace,
                LabelInfo(
                  label: "Location",
                  info: data == null
                      ? location != null
                          ? location!
                          : "Will update"
                      : data != null
                          ? data!.name
                          : "will update",
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
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Text(
            info,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
