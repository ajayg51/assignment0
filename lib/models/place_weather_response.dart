class PlaceWeatherResponse {
  Coord? coord;
  List<Weather> weather;
  Main? main;
  Wind? wind;
  Clouds? clouds;
  Sys? sys;
  String base;
  String name;
  int visibility;
  int dt;
  int timezone;
  int id;
  int cod;

  PlaceWeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory PlaceWeatherResponse.fromJson(Map<String, dynamic> map) =>
      PlaceWeatherResponse(
        coord: map["coord"] == null ? null : Coord.fromJson(map["coord"]),
        weather: map["weather"] == null
            ? []
            : List<Weather>.from(
                map["weather"].map(
                  (x) => Weather.fromJson(x),
                ),
              ),
        base: map["base"] ?? "",
        main: map["main"] == null ? null : Main.fromJson(map["main"]),
        visibility: map["visibility"]?.toInt() ?? 0,
        wind: map["wind"] == null ? null : Wind.fromJson(map["wind"]),
        clouds: map["clouds"] == null ? null : Clouds.fromJson(map["clouds"]),
        dt: map["dt"]?.toInt() ?? 0,
        sys: map["sys"] == null ? null : Sys.fromJson(map["sys"]),
        timezone: map["timezone"]?.toInt() ?? 0,
        id: map["id"]?.toInt() ?? 0,
        name: map["name"] ?? "",
        cod: map["cod"]?.toInt() ?? 0,
      );

  factory PlaceWeatherResponse.empty() => PlaceWeatherResponse.fromJson({});
  

}

class Clouds {
  int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"]?.toInt() ?? 0,
      );
}

class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble() ?? 0,
        lat: json["lat"]?.toDouble() ?? 0,
      );
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble() ?? 0,
        feelsLike: json["feels_like"]?.toDouble() ?? 0,
        tempMin: json["temp_min"]?.toDouble() ?? 0,
        tempMax: json["temp_max"]?.toDouble() ?? 0,
        pressure: json["pressure"]?.toInt() ?? 0,
        humidity: json["humidity"]?.toInt() ?? 0,
        seaLevel: json["sea_level"]?.toInt() ?? 0,
        grndLevel: json["grnd_level"]?.toInt() ?? 0,
      );
}

class Sys {
  String country;
  int sunrise;
  int sunset;

  Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"] ?? "",
        sunrise: json["sunrise"]?.toInt() ?? 0,
        sunset: json["sunset"]?.toInt() ?? 0,
      );
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"]?.toInt() ?? 0,
        main: json["main"] ?? "",
        description: json["description"] ?? "",
        icon: json["icon"] ?? "",
      );
}

class Wind {
  double speed;
  double gust;
  int deg;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble() ?? 0,
        gust: json["gust"]?.toDouble() ?? 0,
        deg: json["deg"]?.toInt() ?? 0,
      );
}
