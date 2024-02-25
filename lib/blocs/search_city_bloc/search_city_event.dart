import 'package:assignment0/models/location_info.dart';
import 'package:equatable/equatable.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
}

class SearchCityStartupEvent extends CityEvent {
  final List<LocationInfo>? locationInfo;

  const SearchCityStartupEvent({this.locationInfo});

  @override
  List<Object?> get props => [locationInfo];
}

class SearchCityEvent extends CityEvent {
  final String? city;

  const SearchCityEvent({this.city});

  @override
  List<Object?> get props => [city];
}

class FetchCityWeatherEvent extends CityEvent {
  final String? city;

  const FetchCityWeatherEvent({this.city});

  @override
  List<Object?> get props => [city];
}
