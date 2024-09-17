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
}
