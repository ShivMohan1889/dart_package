import 'dart:convert';

import 'package:dart_pdf_package/src/audit/dto/company_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_assessment_hazard_icon_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_assessment_image_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_assessment_statement_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_template_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_template_field_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_template_value_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/review_sign_off_dto.dart';

import '../../audit/dto/user_dto.dart';

class MsAssessmentDto {
  // Existing fields
  MsTemplateDto? templateDto;
  int? id;
  String? referenceNumber;
  String? projectName;
  String? projectReference;
  String? date;
  String? uniqueKey;
  String? startDate;
  String? endDate;
  int? f10Applicable;
  String? firstName;
  String? lastName;
  int? noContractor;

  String? pdfName;
  String? client;

  String? houseNo;
  String? email;
  String? town;
  String? country;
  String? city;
  String? phone;
  int? isUploaded;
  int? isSubscribed;
  String? createdTimestamp;
  double? lastUploadedTimestamp;
  double? modifiedTimestamp;
  int? folderId;
  int? phasePlanApplicable;
  String? position;
  String? principleContractor;
  String? siteAddress1;
  String? siteAddress2;
  String? siteAddress3;
  String? siteSupervisor;
  String? siteSupervisorContactNo;
  String? templateHeaderName;
  String? workLocation;
  int? isUploadedBox;
  int? isUploadedDropbox;
  int? isUploadedOnedrive;
  int? isUploadedGoogleDrive;
  int? isUploadedProcore;
  int? procoreId;
  int? access;
  int? cloudUserId;
  int? templateCloudId;
  int? cloudCompanyId;
  int? isDeleted;
  String? raUniqueKey;

  String? userUniqueKey;
  String? user;
  int? isSelected = 0;
  int isBeingEdited = 0;
  CompanyDto? companyDto;
  UserDto? userDto;

  int? isSignoffRequired;
  int? isApprovalRequired;

  int? signoffMode;
  int? approvalMode;
  int? isDraft;

  int? numberOfSignOffReivew;
  int? msCloudId;

  String? dropboxFileId;
  String? boxnetFileId;

  String? googleDriveFileId;
  String? oneDriveFileId;
  String? procoreFileId;

  String? documentsDirPath;

  // RiskAssessmentDto? riskAssessmentDto;

  List<MsTemplateValueDto>? listMsTemplateValues = List.empty(growable: true);
  List<MsTemplateFieldDto>? listMsTemplateField = List.empty(growable: true);
  List<MsAssessmentStatementDto>? listMsAssessmentStatement =
      List.empty(growable: true);
  List<MsAssessmentImageDto>? listMsAssessmentImageDto =
      List.empty(growable: true);
  List<MsAssessmentHazardIconDto>? msAssessmentIconList =
      List.empty(growable: true);
  List<ReviewSignOffUserDto>? listReviewSignOffUsers =
      List.empty(growable: true);

  MsAssessmentDto({
    this.referenceNumber,
    this.templateDto,
    this.listMsAssessmentImageDto,
    this.listMsAssessmentStatement,
    this.listMsTemplateField,
    this.userDto,
    this.projectName,
    this.date,
    this.uniqueKey,
    this.user,
    required this.listMsTemplateValues,
    this.templateCloudId,
    this.cloudCompanyId,
    this.cloudUserId,
    this.userUniqueKey,
    this.numberOfSignOffReivew = 0,
    this.approvalMode = 0,
    this.signoffMode = 0,
    this.isDraft = 1,
    this.msCloudId,
    // this.riskAssessmentDto,
    this.dropboxFileId,
    this.boxnetFileId,
    this.oneDriveFileId,
    this.googleDriveFileId,
    this.procoreFileId,
    this.listReviewSignOffUsers,
    this.msAssessmentIconList,
    this.projectReference,
    this.startDate,
    this.endDate,
    this.f10Applicable,
    this.firstName,
    this.lastName,
    this.noContractor,
    this.pdfName,
    this.client,
    this.houseNo,
    this.email,
    this.town,
    this.phasePlanApplicable,
    this.country,
    this.city,
    this.phone,
    this.isUploaded,
    this.isSubscribed,
    this.createdTimestamp,
    this.lastUploadedTimestamp,
    this.modifiedTimestamp,
    this.folderId,
    this.position,
    this.principleContractor,
    this.siteAddress1,
    this.siteAddress2,
    this.siteAddress3,
    this.siteSupervisor,
    this.siteSupervisorContactNo,
    this.templateHeaderName,
    this.workLocation,
    this.isUploadedBox,
    this.isUploadedDropbox,
    this.isUploadedOnedrive,
    this.isUploadedGoogleDrive,
    this.isUploadedProcore,
    this.procoreId,
    this.access,
    this.isSignoffRequired,
    this.isApprovalRequired,
    this.documentsDirPath,
    this.isDeleted,
    this.raUniqueKey,
    this.companyDto,
    this.isBeingEdited = 0,
    this.isSelected,
  });

