// import 'package:clean_arch/src/core/date/ra_date_time.dart';
// import 'package:clean_arch/src/core/enum/audit_enum.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/audit_extensions/cloud_audit_question_image_extension.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/cloud_audit_question.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/cloud_audit_question_image.dart';
// import 'package:clean_arch/src/domain/entities/audit/audit_assessment_question_entity.dart';
// import 'package:clean_arch/src/domain/entities/audit/audit_image_entity.dart';

// extension CloudAuditQuestionExtension on CloudAuditQuestion {
// // this method update the AuditAssessmentQuestionEntit
//   AuditAssessmentQuestionEntity createQuestionEntity({
//     int? sectionCloudId,
//     String? uniqueKey,
//   }) {
//     AuditAssessmentQuestionEntity auditAssessmentQuestionEntity =
//         AuditAssessmentQuestionEntity(listAuditImageEntity: []);

//     int? questionAnswerType = answerType;
//     if (questionAnswerType == AnswerType.statement) {
//       auditAssessmentQuestionEntity.answer = question;
//     } else if (questionAnswerType == AnswerType.date) {
//       auditAssessmentQuestionEntity.answer =
//           RaDateTime.dateFromWebApis(answerText ?? "");
//     } else if (questionAnswerType == AnswerType.textInput) {
//       auditAssessmentQuestionEntity.answer = answerText;
//     } else {
//       auditAssessmentQuestionEntity.answer = answer;
//       auditAssessmentQuestionEntity.chainStatus = answer;
//     }

//     auditAssessmentQuestionEntity.sectionCloudId = sectionCloudId;
//     auditAssessmentQuestionEntity.question = question;
//     auditAssessmentQuestionEntity.parentId = parentId;
//     auditAssessmentQuestionEntity.answerType = answerType;
//     auditAssessmentQuestionEntity.comment = comment;
//     auditAssessmentQuestionEntity.cloudQuestionId = id;
//     auditAssessmentQuestionEntity.assessmentUniqueKey = uniqueKey;

//     // loop for iterating the question image from images list
//     for (CloudAuditQuestionImage questionImage in images ?? []) {
//       AuditImageEntity auditImageEntity = questionImage.createAuditImageEntity(
//         assessmentUniqueKey: uniqueKey,
//       );
//       auditAssessmentQuestionEntity.listAuditImageEntity.add(auditImageEntity);
//     }
//     // update the audit image entity list

//     return auditAssessmentQuestionEntity;
//   }
// }
