
import 'package:dart_pdf_package/src/utils/extensions/string_extension.dart';

class MsAssessmentStatementDto {
  int? id;
  String? statementName;
  int? order;
  String? uniqueKey;
  String? originalStatementUniqueKey;
  int? headerCloudId;
  int? cloudUserId;
  int? templateCloudId;
  int? cloudCompanyId;
  String? msUniqueKey;

  MsAssessmentStatementDto({
    this.id,
    this.order,
    this.uniqueKey,
    this.originalStatementUniqueKey,
    this.headerCloudId,
    this.cloudUserId,
    this.templateCloudId,
    this.cloudCompanyId,
    this.msUniqueKey,
    this.statementName,
  });

  // fromJson method
  factory MsAssessmentStatementDto.fromJson(Map<String, dynamic> json) {
    var  a  = MsAssessmentStatementDto(
      id: json['id'],
      statementName: json['statementName'],
      order: json['order'],
      uniqueKey: json['uniqueKey'],
      originalStatementUniqueKey: json['orginalStatementUniqueKey'],
      headerCloudId: json['headerCloudId'],
      cloudUserId: json['cloudUserId'],
      templateCloudId: json['templateCloudId'],
      cloudCompanyId: json['cloudCompanyId'],
      msUniqueKey: json['msUniqueKey'],
    );
    return a;
    
  }

  Map<String, dynamic> toJson() {
    int localType = 0;

    int updateStatementUniqueKey = 0;
    if (originalStatementUniqueKey == uniqueKey) {
      updateStatementUniqueKey = 0;
      localType = 1;
    } else {
      updateStatementUniqueKey = (originalStatementUniqueKey ?? "0").parseInt();
    }

    var map = {
      "header_unique_key": headerCloudId,
      "statment": statementName,
      "statment_unique_key": updateStatementUniqueKey,
      "type": localType,
    };
    return map;
  }
}
