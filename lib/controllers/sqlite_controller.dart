import 'package:assignment0/models/location_info.dart';
import 'package:assignment0/models/logged_in_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SqliteController {
  static Database? db;
  static const userTableName = "userInfo";
  static const locationTableName = "locationInfo";

  static const userTable = '''
          CREATE TABLE $userTableName(id INTEGER PRIMARY KEY AUTOINCREMENT,
          displayName TEXT,
          email TEXT,
          photoUrl TEXT,
          uid TEXT
          )
        ''';

  static const locationTable = '''
          CREATE TABLE $locationTableName(id INTEGER PRIMARY KEY AUTOINCREMENT,
          weatherCondition TEXT,
          temperature TEXT,
          location TEXT,
          countryCode TEXT
          )
        ''';

  static Future<bool> dbInit() async {
    db = await initializeDB();
    if (db != null) {
      return true;
    }
    return false;
  }

  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    path += "/appDB1.db";

    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute(userTable);
        await database.execute(locationTable);
      },
      version: 1,
    );
  }

  static Future<void> createUserRecord(LoggedInUserInfo userInfo) async {
    if (db == null) {
      debugPrint("DB not found");
      return;
    }
    try {
      await db!.insert(
        userTableName,
        userInfo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint("user info insertion Success ");
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  static Future<List<LoggedInUserInfo>> getUserItems() async {
    List<Map<String, Object?>> list = [];

    try {
      final db = await SqliteController.initializeDB();
      list = await db.query(userTableName);
    } catch (e) {
      debugPrint("error :: $e");
    }

    return list.map((e) => LoggedInUserInfo.fromMap(e)).toList();
  }

  static Future<void> createLocationRecord(LocationInfo userInfo) async {
    if (db == null) {
      debugPrint("DB not found");
      return;
    }

    try {
      await db!.insert(
        locationTableName,
        userInfo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint("location info insertion Success ");
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  static Future<List<LocationInfo>> getLocationItems() async {
    List<Map<String, Object?>> list = [];

    try {
      final db = await SqliteController.initializeDB();
      list = await db.query(locationTableName);
    } catch (e) {
      debugPrint("error :: $e");
    }

    return list.map((e) => LocationInfo.fromMap(e)).toList();
  }
}
