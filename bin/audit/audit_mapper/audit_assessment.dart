import 'cloud_audit_assessment.dart';

class AuditAssessment {
  List<CloudAuditAssessment>? auditAssessment;
  // List<Folder>? folder;
  int? status;
  String? message;

  AuditAssessment({
    this.auditAssessment,
    // this.folder,
    this.status,
    this.message,
  });

  factory AuditAssessment.fromJson(Map<String, dynamic> json) {
    return AuditAssessment(
      auditAssessment: (json['AuditAssessment'] as List<dynamic>?)
          ?.map((e) => CloudAuditAssessment.fromJson(e as Map<String, dynamic>))
          .toList(),
      // folder: (json['Folder'] as List<dynamic>?)
      // 			?.map((e) => Folder.fromJson(e as Map<String, dynamic>))
      // 			.toList(),
      status: json['status'] as int?,
      message: json['Message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'AuditAssessment': auditAssessment?.map((e) => e.toJson()).toList(),
        // 'Folder': folder?.map((e) => e.toJson()).toList(),
        'status': status,
        'Message': message,
      };
}