  factory MsAssessmentDto.fromJson(Map<String, dynamic> json) {
    return MsAssessmentDto(
      templateDto: json['template'] != null
          ? MsTemplateDto.fromJson(json['template'])
          : null,

      referenceNumber: json['referenceNumber'],
      projectName: json['projectName'],
      projectReference: json['projectReference'],
      date: json['date'],
      uniqueKey: json['uniqueKey'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      f10Applicable: json['f10Applicable'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      noContractor: json['noContractor'],
      pdfName: json['pdfName'],
      client: json['client'],
      houseNo: json['houseNo'],
      email: json['email'],
      town: json['town'],
      country: json['country'],
      city: json['city'],
      phone: json['phone'],
      isUploaded: json['isUploaded'],
      isSubscribed: json['isSubscribed'],
      createdTimestamp: json['createdTimestamp'],
      lastUploadedTimestamp: json['lastUploadedTimestamp']?.toDouble(),
      modifiedTimestamp: json['modifiedTimestamp']?.toDouble(),
      folderId: json['folderId'],
      phasePlanApplicable: json['phasePlanApplicable'],
      position: json['position'],
      principleContractor: json['principleContractor'],
      siteAddress1: json['siteAddress1'],
      siteAddress2: json['siteAddress2'],
      siteAddress3: json['siteAddress3'],
      siteSupervisor: json['siteSupervisor'],
      siteSupervisorContactNo: json['siteSupervisorContactNo'],
      templateHeaderName: json['templateHeaderName'],
      workLocation: json['workLocation'],
      isUploadedBox: json['isUploadedBox'],
      isUploadedDropbox: json['isUploadedDropbox'],
      isUploadedOnedrive: json['isUploadedOnedrive'],
      isUploadedGoogleDrive: json['isUploadedGoogleDrive'],
      isUploadedProcore: json['isUploadedProcore'],
      procoreId: json['procoreId'],
      access: json['access'],
      cloudUserId: json['cloudUserId'],
      templateCloudId: json['templateCloudId'],
      cloudCompanyId: json['cloudCompanyId'],
      isDeleted: json['isDeleted'],
      raUniqueKey: json['raUniqueKey'],
      userUniqueKey: json['userUniqueKey'],
      user: json['user'],
      isSelected: json['isSelected'],
      isBeingEdited: json['isBeingEdited'],
      companyDto:
          json['company'] != null ? CompanyDto.fromJson(json['company']) : null,
      userDto: json['userEntity'] != null
          ? UserDto.fromJson(json['userEntity'])
          : null,
      isSignoffRequired: json['isSignoffRequired'],
      isApprovalRequired: json['isApprovalRequired'],
      signoffMode: json['signoffMode'],
      approvalMode: json['approvalMode'],
      isDraft: json['isDraft'],
      numberOfSignOffReivew: json['numberOfSignOffReivew'],
      msCloudId: json['msCloudId'],
      dropboxFileId: json['dropboxFileId'],
      boxnetFileId: json['boxnetFileId'],
      googleDriveFileId: json['googleDriveFileId'],
      oneDriveFileId: json['oneDriveFileId'],
      procoreFileId: json['procoreFileId'],
      documentsDirPath: json['documentsDirPath'],
      // riskAssessmentDto: json['riskAssessmentEntity'] != null
      //     ? RiskAssessmentDto.fromJson(json['riskAssessmentEntity'])
      //     : null,
      listMsTemplateValues: (json['listMsTemplateValues'] as List<dynamic>)
          .map((e) => MsTemplateValueDto.fromJson(e))
          .toList(),
      listMsTemplateField: (json['listMsTemplateField'] as List<dynamic>?)
          ?.map((e) => MsTemplateFieldDto.fromJson(e))
          .toList(),
      listMsAssessmentStatement:
          (json['listMsAssessmentStatement'] as List<dynamic>)
              .map((e) => MsAssessmentStatementDto.fromJson(e))
              .toList(),
      listMsAssessmentImageDto:
          (json['listMsAssessmentImageEntity'] as List<dynamic>)
              .map((e) => MsAssessmentImageDto.fromJson(e))
              .toList(),
      msAssessmentIconList: (json['msAssessmentIconList'] as List<dynamic>)
          .map((e) => MsAssessmentHazardIconDto.fromJson(e))
          .toList(),
      listReviewSignOffUsers: (json['listReviewSignOffUsers'] as List<dynamic>)
          .map((e) => ReviewSignOffUserDto.fromJson(e))
          .toList(),
    );
  }

  // fromJsonString method
  static MsAssessmentDto fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return MsAssessmentDto.fromJson(jsonMap);
  }
}
