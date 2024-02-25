import 'package:another_flushbar/flushbar.dart';
import 'package:assignment0/blocs/login_bloc/login_bloc.dart';
import 'package:assignment0/blocs/login_bloc/login_event.dart';
import 'package:assignment0/blocs/login_bloc/login_state.dart';
import 'package:assignment0/models/logged_in_user_info.dart';
import 'package:assignment0/screens/home_screen.dart';
import 'package:assignment0/utils/assets.dart';
import 'package:assignment0/utils/color_consts.dart';
import 'package:assignment0/utils/common_appbar.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/route_path.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CommonScaffold(
          gradientColorList: ColorConsts.gradientColorList,
          child: Column(
            children: [
              const CommonAppbar(bannerAssetPath: Assets.weatherBanner),
              24.verticalSpace,
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildContent extends StatefulWidget {
  const BuildContent({super.key});

  @override
  State<BuildContent> createState() => _BuildContentState();
}

class _BuildContentState extends State<BuildContent> {
  void navigateToHomeScreen() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        // Flushbar(
        //   message: "Login successful!",
        //   duration: const Duration(seconds: 1),
        // ).show(context);

        context.router.pushNamed(RouteEnums.home.getPath);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomeScreen(),
        //   ),
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is UserLoggedInState && state.userCredential != null) {
          // TODO:  Will use get_it for routing
          navigateToHomeScreen();
        } else {
          // SchedulerBinding.instance.addPostFrameCallback((_) {
          //   Flushbar(
          //     message: "Please log in first.",
          //     duration: const Duration(seconds: 1),
          //   ).show(context);
          // });
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return const BuildLoginState(
            msg: "Trying to log you in",
          );
        } else if (state is LoginErrorState) {
          return BuildLoginErrorState(msg: state.msg);
        } else if (state is UserLoggedInState) {
          String content = "No content";
          content = state.userCredential.toString();
          return const SizedBox.shrink();
          return BuildLogInSuccessState(content: content);
        }
        return InkWell(
          onTap: () {
            BlocProvider.of<LoginBloc>(context).add(const UserLoginEvent());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Click here to log in",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ).padAll(value: 12),
          ).padSymmetric(horizontalPad: 12),
        );
      },
    );
  }
}

class BuildLoginState extends StatelessWidget {
  const BuildLoginState({
    super.key,
    required this.msg,
  });
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          msg,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        12.horizontalSpace,
        const CircularProgressIndicator(
          color: Colors.black,
        ),
      ],
    );
  }
}

class BuildLoginErrorState extends StatelessWidget {
  const BuildLoginErrorState({
    super.key,
    required this.msg,
  });
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          msg,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class BuildLogInSuccessState extends StatelessWidget {
  const BuildLogInSuccessState({
    super.key,
    required this.content,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ).padSymmetric(horizontalPad: 12);
  }
}
