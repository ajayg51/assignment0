enum RouteEnums {
  splash,
  login,
  home,
  searchCity,
}

extension RouteEnumExt on RouteEnums {
  String get getPath {
    switch (this) {
      case RouteEnums.splash:
        return "/splash";
      case RouteEnums.login:
        return "/login";
      case RouteEnums.home:
        return "/home";
      case RouteEnums.searchCity:
        return "/searchCity";
      default:
        return "";
    }
  }
}
