import 'package:dart_pdf_package/src/ms/dto/ms_header_dto.dart';
import 'package:pdf/widgets.dart';

class MsStatementHazardIconDto {
  int? id;
  String? iconUrl;
  String? imagePath;
  int? order;
  int? headerCloudId;
  String? uniqueKey;
  int? cloudUserId;
  int? templateCloudId;
  int? cloudCompanyId;
  int? isDeleted;

  /// For selection of Ms Statement Hazard Icons
  int? isSelected = 0;

  /// Decides whether we need to show blue or white color
  /// If it is 1 show white else blue color
  int colorIdentifier = 0;
  MsHeaderDto? parentHeader;

  MemoryImage? memoryImage;

  String ?iconPath;


  MsStatementHazardIconDto({
    this.id,
    this.iconUrl,
    this.imagePath,
    this.order,
    this.headerCloudId,
    this.uniqueKey,
    this.cloudUserId,
    this.templateCloudId,
    this.cloudCompanyId,
    this.isSelected = 0,
    this.isDeleted,
    this.colorIdentifier = 0,
    this.parentHeader,
    this.memoryImage,
    this.iconPath,

  });

  // Convert a JSON map to an instance of MsStatementHazardIconDto
  factory MsStatementHazardIconDto.fromJson(Map<String, dynamic> json) {
    return MsStatementHazardIconDto(
      id: json['id'],
      iconUrl: json['iconUrl'],
      imagePath: json['imagePath'],
      order: json['order'],
      headerCloudId: json['headerCloudId'],
      uniqueKey: json['uniqueKey'],
      cloudUserId: json['cloudUserId'],
      templateCloudId: json['templateCloudId'],
      cloudCompanyId: json['cloudCompanyId'],
      isSelected: json['isSelected'] ?? 0,
      isDeleted: json['isDeleted'],
      colorIdentifier: json['colorIdentifier'] ?? 0,
      parentHeader: json['parentHeader'] != null
          ? MsHeaderDto.fromJson(json['parentHeader'])
          : null,

      iconPath:   json["image_path"] as String? 
      // MemoryImage cannot be directly constructed from JSON,
      // so you may need to handle this field separately if needed.
    );
  }

  // Convert an instance of MsStatementHazardIconDto to a JSON map
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
      'isSelected': isSelected,
      'isDeleted': isDeleted,
      'colorIdentifier': colorIdentifier,
      'parentHeader': parentHeader?.toJson(),
      // MemoryImage cannot be serialized directly to JSON,
      // so you may need to handle this field separately if needed.
    };
  }
}
