import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}


class DeviceLocationEvent extends LocationEvent {
  final Position? position;

  const DeviceLocationEvent({this.position});

  @override
  List<Object?> get props => [position];
}

