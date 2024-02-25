import 'package:assignment0/blocs/device_location_bloc/device_location_bloc.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_event.dart';
import 'package:assignment0/blocs/device_location_bloc/device_location_bloc_state.dart';
import 'package:assignment0/blocs/login_bloc/login_bloc.dart';
import 'package:assignment0/blocs/login_bloc/login_event.dart';
import 'package:assignment0/blocs/login_bloc/login_state.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_bloc.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_event.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_state.dart';
import 'package:assignment0/controllers/sqlite_controller.dart';
import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/models/logged_in_user_info.dart';
import 'package:assignment0/models/place_weather_response.dart';
import 'package:assignment0/screens/search_city_screen.dart';
import 'package:assignment0/utils/assets.dart';
import 'package:assignment0/utils/color_consts.dart';
import 'package:assignment0/utils/common_appbar.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/separator.dart';
import 'package:assignment0/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationBloc>(context).add(const DeviceLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      gradientColorList: ColorConsts.gradientColorList,
      child: Column(
        children: [
          const CommonAppbar(bannerAssetPath: Assets.weatherBanner),
          24.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BuildLoggedInUserInfo(),
                  24.verticalSpace,
                  buildBtnRow(context),
                  24.verticalSpace,
                  const BuildBlocConsumerContent(),
                  24.verticalSpace,
                  const Separator(),
                  24.verticalSpace,
                  const SearchedPlaceWeatherInfo(),
                ],
              ),
            ),
          ),
        ],
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
              SchedulerBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const SearchCityScreen(),
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: const Text("Get other city weather info")
                    .padAll(value: 12),
              ),
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: InkWell(
            onTap: () {
              BlocProvider.of<LoginBloc>(context).add(const UserLogoutEvent());
              SchedulerBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.pop(context);
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: const Text("Log out").padAll(value: 12)),
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
      listener: (ctx, state) {},
      builder: (ctx, state) {
        if (state is UserLoggedInStartupState) {
          final list = state.list;
          if (list.isNotEmpty) {
            return Text("userInfo : " + list[0].displayName.toString());
          }
        }
        return Text("user info not found in db");
      },
    );
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
          debugPrint("search city startup Event");
          final locationInfo = state.locationInfo;
          if (locationInfo.isNotEmpty) {
            final String weatherCondition = locationInfo[0].weatherCondition;
            final String temperature = locationInfo[0].temperature;
            final String location = locationInfo[0].location;
            final String countryCode = locationInfo[0].countryCode;
            debugPrint(location);
            final country = countryCode.getCountryEnumFromString;

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text("Weather Info :: $location $country")
                      .padAll(value: 12),
                ),
                12.verticalSpace,
                WeatherInfo(
                  isDbDataAvailed: true,
                  weatherCondition: weatherCondition,
                  temperature: temperature,
                  location: location,
                  country: country,
                ),
              ],
            );
          }
          return Text("Searced location info not found in db");
        }

        if (state is CityLoadingState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Fetching data..."),
              12.horizontalSpace,
              const CircularProgressIndicator(
                color: Colors.black,
              )
            ],
          );
        }
        if (state is SearchCityWeatherEmptyState) {
          return Text(state.msg);
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
                child: Text("Weather Info :: $location $country")
                    .padAll(value: 12),
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

class BuildBlocConsumerContent extends StatelessWidget {
  const BuildBlocConsumerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LocationStartupState) {
          debugPrint("device location startup Event");
          final locationInfo = state.locationInfo;
          if (locationInfo.isNotEmpty) {
            final String weatherCondition = locationInfo[0].weatherCondition;
            final String temperature = locationInfo[0].temperature;
            final String location = locationInfo[0].location;
            final String countryCode = locationInfo[0].countryCode;
            debugPrint(location);
            final country = countryCode.getCountryEnumFromString;

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text("Weather Info :: $location $country")
                      .padAll(value: 12),
                ),
                12.verticalSpace,
                WeatherInfo(
                  isDbDataAvailed: true,
                  weatherCondition: weatherCondition,
                  temperature: temperature,
                  location: location,
                  country: country,
                ),
              ],
            );
          }
          return Text("Device location info not found in db");
        }

        if (state is LocationLoadingState) {
          return const BuildLoadingState();
        } else if (state is LocationErrorState) {
          return BuildErrorState(msg: state.msg);
        } else if (state is WeatherDataEmptyState) {
          return BuildEmptyState(msg: state.msg);
        } else if (state is WeatherDataState) {
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
                        "Weather Info  (device location) :: $location  $country")
                    .padAll(value: 12),
              ),
              12.verticalSpace,
              BuildWeatherSuccessState(weatherResponse: data),
            ],
          );
        }
        return Text("home screen : Init state :: $state ");
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
        const Text("Fetching weather info"),
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
    return Text(msg);
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
    return Text(msg);
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