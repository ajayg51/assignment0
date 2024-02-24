class PlaceLatLongtdResponse {
  List<PlaceLatLongtdResponseData> list;

  PlaceLatLongtdResponse({
    required this.list,
  });

  factory PlaceLatLongtdResponse.fromList(List<dynamic> list) {
    return PlaceLatLongtdResponse(
      list: List<PlaceLatLongtdResponseData>.from(
        list.map(
          (e) => PlaceLatLongtdResponseData.fromJson(e),
        ),
      ),
    );
  }
}

class PlaceLatLongtdResponseData {
  String name;
  double lat;
  double lon;
  String country;
  String state;

  PlaceLatLongtdResponseData({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory PlaceLatLongtdResponseData.fromJson(Map<String, dynamic> json) =>
      PlaceLatLongtdResponseData(
        name: json["name"] ?? "",
        lat: json["lat"]?.toDouble() ?? 0,
        lon: json["lon"]?.toDouble() ?? 0,
        country: json["country"] ?? "",
        state: json["state"] ?? "",
      );
}
