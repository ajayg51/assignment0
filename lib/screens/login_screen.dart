import 'package:assignment0/blocs/weather_app_block.dart';
import 'package:assignment0/blocs/weather_app_event.dart';
import 'package:assignment0/blocs/weather_app_state.dart';
import 'package:assignment0/screens/login_screen_controller.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
          gradientColorList: const [
            Colors.blue,
            Colors.purple,
          ],
          child: BlocConsumer<WeatherAppBloc, WeatherAppState>(
            listener: (context, state) {},
            builder: (context, state) {
              String content = "No content";
              if (state is UserLoggedInState && state.userCredential != null) {
                content = state.userCredential.toString();
                return Center(
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
