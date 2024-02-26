import 'dart:io';

import 'package:assignment0/models/google_auth_hive_adapter.dart';
import 'package:assignment0/models/location_hive_adapter.dart';
import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/models/logged_in_user_info.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveController {
  void setupHive() async {
    debugPrint("Hive setup");

    Directory directory = await getApplicationDocumentsDirectory();

    Hive.registerAdapter<LoggedInUserInfo>(GoogleAuthHiveAdapter());
    Hive.registerAdapter<LocationInfo>(LocationHiveAdapter());

    // TODO : Important on every new variable addition in LocationInfo change db path
    // for error not enough bytes available

    await Hive.initFlutter(directory.path + "app2");

    await Hive.openBox<LoggedInUserInfo>("user");
    await Hive.openBox<LocationInfo>("location");
  }
}
