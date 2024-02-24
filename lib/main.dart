import 'package:assignment0/blocs/device_location_bloc/device_location_bloc.dart';
import 'package:assignment0/blocs/login_bloc/login_bloc.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_bloc.dart';
import 'package:assignment0/blocs/select_flag_bloc/flag_bloc.dart';
import 'package:assignment0/screens/home_screen.dart';
import 'package:assignment0/screens/login_screen.dart';
import 'package:assignment0/screens/search_city_screen.dart';
import 'package:assignment0/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {


  // TODO : add enum for all states

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        // For login

        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),

        // For location

        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(),
        ),

        // For city search

        BlocProvider<SearchCityBloc>(
          create: (context) => SearchCityBloc(),
        ),

        //  for flag set

        BlocProvider<FlagBloc>(
          create: (context) => FlagBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      // home: LoginScreen(),
      // home: HomeScreen(),
      // home: SearchCityScreen(),
    );
  }
}
