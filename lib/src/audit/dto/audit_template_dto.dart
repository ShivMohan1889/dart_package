import 'audit_template_field_dto.dart';
import 'section_dto.dart';

class AuditTemplateDto {
  String? name;
  int? adminId;
  String? templateHeader;
  int? tableStatus;
  int? id;
  int? isDelete;
  List<AuditTemplateFieldDto>? variables;
  List<SectionDto>? sectionsDto;
  int? templateCloudId;
  int? cloudUserId;
  int? cloudCompanyId;
  String? values;

  /// Use for chain options
  String? chainStatus;

  AuditTemplateDto({
    this.name,
    this.adminId,
    this.templateHeader,
    this.tableStatus,
    this.id,
    this.isDelete,
    this.variables,
    this.sectionsDto,
    this.templateCloudId,
    this.cloudUserId,
    this.cloudCompanyId,
    this.values,
    this.chainStatus,
  });

  // Factory constructor to create an instance from JSON
  factory AuditTemplateDto.fromJson(Map<String, dynamic> json) {
    return AuditTemplateDto(
      name: json['name'],
      adminId: json['admin_id'],
      templateHeader: json['template_header'],
      tableStatus: json['table_status'],
      id: json['id'],
      isDelete: json['is_delete'],
      variables: (json['variables'] as List<dynamic>?)
          ?.map((e) => AuditTemplateFieldDto.fromJson(e))
          .toList(),
      sectionsDto: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionDto.fromJson(e))
          .toList(),
      templateCloudId: json['template_cloud_id'],
      cloudUserId: json['cloud_user_id'],
      cloudCompanyId: json['cloud_company_id'],
      values: json['values'],
      chainStatus: json['chain_status'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'admin_id': adminId,
      'template_header': templateHeader,
      'table_status': tableStatus,
      'id': id,
      'is_delete': isDelete,
      'variables': variables?.map((e) => e.toJson()).toList(),
      'sections': sectionsDto?.map((e) => e.toJson()).toList(),
      'template_cloud_id': templateCloudId,
      'cloud_user_id': cloudUserId,
      'cloud_company_id': cloudCompanyId,
      'values': values,
      'chain_status': chainStatus,
    };
  }
}
