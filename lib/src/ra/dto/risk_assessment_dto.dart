import 'dart:convert';

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/audit/dto/company_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/user_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/assessment_image_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/harm_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/hazard_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/key_staff_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/reference_image_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/review_sign_off_user_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/time_logs_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/weather/weather_dto.dart';
import 'package:pdf/widgets.dart';

class RiskAssessmentDto {
  ///Database Primary Key
  int? id;

  /// Determines name of the project added by user
  String? name;

  /// Determines name of the project description by user
  String? description;

  /// Determines name of the user selected by the
  /// end user from the drop down
  String? user;

  int? fire;
  int? coshh;
  int? manualHandling;
  int? displayHandling;
  int? youngPerson;
  int? employees;
  int? visistors;
  int? contractors;
  String? referenceNumber;
  int? membersOfPublic;
  int? others;
  int? nursingExpectantMums;
  int? youngPerson2;
  int? disabled;
  int? serviceUsers;

  /// Determines if another assessment is required
  int? anotherAssessmentRequired;

  /// Determines if approval is required
  int? isApprovalRequired;

  /// Determines if sign off is required
  int? isSignoffRequired;

  /// Determines mode of the approval,
  /// manual or on this device
  int? approvalMode;

  /// Determines mode of the sign off,
  /// manual or on this device
  int? signOffMode;

  /// Determines Weather report will be matrix type of standard
  /// user change is matrix from company details page
  int? assessmentType;

  ///Determines date of the assessment selected by user
  ///on the project details screen
  String? assessmentDate;

  ///Determines work start date of the assessment selected by user
  ///on the project details screen
  String? workStartDate;

  ///Determines work end date of the assessment selected by user
  ///on the project details screen
  String? workEndDate;

  ///Determines reminder date of the assessment if user
  ///has selecte another assessment is required
  String? anotherAssessmentDate;

  /// this flag
  int? isSelectedForZipcode = 0;

  ///Determines the reminder date of the assessment
  String? reminderDate;

  ///Determines the time when assessment was started
  ///used to calculate time taken to finish an assessment
  double? startTime;

  ///Determines the time when assessment was completed
  ///used to calculate time taken to finish an assessment
  double? endTime;

  /// Time taken to complete the assessment
  double? averageAssessmentTime;

  double? uploadedTimestamp;
  double? modifiedTimestamp;

  /// Determines the folder in which assessment is uploaded
  int? folderId;

  /// Determines the hazard Library that needs to show when
  /// assessmetn will be edited
  int? hazardLibraryId;

  /// Determines the user who has completed the assessment
  int? userId;

  String? uniqueKey;

  /// this is only used when user is uploading RA,
  /// when we are uploading linked RA, user add, we will have to create new unique key
  /// we will store that unique key in this variable and when user will upload ms
  /// will assign this unique key to ms
  String? uploadedUniqueKey;

  /// Determines if assessment is uploaded on our website
  int? isUploaded;

  /// Determines if assessment is uploaded on dropbox
  int? isUploadedDropbox;

  /// Determines if assessment is uploaded on box
  int? isUploadedBox;

  /// Determines if assessment is uploaded on google drive
  int? isUploadedGoogleDrive;

  /// Determines if assessment is uploaded on one drive
  int? isUploadedOneDrive;

  /// Determines if assessment is uploaded on procore
  int? isUploadedProcore;

  /// Determines the path of the assessment pdf on the file system
  String? pdfPath;

  /// Determines the path of the map image on the file system
  String? mapImagePath;

  /// Determines if asessment is being edited or is the fresh assessment
  int isBeingEdited = 0;

  /// Determines the lattitude of the location,
  ///  where assessment was created
  double? lattitude;

  /// Determines the longitude of the location,
  ///  where assessment was created
  double? longitude;

  /// Determines the name of the location in string format

  String? location;

  /// Determines the zip code of the locaiton
  String? zipcode;

  /// Determines if pdf was created when user was subscribed
  /// if yes we will never show watermark on the pdf
  int? isSubscribed;

