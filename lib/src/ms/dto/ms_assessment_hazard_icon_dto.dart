import 'package:pdf/widgets.dart';

class MsAssessmentHazardIconDto {
  int? id;
  String? iconUrl;
  String? imagePath;
  int? order;
  int? headerCloudId;
  String? uniqueKey;
  int? cloudUserId;
  int? templateCloudId;
  int? cloudCompanyId;

  String? msUniqueKey;

  int? isDeleted;

  MemoryImage? memoryImage;

  String ? iconPath;


  MsAssessmentHazardIconDto({
    this.id,
    this.iconUrl,
    this.imagePath,
    this.order,
    this.headerCloudId,
    this.uniqueKey,
    this.cloudUserId,
    this.templateCloudId,
    this.cloudCompanyId,
    this.msUniqueKey,
    this.isDeleted,
    this.memoryImage,
    this.iconPath,

  });

  factory MsAssessmentHazardIconDto.fromJson(Map<String, dynamic> json) {
    return MsAssessmentHazardIconDto(
      id: json['id'] as int?,
      iconUrl: json['iconUrl'] as String?,
      imagePath: json['imagePath'] as String?,
      order: json['order'] as int?,
      headerCloudId: json['headerCloudId'] as int?,
      uniqueKey: json['uniqueKey'] as String?,
      cloudUserId: json['cloudUserId'] as int?,
      templateCloudId: json['templateCloudId'] as int?,
      cloudCompanyId: json['cloudCompanyId'] as int?,
      msUniqueKey: json['msUniqueKey'] as String?,
      isDeleted: json['isDeleted'] as int?,
      iconPath:  json["image_path"] as String? 
      
      // MemoryImage cannot be directly created from JSON,
      // so it’s not included here. Handle image deserialization separately if needed.
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iconUrl': iconUrl,
      'imagePath': imagePath,
      'order': order,
      'headerCloudId': headerCloudId,
      'uniqueKey': uniqueKey,
      'cloudUserId': cloudUserId,
      'templateCloudId': templateCloudId,
      'cloudCompanyId': cloudCompanyId,
      'msUniqueKey': msUniqueKey,
      'isDeleted': isDeleted,
      // MemoryImage is not included in JSON as it cannot be directly serialized
    };
  }
}
