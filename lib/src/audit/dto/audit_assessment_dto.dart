import 'package:dart_pdf_package/src/audit/dto/audit_assets_pdf_image_dto.dart';
import 'package:dart_pdf_package/src/utils/date/tb_date_time.dart';
import 'package:dart_pdf_package/src/utils/utils.dart';

import 'audit_answer_field_dto.dart';
import 'audit_assessment_question_dto.dart';
import 'audit_template_dto.dart';
import 'audit_template_field_dto.dart';
import 'company_dto.dart';
import 'user_dto.dart';

class AuditAssessmentDto {
  int? id;
  String? referenceNumber;
  String? refName;
  String? projectReference;
  String? date;
  String? uniqueKey;
  int? templateCloudId;
  int? cloudCompanyId;
  String? templateName;
  int? cloudAssessmentId;
  String? uploadTime;
  int? isCompleted;
  int? isSubscribed;
  int? folderId;
  int? isUploaded;

  int? isUploadedDropbox;
  int? isUploadedBox;
  int? isUploadedGoogleDrive;
  int? isUploadedProcore;
  int? isUploadedOneDrive;
  int? procoreId;

  // holds the selected audit template entity
  AuditTemplateDto? auditTemplateDto;
  // holds the user entity
  UserDto? userDto;
  // holds the user name
  String? userName;
  int? cloudUserId;

  int? isSelected = 0;
  int? isDraft = 1;
  int? access = 0;

  /// Determines if the assessment is being edited or is fresh
  int? isBeingEdited = 0;

  CompanyDto? companyDto;

  // use for accessing the user entity from db
  String? userUniqueKey;

  /// This will hold all the form fields to create project details fields
  List<AuditTemplateFieldDto>? listAuditAssessmentFieldDto = [];

  /// This will hold all the questions to create audit questions
  List<AuditAssessmentQuestionDto>? listAuditAssessmentQuestionDto =
      List.empty(growable: true);

  /// This will hold the audit answer field entity
  List<AuditAnswerFieldDto>? listAuditAnswerFieldDto =
      List.empty(growable: true);

  String? dropboxFileId;
  String? boxnetFileId;
  String? googleDriveFileId;

  String? oneDriveFileId;
  String? procoreFileId;

  String? pdfName;
  String? documentsDirPath;

  AuditAssetsPdfImageDto? auditAssetsPdfImageDto;

  AuditAssessmentDto({
    this.userUniqueKey,
    this.id,
    this.referenceNumber,
    this.refName,
    this.projectReference,
    this.date,
    this.uniqueKey,
    this.templateCloudId,
    this.cloudCompanyId,
    this.templateName,
    this.cloudAssessmentId,
    this.uploadTime,
    this.isCompleted,
    this.isSubscribed,
    this.folderId,
    this.isUploaded,
    this.isUploadedDropbox,
    this.isUploadedBox,
    this.isUploadedGoogleDrive,
    this.isUploadedProcore,
    this.isUploadedOneDrive,
    this.procoreId,
    this.auditTemplateDto,
    this.userDto,
    this.userName,
    this.cloudUserId,
    this.listAuditAssessmentFieldDto,
    this.isBeingEdited,
    this.isSelected = 0,
    this.companyDto,
    this.isDraft,
    this.boxnetFileId,
    this.dropboxFileId,
    this.googleDriveFileId,
    this.oneDriveFileId,
    this.procoreFileId,
    this.pdfName,
    this.access,
    this.listAuditAssessmentQuestionDto,
    this.listAuditAnswerFieldDto,
    this.auditAssetsPdfImageDto,
  });

