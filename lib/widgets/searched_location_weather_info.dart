
import 'package:assignment0/blocs/search_city_bloc/search_city_bloc.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_event.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_state.dart';
import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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