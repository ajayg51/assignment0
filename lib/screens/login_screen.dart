import 'package:assignment0/blocs/weather_app_block.dart';
import 'package:assignment0/blocs/weather_app_event.dart';
import 'package:assignment0/blocs/weather_app_state.dart';
import 'package:assignment0/screens/home_screen.dart';
import 'package:assignment0/utils/color_consts.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherAppBloc>(context).add(const UserLogInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CommonScaffold(
          gradientColorList: ColorConsts.gradientColorList,
          child: BlocConsumer<WeatherAppBloc, WeatherAppState>(
            listener: (context, state) {
              if (state is UserLoggedInState && state.userCredential != null) {
                // TODO:  Will use get_it for routing

                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (ctx) => HomeScreen()));
              }
            },
            builder: (context, state) {
              String content = "No content";
              if (state is UserLoggedInState) {
                if (state.userCredential != null) {
                  content = state.userCredential.toString();
                  return Center(
                    child: Text(
                      content,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                } else {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ],
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
