

import 'package:assignment0/utils/assets.dart';

enum Country {
  india,
  nepal,
  bhutan,
  myanmar,
  lanka,
  none,
}

extension CountryInfoExt on Country {
  String get getCountryName {
    switch (this) {
      case Country.india:
        return "India";
      case Country.nepal:
        return "Nepal";
      case Country.bhutan:
        return "Bhutan";
      case Country.myanmar:
        return "Myanmar";
      case Country.lanka:
        return "Sri Lanka";
      default:
        return "";
    }
  }

  String get getISOCountryCodes {
    switch (this) {
      case Country.india:
        return "IN";
      case Country.nepal:
        return "NP";
      case Country.bhutan:
        return "BT";
      case Country.myanmar:
        return "MM";
      case Country.lanka:
        return "LK";
      default:
        return "";
    }
  }

  String get getAssetPath {
    switch (this) {
      case Country.india:
        return Assets.indiaFlag;
      case Country.nepal:
        return Assets.nepalFlag;
      case Country.bhutan:
        return Assets.bhutanFlag;
      case Country.myanmar:
        return Assets.myanmarFlag;
      case Country.lanka:
        return Assets.lankaFlag;
      default:
        return "";
    }
  }
}

extension FlagExt on String {
  Country get getCountryEnumFromString {
    switch (this) {
      case "IN":
        return Country.india;
      case "NP":
        return Country.nepal;
      case "BT":
        return Country.bhutan;
      case "MM":
        return Country.myanmar;
      case "LK":
        return Country.lanka;
      default:
        return Country.none;
    }
  }
}
