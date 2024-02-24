import 'package:equatable/equatable.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
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
