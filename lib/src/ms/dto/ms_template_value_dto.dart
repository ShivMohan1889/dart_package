import 'package:dart_pdf_package/src/utils/date/tb_date_time.dart';

class MsTemplateValueDto {
  int? id;
  String? keyName;
  String? dbKeyName;
  int? templateCloudId;
  int? order;
  String? type;
  String? values;
  int? cloudCompanyId;
  int? cloudUserId;
  String? msUniqueKey;
  int? isDefault;

  MsTemplateValueDto({
    this.id,
    this.keyName,
    this.dbKeyName,
    this.templateCloudId,
    this.order,
    this.type,
    this.cloudCompanyId,
    this.cloudUserId,
    this.values,
    this.msUniqueKey,
    this.isDefault,
  });

  Map<String, dynamic> toJson() {
    String dateForWeb = "";
    if (type == "date") {
      dateForWeb = TbDateTime.dateForWebApis(values ?? "");
    } else {
      dateForWeb = values ?? "";
    }
    return {
      "db_key": dbKeyName,
      "label": keyName,
      "value": dateForWeb,
      "type": type,
      "order": order,
      "is_default": isDefault
    };
  }

  factory MsTemplateValueDto.fromJson(Map<String, dynamic> json) {
    // Handle date parsing if type is "date"
    String? parsedValue;
    if (json['type'] == 'date') {
      parsedValue = TbDateTime.dateForWebApis(json['value']);
    } else {
      parsedValue = json['value'] as String?;
    }

    return MsTemplateValueDto(
      id: json['id'] as int?,
      keyName: json['label'] as String?,
      dbKeyName: json['db_key'] as String?,
      templateCloudId: json['template_cloud_id'] as int?,
      order: json['order'] as int?,
      type: json['type'] as String?,
      values: parsedValue,
      cloudCompanyId: json['cloud_company_id'] as int?,
      cloudUserId: json['cloud_user_id'] as int?,
      msUniqueKey: json['ms_unique_key'] as String?,
      isDefault: json['is_default'] as int?,
    );
  }
}
