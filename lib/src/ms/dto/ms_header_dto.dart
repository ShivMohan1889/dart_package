
import 'package:dart_pdf_package/src/ms/dto/ms_statement_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_statement_hazard_icon_dto.dart';

class MsHeaderDto {
  int? id;
  int? headerCloudId;
  String? name;
  int? order;
  int? templateCloudId;
  int? headerType;
  int? parentHeaderId;
  int? childHeaderId;
  int? isDeleted;
  int? cloudUserId;
  int? cloudCompanyId;

  /// Decides whether to show white or blue color
  /// If it is 1, show white; else, blue color
  int colorIdentifier = 0;
  MsHeaderDto? parentHeader;

  // This field is used only for creating the PDF of MS
  // Used to show MS header in PDF
  int? isHeaderSelected = 0;

  // This field is used only for creating the PDF
  // Used for deciding the font size and style
  int isHeaderLevel = 0;

  List<MsStatementDto>? listMsStatement;
  List<MsHeaderDto>? listMsHeaderDto;

  List<MsStatementHazardIconDto>? listMsStatementHazardIcons;

  // This field is used only to show the index reference of MS Assessment in PDF
  List<String>? listMsAssessmentImageIndex;

  MsHeaderDto({
    this.id,
    this.name,
    this.order,
    this.headerCloudId,
    this.templateCloudId,
    this.headerType,
    this.parentHeaderId,
    this.childHeaderId,
    this.isDeleted,
    this.cloudUserId,
    this.cloudCompanyId,
    this.listMsStatement,
    this.listMsStatementHazardIcons,
    this.listMsHeaderDto,
    this.colorIdentifier = 0,
    this.isHeaderSelected = 0,
    this.isHeaderLevel = 0,
    this.listMsAssessmentImageIndex,
  });

  // fromJson method
  factory MsHeaderDto.fromJson(Map<String, dynamic> json) {
    return MsHeaderDto(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      headerCloudId: json['headerCloudId'],
      templateCloudId: json['templateCloudId'],
      headerType: json['headerType'],
      parentHeaderId: json['parentHeaderId'],
      childHeaderId: json['childHeaderId'],
      isDeleted: json['isDeleted'],
      cloudUserId: json['cloudUserId'],
      cloudCompanyId: json['cloudCompanyId'],
      colorIdentifier: json['colorIdentifier'] ?? 0,
      isHeaderSelected: json['isHeaderSelected'] ?? 0,
      isHeaderLevel: json['isHeaderLevel'] ?? 0,
      listMsStatement: (json['listMsStatement'] as List?)
          ?.map((e) => MsStatementDto.fromJson(e))
          .toList(),
      listMsHeaderDto: (json['listMsHeader'] as List?)
          ?.map((e) => MsHeaderDto.fromJson(e))
          .toList(),
      listMsStatementHazardIcons: (json['listMsStatementHazardIcons'] as List?)
          ?.map((e) => MsStatementHazardIconDto.fromJson(e))
          .toList(),
      listMsAssessmentImageIndex: (json['listMsAssessmentImageIndex'] as List?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'headerCloudId': headerCloudId,
      'name': name,
      'order': order,
      'templateCloudId': templateCloudId,
      'headerType': headerType,
      'parentHeaderId': parentHeaderId,
      'childHeaderId': childHeaderId,
      'isDeleted': isDeleted,
      'cloudUserId': cloudUserId,
      'cloudCompanyId': cloudCompanyId,
      'colorIdentifier': colorIdentifier,
      'isHeaderSelected': isHeaderSelected,
      'isHeaderLevel': isHeaderLevel,
      'listMsStatement': listMsStatement?.map((e) => e.toJson()).toList(),
      'listMsHeaderDto': listMsHeaderDto?.map((e) => e.toJson()).toList(),
      'listMsStatementHazardIcons':
          listMsStatementHazardIcons?.map((e) => e.toJson()).toList(),
      'listMsAssessmentImageIndex': listMsAssessmentImageIndex,
    };
  }
}
