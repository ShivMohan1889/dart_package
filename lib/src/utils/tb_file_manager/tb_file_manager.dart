import 'dart:async';

import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../extensions/index.dart';

class TbFileManager {
  static final TbFileManager _singleton = TbFileManager._internal();

  factory TbFileManager() {
    return _singleton;
  }

  TbFileManager._internal();

  static Future<void> initialise() async {}

//   /* ************************************** */
//   // DOWNLOAD IMAGES
//   /// * [sourceURL] url of the selected image
//   /// * [localPath] local path of the image where it will be saved
//   /// #
//   /* ************************************** */

  static Future<dynamic> downloadImages({
    required String sourceURL,
    required String localPath,
  }) async {
    var response = await downloadFile(urlPath: sourceURL, localPath: localPath);

    return response;
  }

  static Future<dynamic> downloadFile({
    required String urlPath,
    required String localPath,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (urlPath.fileName.isEmpty) {
      return;
    }

    try {
      var response = await Dio().get(
        urlPath,
        options: Options(
            extra: {"isDownlaoding": true},
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return (status ?? 0) == 200;
            }),
      );

      if (response.statusCode == 200) {
        File file = File(localPath);
        var raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();

        return response;
      }
    } catch (e, stacktrace) {
      // rethrow;
    }
  }
}
