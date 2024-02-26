import 'package:assignment0/models/place_weather_response.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/widgets/weather_info.dart';
import 'package:flutter/material.dart';

class BuildLoadingStateWidget extends StatelessWidget {
  const BuildLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Fetching weather info",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        12.verticalSpace,
        const CircularProgressIndicator(
          color: Colors.black,
        ),
      ],
    );
  }
}

class BuildErrorState extends StatelessWidget {
  const BuildErrorState({
    super.key,
    required this.msg,
  });

  final String msg;
  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class BuildEmptyState extends StatelessWidget {
  const BuildEmptyState({
    super.key,
    required this.msg,
  });

  final String msg;
  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class BuildWeatherSuccessState extends StatelessWidget {
  const BuildWeatherSuccessState({
    super.key,
    this.weatherResponse,
  });

  final PlaceWeatherResponse? weatherResponse;
  @override
  Widget build(BuildContext context) {
    return WeatherInfo(weatherResponse: weatherResponse);
  }
}
