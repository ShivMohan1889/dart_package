import 'package:dart_pdf_package/src/ms/dto/ms_header_dto.dart';

class MsStatementDto {
  int? id;
  String? statementName;
  int? order;
  int? headerCloudId;
  String? uniqueKey;
  int? cloudUserId;
  int? templateCloudId;
  int? cloudCompanyId;
  int? isDeleted;
  int? isCustom;

  /// Decides whether to show blue or white color
  /// If it is 1, show white; else, blue color
  int colorIdentifier = 0;

  MsHeaderDto? parentHeader;
  int? isSelected = 0;

  int? addedOnlyForPdf = 0;

  MsStatementDto({
    this.id,
    this.statementName,
    this.order,
    this.headerCloudId,
    this.uniqueKey,
    this.cloudUserId,
    this.templateCloudId,
    this.cloudCompanyId,
    this.isDeleted,
    this.colorIdentifier = 0,
    this.isSelected = 0,
    this.parentHeader,
    this.isCustom,
  });

  // fromJson method
  factory MsStatementDto.fromJson(Map<String, dynamic> json) {
    return MsStatementDto(
      id: json['id'],
      statementName: json['statementName'],
      order: json['order'],
      headerCloudId: json['headerCloudId'],
     
      uniqueKey: json['uniqueKey'],
      cloudUserId: json['cloudUserId'],
      templateCloudId: json['templateCloudId'],
      cloudCompanyId: json['cloudCompanyId'],
      isDeleted: json['isDeleted'],
      colorIdentifier: json['colorIdentifier'] ?? 0,
      isSelected: json['isSelected'] ?? 0,
      parentHeader: json['parentHeader'] != null
          ? MsHeaderDto.fromJson(json['parentHeader'])
          : null,
      isCustom: json['isCustom'],
      
      
      // : json['addedOnlyForPdf'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'statementName': statementName,
      'order': order,
      'headerCloudId': headerCloudId,
      'uniqueKey': uniqueKey,
      'cloudUserId': cloudUserId,
      'templateCloudId': templateCloudId,
      'cloudCompanyId': cloudCompanyId,
      'isDeleted': isDeleted,
      'colorIdentifier': colorIdentifier,
      'isSelected': isSelected,
      'parentHeader': parentHeader?.toJson(),
      'isCustom': isCustom,
      'addedOnlyForPdf': addedOnlyForPdf,
    };
  }
}
