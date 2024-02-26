import 'package:assignment0/router/routes_controller.gr.dart';
import 'package:assignment0/utils/route_path.dart';
import 'package:auto_route/auto_route.dart';

// flutter pub run build_runner watch  - delete-conflicting-outputs
// run it after any new route add

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        // add your routes here
        AutoRoute(
          path: RouteEnums.splash.getPath,
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: RouteEnums.login.getPath,
          page: LoginRoute.page,
        ),
        AutoRoute(
          path: RouteEnums.home.getPath,
          page: HomeRoute.page,
        ),
        AutoRoute(
          path: RouteEnums.searchCity.getPath,
          page: SearchCityRoute.page,
        ),
      ];
}
