import 'package:assignment0/blocs/weather_app_block.dart';
import 'package:assignment0/blocs/weather_app_event.dart';
import 'package:assignment0/blocs/weather_app_state.dart';
import 'package:assignment0/controllers/device_location_controller.dart';
import 'package:assignment0/screens/search_city_screen.dart';
import 'package:assignment0/utils/color_consts.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherAppBloc>(context).add(const DeviceLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      gradientColorList: ColorConsts.gradientColorList,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          20.verticalSpace,
          BlocConsumer<WeatherAppBloc, WeatherAppState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingState) {
                if (state.isLoading == true) {
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
              } else if (state is ErrorState) {
                return Text(state.msg.toString());
              } else if (state is WeatherDataEmptyState) {
                return Text(state.msg.toString());
              } else if (state is DeviceLocationState) {
                return Text(state.position.toString());
              } else if (state is WeatherDataState) {
                return const SearchCityScreen();

                // return WeatherInfo(weatherResponse: state.weatherResponse);
              }
              return Text(state.toString());
            },
          ),
        ],
      ),
    );
  }
}
