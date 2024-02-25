import 'package:assignment0/screens/home_screen.dart';
import 'package:assignment0/screens/login_screen.dart';
import 'package:assignment0/utils/assets.dart';
import 'package:assignment0/utils/color_consts.dart';
import 'package:assignment0/utils/common_appbar.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => const HomeScreen(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => const LoginScreen(),
              ),
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      gradientColorList: ColorConsts.gradientColorList,
      isWhiteBackground: true,
      child: Column(
        children: [
          const CommonAppbar(
            bannerAssetPath: Assets.weatherBanner,
          ),
          12.verticalSpace,
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedLogo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))
      ..repeat(reverse: true);

    sizeAnimation =
        Tween<double>(begin: 100, end: 300).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (_, __) => Column(
        children: [
          Image.asset(
            Assets.weatherLogo,
            width: sizeAnimation.value,
            height: sizeAnimation.value,
          ),
          12.verticalSpace,
          const Text(
            "Weather App using BLoC",
          ),
        ],
      ),
    );
  }
}