  // JSON factory method to read from JSON
  factory AuditAssessmentDto.fromJsonString(String jsonString) {
    Map<String, dynamic> json = TbUtils.mapFromJsonString(jsonString);

    var dto = AuditAssessmentDto(
      id: json["id"],
      referenceNumber: (json["reference_number"] ?? "").toString(),
      refName: json["ref_name"],
      projectReference: json["project_reference"],
      date: json["date"],
      uniqueKey: json["unique_key"],
      templateCloudId: json["template_cloud_id"],
      cloudCompanyId: json["cloud_company_id"],
      templateName: json["template_name"],
      cloudAssessmentId: json["cloud_assessment_id"],
      uploadTime: json["upload_time"],
      isCompleted: json["is_completed"],
      isSubscribed: json["is_subscribed"],
      folderId: json["folder_id"],
      isUploaded: json["is_uploaded"],
      isUploadedDropbox: json["is_uploaded_dropbox"],
      isUploadedBox: json["is_uploaded_box"],
      isUploadedGoogleDrive: json["is_uploaded_google_drive"],
      isUploadedProcore: json["is_uploaded_procore"],
      isUploadedOneDrive: json["is_uploaded_one_drive"],
      procoreId: json["procore_id"],
      auditTemplateDto: json["audit_template_entity"] != null
          ? AuditTemplateDto.fromJson(json["audit_template_entity"])
          : null,
      userDto: json["user_entity"] != null
          ? UserDto.fromJson(json["user_entity"])
          : null,
      userName: json["user_name"],
      cloudUserId: json["cloud_user_id"],
      listAuditAssessmentFieldDto:
          json["list_audit_assessment_field_entity"] != null
              ? List<AuditTemplateFieldDto>.from(
                  json["list_audit_assessment_field_entity"]
                      .map((x) => AuditTemplateFieldDto.fromJson(x)))
              : [],
      listAuditAssessmentQuestionDto:
          json["list_audit_assessment_question_entity"] != null
              ? List<AuditAssessmentQuestionDto>.from(
                  json["list_audit_assessment_question_entity"]
                      .map((x) => AuditAssessmentQuestionDto.fromJson(x)))
              : [],
      listAuditAnswerFieldDto: (json['list_audit_answer_field_entity']
              as List<dynamic>?)
          ?.map((e) => AuditAnswerFieldDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      dropboxFileId: json["dropbox_file_id"],
      boxnetFileId: json["boxnet_file_id"],
      googleDriveFileId: json["google_drive_file_id"],
      oneDriveFileId: json["one_drive_file_id"],
      procoreFileId: json["procore_file_id"],
      pdfName: json["pdf_name"],
      access: json["access"],
      companyDto:
          json["company"] != null ? CompanyDto.fromJson(json["company"]) : null,
      auditAssetsPdfImageDto: json["audit_assets_image"] != null
          ? AuditAssetsPdfImageDto.fromJson(json["audit_assets_image"])
          : null,
    );
    return dto;
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "reference_number": referenceNumber,
        "ref_name": refName,
        "project_reference": projectReference,
        "date": date,
        "unique_key": uniqueKey,
        "template_cloud_id": templateCloudId,
        "cloud_company_id": cloudCompanyId,
        "template_name": templateName,
        "cloud_assessment_id": cloudAssessmentId,
        "upload_time": uploadTime,
        "is_completed": isCompleted,
        "is_subscribed": isSubscribed,
        "folder_id": folderId,
        "is_uploaded": isUploaded,
        "is_uploaded_dropbox": isUploadedDropbox,
        "is_uploaded_box": isUploadedBox,
        "is_uploaded_google_drive": isUploadedGoogleDrive,
        "is_uploaded_procore": isUploadedProcore,
        "is_uploaded_one_drive": isUploadedOneDrive,
        "procore_id": procoreId,
        "audit_template_entity": auditTemplateDto?.toJson(),
        "user_entity": userDto?.toJson(),
        "user_name": userName,
        "cloud_user_id": cloudUserId,
        "list_audit_assessment_field_entity":
            listAuditAssessmentFieldDto?.map((x) => x.toJson()).toList(),
        "list_audit_assessment_question_entity":
            listAuditAssessmentQuestionDto?.map((x) => x.toJson()).toList(),
        "list_audit_answer_field_entity":
            listAuditAnswerFieldDto?.map((x) => x.jsonToUpload()).toList(),
        "dropbox_file_id": dropboxFileId,
        "boxnet_file_id": boxnetFileId,
        "google_drive_file_id": googleDriveFileId,
        "one_drive_file_id": oneDriveFileId,
        "procore_file_id": procoreFileId,
        "pdf_name": pdfName,
        "access": access,
        "assets_image": auditAssetsPdfImageDto?.toJson(),
      };

  // Clone method logic remains unchanged
  Future<void> clone() async {
    isUploaded = 0;
    isUploadedDropbox = 0;
    isUploadedBox = 0;
    isUploadedGoogleDrive = 0;
    isUploadedOneDrive = 0;
    isUploadedProcore = 0;
    folderId = null;

    oneDriveFileId = null;
    procoreFileId = null;
    googleDriveFileId = null;
    boxnetFileId = null;
    cloudAssessmentId = null;
    procoreId = null;

    // for (AuditAnswerFieldDto answerFieldEntity in listAuditAnswerFieldEntity) {
    //   answerFieldEntity.uniqueKey = uniqueKey;
    // }

    await Future.forEach(listAuditAssessmentQuestionDto ?? [],
        (question) async {
      question.assessmentUniqueKey = uniqueKey;
    });

    pdfName = null;
    date = TbDateTime.currentDateString();
  }
}
