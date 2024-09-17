// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/audit_extensions/cloud_audit_question_extension.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/cloud_audit_question.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/cloud_audit_section.dart';
// import 'package:clean_arch/src/domain/entities/audit/audit_assessment_question_entity.dart';

// extension CloudAuditSectionExtension on CloudAuditSection {
//   List<AuditAssessmentQuestionEntity> createSectionEntity({
//     String? uniqueKey,
//   }) {
//     List<AuditAssessmentQuestionEntity> list = [];
//     for (CloudAuditQuestion auditQuestion in questions ?? []) {
//       AuditAssessmentQuestionEntity auditAssessmentQuestionEntity =
//           auditQuestion.createQuestionEntity(
//         sectionCloudId: id,
//         uniqueKey: uniqueKey,
//       );
//       list.add(auditAssessmentQuestionEntity);
//     }
//     return list;
//   }
// }
