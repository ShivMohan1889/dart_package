
import 'package:dart_pdf_package/src/ms/dto/ms_header_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_template_field_dto.dart';

class MsTemplateDto {
  String? name;
  int? id;
  String? userId;
  List<MsTemplateFieldDto>? listFields;
  String? templateHeaderName;

  List<MsHeaderDto>? listHeader;

  int? templateCloudId;
  int? cloudUserId;
  int? cloudCompanyId;
  int? isDeleted;

  MsTemplateDto({
    this.name,
    this.id,
    this.userId,
    this.listFields,
    this.templateHeaderName,
    this.listHeader,
    this.cloudUserId,
    this.cloudCompanyId,
    this.isDeleted,
    this.templateCloudId,
  });

  // fromJson method
  factory MsTemplateDto.fromJson(Map<String, dynamic> json) {
    return MsTemplateDto(
      name: json['name'],
      id: json['id'],
      userId: json['userId'],
      listFields: (json['listFields'] as List?)
          ?.map((e) => MsTemplateFieldDto.fromJson(e))
          .toList(),
      templateHeaderName: json['templateHeaderName'],
      listHeader: (json['listHeader'] as List?)
          ?.map((e) => MsHeaderDto.fromJson(e))
          .toList(),
      cloudUserId: json['cloudUserId'],
      cloudCompanyId: json['cloudCompanyId'],
      isDeleted: json['isDeleted'],
      templateCloudId: json['templateCloudId'],
    );
  }
}
