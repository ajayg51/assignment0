import 'package:another_flushbar/flushbar.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_event.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_state.dart';
import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/widgets/weather_state_widgets.dart';
import 'package:assignment0/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class BuildDeviceLocationWeatherInfo extends StatefulWidget {
  const BuildDeviceLocationWeatherInfo({super.key});

  @override
  State<BuildDeviceLocationWeatherInfo> createState() =>
      _BuildDeviceLocationWeatherInfoState();
}

class _BuildDeviceLocationWeatherInfoState
    extends State<BuildDeviceLocationWeatherInfo> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationBloc>(context)
        .add(const DeviceLocationStartupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LocationStartupState) {
          debugPrint("device location startup Event");
          final locationList = state.locationInfo;
          LocationInfo? locationInfo;
          for (int i = 0; i < locationList.length; i++) {
            if (locationList[i].loc == LocationEnum.curLoc.getLabel) {
              locationInfo = locationList[i];
            }
          }

          debugPrint("locationInfo : $locationInfo");

          if (locationInfo == null) {
            return buildRefreshableWeatherInfo(
              context: context,
              msg: "Device location info not found",
            );
          }
          final String weatherCondition = locationInfo.weatherCondition;
          final String temperature = locationInfo.temperature;
          final String location = locationInfo.location;
          final String countryCode = locationInfo.countryCode;

          debugPrint(location.toString());

          final country = countryCode.getCountryEnumFromString;

          return Column(
            children: [
              Center(
                child: Text(
                  "Last fetched weather info",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ).padSymmetric(horizontalPad: 12),
              12.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Weather Info :: $location ${country.getCountryName}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ).padAll(value: 12),
              ).padSymmetric(horizontalPad: 12),
              12.verticalSpace,
              WeatherInfo(
                isDbDataAvailed: true,
                weatherCondition: weatherCondition,
                temperature: temperature,
                location: location,
                country: country,
              ).padSymmetric(horizontalPad: 12),
            ],
          );
        }

        if (state is LocationLoadingState) {
          return const BuildLoadingStateWidget();
        } else if (state is LocationErrorState) {
          debugPrint(state.msg);
          return const BuildErrorState(msg: "Something went wrong")
              .padSymmetric(horizontalPad: 12);
        } else if (state is WeatherDataEmptyState) {
          return BuildEmptyState(msg: state.msg);
        } else if (state is WeatherDataState) {
          final data = state.weatherResponse;
          final location = data?.name;
          String countryCode = data?.sys?.country ?? "";
          final country = countryCode.getCountryEnumFromString;

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Weather Info  (device location) :: $location  ${country.getCountryName}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ).padAll(value: 12),
              ).padSymmetric(horizontalPad: 12),
              12.verticalSpace,
              BuildWeatherSuccessState(weatherResponse: data),
            ],
          );
        }
        return Text(
          "home screen : Init state :: $state ",
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }

  Widget buildRefreshableWeatherInfo({
    required BuildContext context,
    required String msg,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          12.horizontalSpace,
          Expanded(
            child: Text(
              msg,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          6.horizontalSpace,
          InkWell(
            onTap: () async {
              final isNetOn = await InternetConnection().hasInternetAccess;
              if (isNetOn) {
                if (context.mounted) {
                  BlocProvider.of<LocationBloc>(context)
                      .add(const DeviceLocationEvent());
                } else {
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Flushbar(
                      duration: const Duration(seconds: 1),
                      title: "Net is off",
                      message: "Please check net connectivity.",
                    ).show(context);
                  });
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
                color: Colors.white.withOpacity(0.5),
              ),
              child: const Icon(Icons.refresh).padAll(value: 12),
            ),
          ),
          12.horizontalSpace,
        ],
      ).padAll(value: 6),
    ).padSymmetric(horizontalPad: 12);
  }
}
