import 'dart:typed_data';

import 'package:dart_pdf_package/src/utils/extensions/index.dart';
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

  Future<Map<String, pw.MemoryImage?>> downloadAll() async {
    List<List<TbDownloadItem>> chunksArray = [];
    var maxDownloads = maxConcurrentDownloads ?? 10;
    Map<String, pw.MemoryImage?> results = {};

    if (urls.isEmpty) {
      return results;
    }

    // Split the URLs into chunks for concurrent downloading
    for (int i = 0; i < urls.length; i += maxDownloads) {
      int endIndex = i + maxDownloads;
      endIndex = endIndex > urls.length ? urls.length : endIndex;
      var chunkUrls = urls.sublist(i, endIndex);
      chunksArray.add(chunkUrls);
    }

    // Process each chunk
    for (var chunk in chunksArray) {
      // Process each chunk concurrently
      List<Future<MapEntry<String, pw.MemoryImage?>>> futures =
          chunk.map((item) async {
        pw.MemoryImage? memoryImage =
            await downloadMemoryImage(urlPath: item.url);
        return MapEntry(item.id, memoryImage);
      }).toList();

      // Wait for this chunk to complete
      List<MapEntry<String, pw.MemoryImage?>> chunkResults =
          await Future.wait(futures);

      // Add the results to our map
      results.addEntries(chunkResults);
    }

    return results;
  }

  static Future<pw.MemoryImage?> downloadMemoryImage({
    required String urlPath,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (urlPath.fileName.isEmpty) {
      print("Invalid file name for URL: $urlPath");
      return null;
    }

    try {
      var response = await Dio().get(
        urlPath,
        options: Options(
          extra: {"isDownloading": true},
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return (status ?? 0) == 200;
          },
        ),
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          (response.data as List).isNotEmpty) {
        Uint8List imageData = Uint8List.fromList(response.data);
        return pw.MemoryImage(imageData);
      } else {
        print("Download failed or empty image at: $urlPath");
        return null;
      }
    } catch (e) {
      print("Error downloading file from $urlPath: $e");
      return null;
    }
  }
}
