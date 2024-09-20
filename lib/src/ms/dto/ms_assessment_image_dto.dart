import 'dart:typed_data';
import 'package:pdf/widgets.dart';

class MsAssessmentImageDto {
  MsAssessmentImageDto({
    this.localPath,
    this.order,
    this.isSelected,
    this.msUniqueKey,
    this.imageBytes,
    this.headerCloudId,
    this.cloudUserId,
    this.templateCloudId,
    this.cloudCompanyId,
    this.referenceNo,
    this.uniqueKey,
    this.image,
    this.memoryImage,
    this.imagePath,

  });

  String? localPath;
  int? order;
  int? isSelected;
  String? msUniqueKey;
  Uint8List? imageBytes;
  int? headerCloudId;
  int? cloudUserId;
  int? templateCloudId;
  int? cloudCompanyId;
  String? referenceNo;
  String? uniqueKey;
  String? image;
  MemoryImage? memoryImage;
  String? uniqueKeyToUpload;
  String? imagePath;


  // Convert a JSON map to an instance of MsAssessmentImageDto
  factory MsAssessmentImageDto.fromJson(Map<String, dynamic> json) {
    return MsAssessmentImageDto(
      localPath: json['localPath'],
      order: json['order'],
      isSelected: json['isSelected'],
      msUniqueKey: json['msUniqueKey'],
      // imageBytes: json['imageBytes'] != null
      //     ? Uint8List.fromList(List<int>.from(json['imageBytes']))
      //     : null,
      
      headerCloudId: json['headerCloudId'],
      cloudUserId: json['cloudUserId'],
      templateCloudId: json['templateCloudId'],
      cloudCompanyId: json['cloudCompanyId'],
      referenceNo: json['referenceNo'],
      uniqueKey: json['uniqueKey'],
      image: json['image'],
      // memoryImage: json['memoryImage'] != null
      //     ? MemoryImage(Uint8List.fromList(List<int>.from(json['memoryImage'])))
      //     : null,
       imagePath:   json["image_path"]  as String?
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "header_unique_key": headerCloudId,
      "image_key": uniqueKey,
      // You may need to convert imageBytes to a suitable format for JSON
      "image_bytes":
          imageBytes?.toList(), // if imageBytes needs to be included in JSON
    };
  }
}
