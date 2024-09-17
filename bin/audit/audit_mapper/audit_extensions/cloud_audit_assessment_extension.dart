// import 'package:clean_arch/src/core/date/ra_date_time.dart';
// import 'package:clean_arch/src/core/shared_preferences/index.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/audit_extensions/cloud_audit_section_extension.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/audit_extensions/cloud_audit_variable_extension.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/cloud_audit_assessment.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/cloud_audit_section.dart';
// import 'package:clean_arch/src/data/model/remote/download_assessment/audit_module/cloud_audit_variable.dart';
// import 'package:clean_arch/src/domain/entities/audit/audit_answer_field.dart';
// import 'package:clean_arch/src/domain/entities/audit/audit_assessment_entity.dart';

// import 'package:clean_arch/src/domain/entities/common/user_entity.dart';
// import 'package:get_it/get_it.dart';

// extension CloudAuditAssessmentExtension on CloudAuditAssessment {
//   AuditAssessmentEntity createAudtitAssessmentEntity() {
//     AuditAssessmentEntity auditAssessmentEntity = AuditAssessmentEntity();

//     auditAssessmentEntity.refName = auditReference;
//     auditAssessmentEntity.referenceNumber = referenceNumber;
//     // changing the date format from web to app
//     auditAssessmentEntity.date = RaDateTime.dateFromWebApis(date ?? "");
//     auditAssessmentEntity.uniqueKey = uniqueKey;
//     auditAssessmentEntity.templateCloudId = templateId;
//     auditAssessmentEntity.cloudCompanyId = companyId;
//     auditAssessmentEntity.cloudUserId = userId;
//     auditAssessmentEntity.templateName = templateName;
//     auditAssessmentEntity.folderId = folderId;
//     auditAssessmentEntity.isSubscribed = isSubscribed;
//     auditAssessmentEntity.cloudAssessmentId = id;
//     //  auditAssessmentEntity.uploadTime ;
//     //  auditAssessmentEntity.isCompleted = ;
//     //

//     //  auditAssessmentEntity.isUploaded = u;
//     //  auditAssessmentEntity.isPurchasedPdf = isPRe;
//     //  auditAssessmentEntity.isUploadedDropbox = dro;
//     //  auditAssessmentEntity.isUploadedBox = isUploadedBox;
//     //  auditAssessmentEntity.isUploadedGoogleDrive = isUploadedGoogleDrive;
//     //  auditAssessmentEntity.isUploadedProcore = isUploadedProcore;
//     //  auditAssessmentEntity.isUploadedOneDrive = isUploadedOneDrive;
//     //  auditAssessmentEntity.procoreId = ;

//     auditAssessmentEntity.templateName = templateName;

//     auditAssessmentEntity.userName = user?.userName;
//     auditAssessmentEntity.uniqueKey = uniqueKey;

//     auditAssessmentEntity.userUniqueKey = user?.uniqueKey;

//     for (CloudAuditVariables varible in variables ?? []) {
//       AuditAnswerFieldEntity answerFieldEntity =
//           varible.createAuditAnswerFormFieldEntity(uniqueKey: uniqueKey);
//       auditAssessmentEntity.listAuditAnswerFieldEntity.add(answerFieldEntity);
//     }

//     for (CloudAuditSection auditSection in sections ?? []) {
//       auditAssessmentEntity.listAuditAssessmentQuestionEntity.addAll(
//         auditSection.createSectionEntity(
//           uniqueKey: uniqueKey,
//         ),
//       );
//     }

//     // this for updating the user entity in audit assessment entity
//     // UserEntity userEntity = UserEntity(
//     //   isCloud: 1,
//     //   position: user?.position,
//     //   userName: user?.userName,
//     //   uniqueKey: user?.uniqueKey,
//     //   signature: user?.userSignature,
//     // );

//     var sharedPrefrences = GetIt.I<PreferencesHelper>();
//     UserEntity userEntity = UserEntity(
//       isCloud: 1,
//       position: user?.position,
//       signature: user?.userSignature,
//       cloudUserId: user?.userId, // TODO
//       uniqueKey: user?.uniqueKey,
//       userName: user?.userName,
//       cloudCompanyId: sharedPrefrences.companyId,
//     );

//     auditAssessmentEntity.userEntity = userEntity;

// // donwloaded assessment might not have been edited
//     if (sharedPrefrences.isSubscribed == 1) {
//       auditAssessmentEntity.isSubscribed = sharedPrefrences.isSubscribed;
//     }
//     return auditAssessmentEntity;
//   }
// }
