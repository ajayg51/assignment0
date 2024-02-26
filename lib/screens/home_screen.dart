import 'package:assignment0/blocs/device_location_bloc/device_location_bloc.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_event.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_state.dart';
import 'package:assignment0/blocs/login_bloc/login_bloc.dart';
import 'package:assignment0/blocs/login_bloc/login_event.dart';
import 'package:assignment0/blocs/login_bloc/login_state.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_bloc.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_event.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_state.dart';
import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/models/place_weather_response.dart';
import 'package:assignment0/utils/assets.dart';
import 'package:assignment0/utils/color_consts.dart';
import 'package:assignment0/utils/common_appbar.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/route_path.dart';
import 'package:assignment0/utils/separator.dart';
import 'package:assignment0/widgets/weather_info.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if (FirebaseAuth.instance.currentUser != null) {
          SystemNavigator.pop();
        }
      },
      child: CommonScaffold(
        gradientColorList: ColorConsts.gradientColorList,
        child: Column(
          children: [
            const CommonAppbar(bannerAssetPath: Assets.weatherBanner),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    12.verticalSpace,
                    const BuildLoggedInUserInfo(),
                    24.verticalSpace,
                    buildBtnRow(context),
                    24.verticalSpace,
                    const BuildDeviceLocationWeatherInfo(),
                    24.verticalSpace,
                    const Separator(),
                    24.verticalSpace,
                    const SearchedPlaceWeatherInfo(),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBtnRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.pushNamed(RouteEnums.searchCity.getPath);
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Get other city weather info",
                  style: Theme.of(context).textTheme.titleSmall,
                ).padAll(value: 12),
              ),
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: InkWell(
            onTap: () {
              BlocProvider.of<LoginBloc>(context).add(
                const UserLogoutEvent(),
              );
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log out",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ).padAll(value: 12),
                ],
              ),
            ),
          ),
        ),
      ],
    ).padSymmetric(horizontalPad: 12);
  }
}

class BuildLoggedInUserInfo extends StatefulWidget {
  const BuildLoggedInUserInfo({super.key});

  @override
  State<BuildLoggedInUserInfo> createState() => _BuildLoggedInUserInfoState();
}

class _BuildLoggedInUserInfoState extends State<BuildLoggedInUserInfo> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(const UserLoginStartupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (ctx, state) {
        if (state is UserLoggedOutState &&
            FirebaseAuth.instance.currentUser == null) {
          context.router.pushNamed(RouteEnums.login.getPath);
        }
      },
      builder: (ctx, state) {
        if (state is UserLoggedInStartupState) {
          final list = state.list;
          if (list.isNotEmpty) {
            final userInfo = list[0];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all()),
                    child: ClipOval(
                      child: Image.network(
                        userInfo.photoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Text(
                            "NA",
                            style: Theme.of(context).textTheme.titleSmall,
                          );
                        },
                      ).padAll(value: 6),
                    ),
                  ),
                  12.horizontalSpace,
                  Text(
                    "Hello ${userInfo.displayName}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ).padSymmetric(
                horizontalPad: 12,
                verticalPad: 6,
              ),
            ).padSymmetric(horizontalPad: 12);
          }
        }
        return Text(
          "user info not found",
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }
}

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
          return const BuildLoadingState();
        } else if (state is LocationErrorState) {
          debugPrint(state.msg);
          return BuildErrorState(msg: "Something went wrong")
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
            onTap: () {
              BlocProvider.of<LocationBloc>(context)
                  .add(const DeviceLocationEvent());
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

class SearchedPlaceWeatherInfo extends StatefulWidget {
  const SearchedPlaceWeatherInfo({super.key});

  @override
  State<SearchedPlaceWeatherInfo> createState() =>
      _SearchedPlaceWeatherInfoState();
}

class _SearchedPlaceWeatherInfoState extends State<SearchedPlaceWeatherInfo> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<SearchCityBloc>(context)
        .add(const SearchCityStartupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCityBloc, CityState>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        if (state is CityStartupState) {
          final list = state.locationInfo.toList();
          debugPrint("search city startup Event");
          debugPrint(
              "search city startup data % ${state.locationInfo}  ## $state $list len :: ${list.length} ");

          LocationInfo? locationInfo;
          for (int i = 0; i < list.length; i++) {
            // debugPrint("loc :: "+list[i].loc);
            // debugPrint("location :: "+list[i].location);

            if (list[i].loc == LocationEnum.otherLoc.getLabel) {
              locationInfo = list[i];
              break;
            }
          }

          debugPrint("locationInfo : $locationInfo");

          if (locationInfo == null) {
            return Text(
              "Searched location info not found",
              style: Theme.of(context).textTheme.titleMedium,
            );
          }
          final String weatherCondition = locationInfo.weatherCondition;
          final String temperature = locationInfo.temperature;
          final String location = locationInfo.location;
          final String countryCode = locationInfo.countryCode;

          debugPrint(locationInfo.toString());

          final country = countryCode.getCountryEnumFromString;

          return Column(
            children: [
              Text(
                "Last fetched weather info",
                style: Theme.of(context).textTheme.titleLarge,
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

        if (state is CityLoadingState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Fetching data...",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              12.horizontalSpace,
              const CircularProgressIndicator(
                color: Colors.black,
              )
            ],
          );
        }
        if (state is SearchCityWeatherEmptyState) {
          return Text(
            state.msg,
            style: Theme.of(context).textTheme.titleMedium,
          );
        }
        if (state is SearchCityWeatherState) {
          debugPrint("hello");
          debugPrint(state.country.getCountryName);
          final data = state.weatherResponse;
          final location = data?.name;

          String countryCode = data?.sys?.country ?? "";
          final country = countryCode.getCountryEnumFromString.getCountryName;

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Weather Info :: $location $country",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ).padAll(value: 12),
              ),
              12.verticalSpace,
              WeatherInfo(
                weatherResponse: data,
                country: state.country,
              ),
            ],
          );
        }
        // return const Text("Searched Place :: init state");
        return const SizedBox.shrink();
      },
    );
  }
}

class BuildLoadingState extends StatelessWidget {
  const BuildLoadingState({super.key});

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
