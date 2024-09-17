import 'cloud_audit_section.dart';
import 'cloud_audit_variable.dart';
import 'cloud_user.dart';

class CloudAuditAssessment {
  int? id;
  String? referenceNumber;
  int? folderId;
  int? createdTimestamp;
  int? templateId;
  String? templateName;
  String? templateHeader;
  String? date;
  String? auditReference;
  String? uniqueKey;
  int? companyId;
  int? userId;
  int? isSubscribed;
  User? user;
  List<CloudAuditVariables>? variables;
  List<CloudAuditSection>? sections;

  CloudAuditAssessment({
    this.id,
    this.referenceNumber,
    this.folderId,
    this.createdTimestamp,
    this.templateId,
    this.templateName,
    this.templateHeader,
    this.date,
    this.auditReference,
    this.uniqueKey,
    this.companyId,
    this.userId,
    this.user,
    this.variables,
    this.sections,
  });

  CloudAuditAssessment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNumber = json['reference_number'];
    folderId = json['folder_id'];
    isSubscribed = json['is_subscribed'];
    createdTimestamp = json['created_timestamp'];
    templateId = json['template_id'];
    templateName = json['templateName'];
    templateHeader = json['template_header'];
    date = json['date'];
    auditReference = json['audit_reference'];
    uniqueKey = json['unique_key'];
    companyId = json['company_id'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;

    if (json['variables'] != null) {
      variables = <CloudAuditVariables>[];
      json['variables'].forEach((v) {
        variables!.add(CloudAuditVariables.fromJson(v));
      });
    }

    if (json['sections'] != null) {
      sections = <CloudAuditSection>[];
      json['sections'].forEach((v) {
        sections!.add(CloudAuditSection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['folder_id'] = this.folderId;
    data['created_timestamp'] = this.createdTimestamp;
    data['template_id'] = this.templateId;
    data['templateName'] = this.templateName;
    data['template_header'] = this.templateHeader;
    data['date'] = this.date;
    data['audit_reference'] = this.auditReference;
    data['unique_key'] = this.uniqueKey;
    data['company_id'] = this.companyId;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.variables != null) {
      data['variables'] = this.variables!.map((v) => v.toJson()).toList();
    }
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