  /// Determines the id of the parent assessment
  /// used to fetch all of the linked assessments
  String? rootId;

  /// Determines the id of the parent assessment
  /// used in case of connecting multiple assessments
  String? parentId;

  /// Determines the linked Method assessment
  String? msUniqueKey;

  /// Determines the linked Method assessment
  int? msCloudId;

  /// Determines the user id of cloud user
  int? cloudUserId;

  int? access;

  // used to save server id, used in case we are uploading
  int? cloudId;

  /// Determines the companyID
  int? companyId;

  /// Determines the companyID
  int? cloudCompanyId;

  /// Determines the number of sign poff user are required
  ///  in case of manual sign off
  int? numberOfSigneeRequired;

  /// Determines if assessment is completed and
  ///  needs to upload automatically
  int? isCompleted;

  /// Determines the procore fileID
  String? procoreFileId;

  /// Determines the dropbox fileID
  String? dropboxFileId;

  /// Determines the box fileID
  String? boxFileId;

  /// It is used in the case of United Kingdom Template
  // String? harmedPeople;

  /// Determines the google drive fileID
  String? googleDriveFileId;

  /// Determines the one Drive fileID
  String? oneDriveFileId;

  /// Determines the one Drive fileID
  int? isSelected = 0;

  /// determines if an assesment has been marked as "Save as Draft" or
  /// Upload (assessment uploads automatically in this case)
  int? isDraft = 1;

  /// List that contains all the selected hazards
  /// for the assessment
  List<HazardDto>? listHazards = List.empty(growable: true);

  /// holds the key staff member
  List<KeyStaffDto>? listKeyStaff = List.empty(growable: true);

  /// Contains reference images for Assessment
  List<ReferenceImageDto>? listReferenceImage = List.empty(growable: true);

  /// Contains assessment images
  List<AssessmentImageDto>? listAssessmentImage = List.empty(growable: true);

  ///Contains Approve Sign Off Users
  List<ReviewSignOffUserDto>? listReviewSignOffUsers =
      List.empty(growable: true);

  /// Contains the time session spent on the assessment
  List<TimeLogsDto>? listTimeLogs = List.empty(growable: true);

  List<WeatherDto>? listWeatherDto = List.empty(growable: true);

  List<HarmDto>? listHarmDto = List.empty(growable: true);

  /// Contains user which was selected while creating assessment
  UserDto? userDto;

  /// Contains the company selected while creating assessment
  CompanyDto? companyDto;

  /// when assessments are linked this will be used
  MsAssessmentDto? msAssessmentDto;

  String? assessmentHarm;

  /// Contains review user
  ReviewSignOffUserDto? reviewUser;

  int? hazardIconOpacity;

  /// list that will contain all the child assessments
  List<RiskAssessmentDto>? listChildren = List.empty(growable: true);

  MemoryImage? mapMemoryImage;

  String? documentsDirPath;

  int ?  linkingPreference;
  

  
  RiskAssessmentDto({
    this.id,
    this.name,
    this.description,
    this.user,
    this.fire,
    this.coshh,
    this.manualHandling,
    this.displayHandling,
    this.youngPerson,
    this.employees,
    this.visistors,
    this.contractors,
    this.referenceNumber,
    this.membersOfPublic,
    this.companyId,
    this.cloudCompanyId,
    this.cloudUserId,
    this.cloudId,
    this.access,
    this.isSubscribed,
    this.rootId,
    this.parentId,
    this.location,
    this.msUniqueKey,
    this.msCloudId,
    this.lattitude,
    this.longitude,
    this.isCompleted,
    this.zipcode,
    this.procoreFileId,
    this.dropboxFileId,
    this.boxFileId,
    this.googleDriveFileId,
    this.oneDriveFileId,
    this.isSelected,
    this.isDraft,
    this.listHazards,
    this.listKeyStaff,
    this.listReferenceImage,
    this.listAssessmentImage,
    this.listReviewSignOffUsers,
    this.listTimeLogs,
    this.listWeatherDto,
    this.listHarmDto,
    this.userDto,
    this.companyDto,
    this.msAssessmentDto,
    this.assessmentHarm,
    this.reviewUser,
    this.listChildren,
    this.mapMemoryImage,
    this.documentsDirPath,
    this.others,
    this.anotherAssessmentDate,
    this.anotherAssessmentRequired,
    this.approvalMode,
    this.assessmentDate,
    this.assessmentType,
    this.averageAssessmentTime,
    this.endTime,
    this.disabled,
    this.mapImagePath,
    this.reminderDate,
    this.isSignoffRequired,
    this.numberOfSigneeRequired,
    this.hazardLibraryId,
    this.folderId,
    this.uniqueKey,
    this.nursingExpectantMums,
    this.youngPerson2,
    this.serviceUsers,
    this.isApprovalRequired,
    this.signOffMode,
    this.startTime,
    this.workEndDate,
    this.workStartDate,
    this.hazardIconOpacity,
    this.linkingPreference,

  });

