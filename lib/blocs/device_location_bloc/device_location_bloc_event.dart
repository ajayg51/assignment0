import 'package:assignment0/models/location_info.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class DeviceLocationStartupEvent extends LocationEvent {
  final LocationInfo? locationInfo;

  const DeviceLocationStartupEvent({this.locationInfo});

  @override
  List<Object?> get props => [locationInfo];
}

class DeviceLocationEvent extends LocationEvent {
  final Position? position;

  const DeviceLocationEvent({this.position});

  @override
  List<Object?> get props => [position];
}
