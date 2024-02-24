import 'package:assignment0/utils/enums.dart';
import 'package:flutter/material.dart';

class SelectFlagController {
  static Country flag = Country.india;
  static String countryCode = Country.india.getISOCountryCodes;
  static void selectCity({required Country selectedFlag}) {
    flag = selectedFlag;
    countryCode = flag.getISOCountryCodes;
    debugPrint("select city 0 :: $flag $countryCode");
  }
}
