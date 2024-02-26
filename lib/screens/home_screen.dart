import 'package:another_flushbar/flushbar.dart';
import 'package:assignment0/blocs/login_bloc/login_bloc.dart';
import 'package:assignment0/blocs/login_bloc/login_event.dart';
import 'package:assignment0/utils/assets.dart';
import 'package:assignment0/utils/color_consts.dart';
import 'package:assignment0/utils/common_appbar.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/route_path.dart';
import 'package:assignment0/utils/separator.dart';
import 'package:assignment0/widgets/device_location_weather_info.dart';
import 'package:assignment0/widgets/searched_location_weather_info.dart';
import 'package:assignment0/widgets/user_info.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if (FirebaseAuth.instance.currentUser != null) {
          SystemNavigator.pop();
        }
      },
      child: CommonScaffold(
        gradientColorList: ColorConsts.gradientColorList,
        child: Column(
          children: [
            const CommonAppbar(bannerAssetPath: Assets.weatherBanner),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    12.verticalSpace,
                    const BuildLoggedInUserInfo(),
                    24.verticalSpace,
                    buildBtnRow(context),
                    24.verticalSpace,
                    const BuildDeviceLocationWeatherInfo(),
                    24.verticalSpace,
                    const Separator(),
                    24.verticalSpace,
                    const SearchedPlaceWeatherInfo(),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBtnRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.pushNamed(RouteEnums.searchCity.getPath);
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Get other city weather info",
                  style: Theme.of(context).textTheme.titleSmall,
                ).padAll(value: 12),
              ),
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: InkWell(
            onTap: () async {
              final isNetOn = await InternetConnection().hasInternetAccess;
              if (isNetOn) {
                if (context.mounted) {
                  BlocProvider.of<LoginBloc>(context).add(
                    const UserLogoutEvent(),
                  );
                }
              } else {
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  Flushbar(
                    duration: const Duration(seconds: 1),
                    title: "Net is off",
                    message: "Please check net connectivity.",
                  ).show(context);
                });
              }
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log out",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ).padAll(value: 12),
                ],
              ),
            ),
          ),
        ),
      ],
    ).padSymmetric(horizontalPad: 12);
  }
}
