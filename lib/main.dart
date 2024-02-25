import 'package:assignment0/blocs/device_location_bloc/device_location_bloc.dart';
import 'package:assignment0/blocs/login_bloc/login_bloc.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_bloc.dart';
import 'package:assignment0/blocs/select_flag_bloc/flag_bloc.dart';
import 'package:assignment0/db/hive.dart';
import 'package:assignment0/router/routes_controller.dart';
import 'package:assignment0/get_it_register/register_controllers.dart';
import 'package:assignment0/get_it_register/register_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  initialSetup();

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
      child: MyApp(),
    ),
  );
}

void initialSetup() {
  registerControllers();

  registerServices();

  final locator = GetIt.instance;
  locator.get<HiveController>().setupHive();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: appRouter.config(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