  // CLONE

  /// creates a new copy for save as new feature
  /* ************************************** */

  // void updateTimeLogs() {
  //   if (listTimeLogs.isNotEmpty) {
  //     TimeLogsDto log = listTimeLogs.last;
  //     int timeTakenToFinishAssessment = RaDateTime.timeStamp() - log.startTime;
  //     log.assessmentTime = timeTakenToFinishAssessment;
  //   }
  // }

  factory RiskAssessmentDto.fromJson(Map<String, dynamic> json) {
    return RiskAssessmentDto(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        user: json['user'],
        fire: json['fire'],
        coshh: json['coshh'],
        manualHandling: json['manualHandling'],
        displayHandling: json['displayHandling'],
        youngPerson: json['youngPerson'],
        employees: json['employees'],
        visistors: json['visitors'],
        contractors: json['contractors'],
        referenceNumber: json['referenceNumber'],
        membersOfPublic: json['membersOfPublic'],
        others: json['others'],
        nursingExpectantMums: json['nursingExpectantMums'],
        youngPerson2: json['youngPerson2'],
        disabled: json['disabled'],
        serviceUsers: json['serviceUsers'],
        anotherAssessmentRequired: json['anotherAssessmentRequired'],
        isApprovalRequired: json['isApprovalRequired'],
        isSignoffRequired: json['isSignoffRequired'],
        approvalMode: json['approvalMode'],
        signOffMode: json['signoffMode'],
        assessmentType: json['assessmentType'],
        assessmentDate: json['assessmentDate'],
        workStartDate: json['workStartDate'],
        workEndDate: json['workEndDate'],
        anotherAssessmentDate: json['anotherAssessmentDate'],
        reminderDate: json['reminderDate'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        averageAssessmentTime: json['averageAssessmentTime'] as double?,
        folderId: json['folderId'],
        hazardLibraryId: json['hazardLibraryId'],
        uniqueKey: json['uniqueKey'],
        // mapImagePath: json['mapImagePath'],
        mapImagePath: json["map_image_path"],
        lattitude: json['lattitude'],
        longitude: json['longitude'],
        location: json['location'],
        zipcode: json['zipcode'],
        isSubscribed: json['isSubscribed'],
        rootId: json['rootId'],
        parentId: json['parentId'],
        msUniqueKey: json['msUniqueKey'],
        msCloudId: json['msCloudId'],
        cloudUserId: json['cloudUserId'],
        access: json['access'],
        cloudId: json['cloudId'],
        companyId: json['companyId'],
        cloudCompanyId: json['cloudCompanyId'],
        numberOfSigneeRequired: json['numberOfSigneeRequired'],
        isCompleted: json['isCompleted'],
        procoreFileId: json['procoreFileId'],
        dropboxFileId: json['dropboxFileId'],
        boxFileId: json['boxFileId'],
        googleDriveFileId: json['googleDriveFileId'],
        oneDriveFileId: json['oneDriveFileId'],
        isSelected: json['isSelected'],
        isDraft: json['isDraft'],
        listHazards: (json['listHazards'] as List<dynamic>?)
            ?.map((e) => HazardDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        listKeyStaff: (json['listKeyStaff'] as List<dynamic>?)
            ?.map((e) => KeyStaffDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        listReferenceImage: (json['listReferenceImage'] as List<dynamic>?)
            ?.map((e) => ReferenceImageDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        listAssessmentImage: (json['listAssessmentImage'] as List<dynamic>?)
            ?.map((e) => AssessmentImageDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        listReviewSignOffUsers: (json['listReviewSignOffUsers']
                as List<dynamic>?)
            ?.map(
                (e) => ReviewSignOffUserDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        listTimeLogs: (json['listTimeLogs'] as List<dynamic>?)
            ?.map((e) => TimeLogsDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        listWeatherDto: (json['listWeatherEntity'] as List<dynamic>?)
          ?.map((e) => WeatherDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        listHarmDto: (json['listHarmEntity'] as List<dynamic>?)
            ?.map((e) => HarmDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        userDto: json['userEntity'] != null
            ? UserDto.fromJson(json['userEntity'] as Map<String, dynamic>)
            : null,
        companyDto: json['company'] != null
            ? CompanyDto.fromJson(json['company'] as Map<String, dynamic>)
            : null,
        msAssessmentDto: json['msAssessmentEntity'] != null
            ? MsAssessmentDto.fromJson(
                json['msAssessmentEntity'] as Map<String, dynamic>)
            : null,
        assessmentHarm: json["assessmentHarm"],
        reviewUser: json['reviewUser'] != null
            ? ReviewSignOffUserDto.fromJson(
                json['reviewUser'] as Map<String, dynamic>)
            : null,
        listChildren: (json['listChildren'] as List<dynamic>?)
            ?.map((e) => RiskAssessmentDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        documentsDirPath: json['documentsDirPath'],
        hazardIconOpacity: json["hazard_icon_opacity"] as int?,
        linkingPreference: json["linking_preference"] as int?,
        );
  }
  static RiskAssessmentDto fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return RiskAssessmentDto.fromJson(jsonMap);
  }

  Future<void> prepareEntityForPDF() async {
    companyDto?.companyLogoMemoryImage = await TbPdfHelper()
        .generateMemoryImageForPath(companyDto?.imagePath ?? "");

    userDto?.signatureMemoryImage = await TbPdfHelper()
        .generateMemoryImageForPath(userDto?.imagePath ?? "");

    if (((mapImagePath ?? "").isNotEmpty)) {
      mapMemoryImage =
          await TbPdfHelper().generateMemoryImageForPath(mapImagePath ?? "");
    }

    // update memory image list assessment image
    await Future.forEach(listAssessmentImage ?? [], (element) async {
      AssessmentImageDto assessmentImageDto = element;

      assessmentImageDto.memoryImage = await TbPdfHelper()
          .generateMemoryImageForPath(
              assessmentImageDto.assessmentImagePath ?? "");
    });

    // update the memory image in listReferenceImage

    await Future.forEach(listReferenceImage ?? [], (element) async {
      ReferenceImageDto referImageEntity = element;

      referImageEntity.memoryImage = await TbPdfHelper()
          .generateMemoryImageForPath(
              referImageEntity.referenceImagePath ?? "");
    });

    // update the memory image in list hazards
    await Future.forEach(listHazards ?? [], (element) async {
      HazardDto hazardEntity = element;

      hazardEntity.memoryImage = await TbPdfHelper()
          .generateMemoryImageForPath(hazardEntity.hazardIconPath ?? "");
    });

    // update the memory image in review sign off users
    await Future.forEach(
      listReviewSignOffUsers ?? [],
      (element) async {
        ReviewSignOffUserDto reviewUserDto = element;

        reviewUserDto.memoryImage = await TbPdfHelper()
            .generateMemoryImageForPath(reviewUserDto.imagePath ?? "");
      },
    );
  }
}
