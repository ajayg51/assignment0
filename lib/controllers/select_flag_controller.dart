import 'package:assignment0/utils/enums.dart';
import 'package:flutter/material.dart';

class SelectFlagController {
  Country flag = Country.india;
  String countryCode = Country.india.getISOCountryCodes;
  void selectCity({required Country selectedFlag}) {
    flag = selectedFlag;
    countryCode = flag.getISOCountryCodes;
    debugPrint("select city 0 :: $flag $countryCode");
  }
}
