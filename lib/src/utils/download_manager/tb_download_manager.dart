import 'dart:typed_data';

import 'package:dart_pdf_package/src/utils/extensions/index.dart';
import 'package:dart_pdf_package/src/utils/tb_file_manager/tb_file_manager.dart';
import 'package:dio/dio.dart';
import 'package:pdf/widgets.dart' as pw;
import 'tb_download_item.dart';

class TbDownloadManager {
  final int? maxConcurrentDownloads;
  final List<TbDownloadItem> urls;
  final String? uniqueKey;

  TbDownloadManager({
    this.maxConcurrentDownloads = 10,
    this.uniqueKey,
    required this.urls,
  });

  Future<void> start() async {
    List<List<TbDownloadItem>> chunksArray = [];
    var maxDownloads = maxConcurrentDownloads ?? 0;

    List<TbDownloadItem> updatedList = [];
    for (var item in urls) {
      updatedList.add(item);
    }
    if (updatedList.isEmpty) {
      return;
    }

    for (int i = 0; i < updatedList.length; i += maxDownloads) {
      int endIndex = i + maxDownloads;
      endIndex = endIndex > updatedList.length ? updatedList.length : endIndex;
      var chunkUrls = updatedList.sublist(i, endIndex);
      chunksArray.add(chunkUrls);
    }

    await Future.forEach(chunksArray, (imageUrls) async {
      await Future.wait(imageUrls.map((item) async {
        await TbFileManager.downloadImages(
          sourceURL: item.url,
          localPath: item.localPath,
        );
      }).toList());
    });
  }

  static Future<pw.MemoryImage?> downloadFile({
    required String urlPath,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (urlPath.fileName.isEmpty) {
      return null;
    }

    // try {
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
      var imageData = Uint8List.fromList(response.data!);
      final pw.MemoryImage image = pw.MemoryImage(imageData);

      return image;
    } else {
      return null;
    }
    // } catch (e, stacktrace) {
    //   rethrow;
    // }
  }
}
