import 'dart:convert';

import 'package:uuid/uuid.dart';

class Utils {
  static var _theUuid = const Uuid();

  static String uuid() {
    String key = Utils._theUuid.v4();

    // if (Platform.isIOS == true) {
    //   key = "iOS_$key";
    // } else {
    //   key = "Android_$key";
    // }
    return key;
  }

  static Map<String, dynamic> mapFromJsonString(String jsonString) {
    return jsonDecode(jsonString);
  }

    static String hazardGridCellIdentifier(int number) {
    int row = (number ~/ 13) + 1;
    int col = (number % 13) + 1;
    String columnLetter = String.fromCharCode(64 + row);
    return "$columnLetter$col";
  }

  static int hazardGridCellIndex(String cell) {
    int col = cell.codeUnitAt(0) - 65;
    int row = int.parse(cell.substring(1));
    return (col * 13) + row;
  }



  static double convertToOpacity(int sliderValue) {
    // Convert slider value (1-10) to opacity (0.1-1.0)
    return sliderValue / 10;
  }

}
