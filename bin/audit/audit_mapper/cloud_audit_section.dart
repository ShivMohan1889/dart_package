import 'cloud_audit_question.dart';

class CloudAuditSection {
  int? id;
  List<CloudAuditQuestion>? questions;

  CloudAuditSection({this.id, this.questions});

  factory CloudAuditSection.fromJson(Map<String, dynamic> json) =>
      CloudAuditSection(
        id: json['id'] as int?,
        questions: (json['questions'] as List<dynamic>?)
            ?.map((e) => CloudAuditQuestion.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'questions': questions?.map((e) => e.toJson()).toList(),
      };
}
