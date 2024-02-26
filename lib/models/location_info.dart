class LocationInfo {
  final String loc;
  final String weatherCondition;
  final String temperature;
  final String location;
  final String countryCode;
  LocationInfo({
    required this.loc,
    required this.weatherCondition,
    required this.temperature,
    required this.location,
    required this.countryCode,
  });

  factory LocationInfo.fromMap(Map<String, dynamic> map) {
    return LocationInfo(
      loc: map["loc"] ?? "",
      weatherCondition: map["weatherCondition"] ?? "",
      temperature: map["temperature"] ?? "",
      location: map["location"] ?? "",
      countryCode: map["countryCode"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "loc": loc,
      'weatherCondition': weatherCondition,
      'temperature': temperature,
      'location': location,
      'countryCode': countryCode,
    };
  }
}
