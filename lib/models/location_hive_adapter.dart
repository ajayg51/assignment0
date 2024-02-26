import 'package:assignment0/models/location_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocationHiveAdapter extends TypeAdapter<LocationInfo> {
  @override
  int get typeId => 1;

  @override
  LocationInfo read(BinaryReader reader) {
    final weatherCondition = reader.read();
    final temperature = reader.read();
    final location = reader.read();
    final countryCode = reader.read();
    final curLoc = reader.read();

    return LocationInfo(
      loc: curLoc,
      weatherCondition: weatherCondition,
      temperature: temperature,
      location: location,
      countryCode: countryCode,
    );
  }

  @override
  void write(BinaryWriter writer, LocationInfo locationInfo) {
    
    // reorder writes to match corresponding instance variable

    writer.write(locationInfo.weatherCondition);
    writer.write(locationInfo.temperature);
    writer.write(locationInfo.location);
    writer.write(locationInfo.countryCode);
    writer.write(locationInfo.loc); 
  }
}
