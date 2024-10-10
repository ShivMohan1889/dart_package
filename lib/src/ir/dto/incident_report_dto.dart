
import 'package:dart_pdf_package/src/audit/dto/company_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/user_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_injury_person_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_injury_option_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_manager_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_option_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_photo_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_user_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_witness_dto.dart';
import 'package:pdf/widgets.dart';



class IncidentReportDto {
  int? id;
  String? referenceNumber;
  int? access;
  int? accidentRelatedToWork;

  //  use for selection of incident Report entity into the incidentReportList
  int? isSelected = 0;

  String? anotherIllHealth;
  String? anotherInjury;
  int? anySubtanceInvolve = 0;
  int? anyWitness = 0;
  String? bodySketchPath;

  int? isSubscribed;

  int? companyId;
  int? connectionToIncident;

  String? areaManagerName;

  String? currentLocation;

  String? location;

  int? departmentId;
  int? firstAidGiven = 0;
  String? firstAidDetails;
  int? folderId;
  String? howRelatedToWork;
  String? illHealthComment;
  String? injuredBodyPart;
  String? injuryComment;
  String? injurySeriousness;
  int? isInfoBeingShared;
  int? isManagerAware = 0;
  int? isRiddor;

  /// this flag is to check the given incident report is upload on to the or not  server
  int? isUploaded = 0;
  int? isUploadedBox;
  int? isUploadedDropbox;
  int? isUploadedGoogleDrive;
  int? isUploadedOneDrive;
  int? isUploadedProcore;
  double? lattitude;
  double? longitude;
  String? managerName;
  String? mapImagePath;
  int? numberOfDaysOffWork;
  int? offWorkNeed;
  String? otherBodyPart;
  String? otherConnection;
  String? pdfPath;
  int? preventionOfIncident;
  int? procoreId;
  int? reasonForPresence;
  String? refNo;
  int? reportedRelation = 0;
  String? reportingDate;
  int? reportingType;
  int? reportingUserId;
  int? sameOrganisation = 0;
  String? substanceDetails;
  String? uniqueKey;

  int? userId;
  int? cloudUserId;
  String? whatHappen;
  String? whatHappenNext;

  String? zipCode;
  CompanyDto? companyDto;
  String? otherReasonForPresence;

  int? isGetlocation = 0;

  // is draft is for show
  int? isDraft = 1;

  // use holds the incident report Manager
  IncidentReportManagerDto? incidentReportManagerDto;

  String? reportingManagerId;

  String? reportingTime;

  UserDto? userDto;

  int? buttonSelectedToShow = 0;

  String? dropboxFileId;
  String? boxnetFileId;
  String? googleDriveFileId;
  String? oneDriveFileId;
  String? procoreFileId;
  String? pdfName;

  /// Determines if incident Report is being edited or is the fresh Incident Report
  int isBeingEdited = 0;

  IncidentReportUserDto? incidentReportUsers;

  IncidentInjuryPersonDto? incidentReportInjuryPerson;

  // this list holds the manager
  List<IncidentReportManagerDto> listIncidentReportManager =
      List.empty(growable: true);

  // this list holds the selected options
  List<IncidentReportInjuryOptionDto> listIncidentReportInjuryOptions =
      List.empty(growable: true);

  // holds the all the options
  List<IncidentReportOptionDto> listIncidentReportOptions =
      List.empty(growable: true);

  // this list holds the photo related to incident report which having reportingtype injury type and near miss type
  List<IncidentInjuryPhotoDto> listIncidentInjuryPhoto = List.empty(
    growable: true,
  );
  // this list holds the witness
  List<IncidentReportWitnessDto> listIncidentReportWitness = List.empty(
    growable: true,
  );
  // List<IncidentInjuredBodyPartDto> listIncidentInjuredBodyParts = List.empty(
  //   growable: true,
  // );

  // holds the memory sket
  MemoryImage? memorySketchImage;
  // holds the memory image of map image
  MemoryImage? memoryLocationMapImage;

  // holds the ir logo memory image

  IncidentReportDto({
    this.isSubscribed,
    this.id,
    this.referenceNumber,
    this.access,
    this.accidentRelatedToWork,
    this.anotherIllHealth,
    this.anotherInjury,
    this.anySubtanceInvolve = 0,
    this.anyWitness = 0,
    this.bodySketchPath,
    this.companyId,
    this.connectionToIncident,
    this.currentLocation,
    this.departmentId,
    this.firstAidGiven = 0,
    this.firstAidDetails,
    this.folderId,
    this.howRelatedToWork,
    this.illHealthComment,
    this.injuredBodyPart,
    this.injuryComment,
    this.injurySeriousness,
    this.isInfoBeingShared,
    this.isManagerAware = 0,
    this.isRiddor,
    this.isUploaded = 0,
    this.isUploadedBox,
    this.isUploadedDropbox,
    this.isUploadedGoogleDrive,
    this.isUploadedOneDrive,
    this.isUploadedProcore,
    this.lattitude,
    this.longitude,
    this.managerName,
    this.mapImagePath,
    this.numberOfDaysOffWork,
    this.offWorkNeed,
    this.otherBodyPart,
    this.otherConnection,
    this.pdfPath,
    this.preventionOfIncident,
    this.procoreId,
    this.reasonForPresence,
    this.refNo,
    this.reportedRelation = 0,
    this.reportingDate,
    this.reportingType,
    this.reportingUserId,
    this.sameOrganisation = 0,
    this.substanceDetails,
    this.uniqueKey,
    this.userId,
    this.whatHappen,
    this.whatHappenNext,
    this.companyDto,
    this.userDto,
    this.zipCode,
    this.reportingTime,
    required this.listIncidentReportManager,
    required this.listIncidentReportOptions,
    required this.listIncidentReportInjuryOptions,
    this.buttonSelectedToShow = 0,
    required this.listIncidentInjuryPhoto,
    this.reportingManagerId,
    required this.listIncidentReportWitness,
    this.incidentReportManagerDto,
    this.isSelected = 0,
    this.isGetlocation = 0,
    // required this.listIncidentInjuredBodyParts,
    this.otherReasonForPresence,
    this.areaManagerName,
    this.location,
    this.isDraft = 1,
    this.dropboxFileId,
    this.boxnetFileId,
    this.googleDriveFileId,
    this.oneDriveFileId,
    this.procoreFileId,
    this.memoryLocationMapImage,
    this.memorySketchImage,
    this.pdfName,
    this.cloudUserId,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'referenceNumber': referenceNumber,
  //     'access': access,
  //     'accidentRelatedToWork': accidentRelatedToWork,
  //     'isSelected': isSelected,
  //     'anotherIllHealth': anotherIllHealth,
  //     'anotherInjury': anotherInjury,
  //     'anySubtanceInvolve': anySubtanceInvolve,
  //     'anyWitness': anyWitness,
  //     'bodySketchPath': bodySketchPath,
  //     'isSubscribed': isSubscribed,
  //     'companyId': companyId,
  //     'connectionToIncident': connectionToIncident,
  //     'areaManagerName': areaManagerName,
  //     'currentLocation': currentLocation,
  //     'location': location,
  //     'departmentId': departmentId,
  //     'firstAidGiven': firstAidGiven,
  //     'firstAidDetails': firstAidDetails,
  //     'folderId': folderId,
  //     'howRelatedToWork': howRelatedToWork,
  //     'illHealthComment': illHealthComment,
  //     'injuredBodyPart': injuredBodyPart,
  //     'injuryComment': injuryComment,
  //     'injurySeriousness': injurySeriousness,
  //     'isInfoBeingShared': isInfoBeingShared,
  //     'isManagerAware': isManagerAware,
  //     'isRiddor': isRiddor,
  //     'isUploaded': isUploaded,
  //     'isUploadedBox': isUploadedBox,
  //     'isUploadedDropbox': isUploadedDropbox,
  //     'isUploadedGoogleDrive': isUploadedGoogleDrive,
  //     'isUploadedOneDrive': isUploadedOneDrive,
  //     'isUploadedProcore': isUploadedProcore,
  //     'lattitude': lattitude,
  //     'longitude': longitude,
  //     'managerName': managerName,
  //     'mapImagePath': mapImagePath,
  //     'numberOfDaysOffWork': numberOfDaysOffWork,
  //     'offWorkNeed': offWorkNeed,
  //     'otherBodyPart': otherBodyPart,
  //     'otherConnection': otherConnection,
  //     'pdfPath': pdfPath,
  //     'preventionOfIncident': preventionOfIncident,
  //     'procoreId': procoreId,
  //     'reasonForPresence': reasonForPresence,
  //     'refNo': refNo,
  //     'reportedRelation': reportedRelation,
  //     'reportingDate': reportingDate,
  //     'reportingType': reportingType,
  //     'reportingUserId': reportingUserId,
  //     'sameOrganisation': sameOrganisation,
  //     'substanceDetails': substanceDetails,
  //     'uniqueKey': uniqueKey,
  //     'userId': userId,
  //     'cloudUserId': cloudUserId,
  //     'whatHappen': whatHappen,
  //     'whatHappenNext': whatHappenNext,
  //     'zipCode': zipCode,
  //     'otherReasonForPresence': otherReasonForPresence,
  //     'isGetlocation': isGetlocation,
  //     'isDraft': isDraft,
  //     'reportingManagerId': reportingManagerId,
  //     'reportingTime': reportingTime,
  //     'buttonSelectedToShow': buttonSelectedToShow,
  //     'dropboxFileId': dropboxFileId,
  //     'boxnetFileId': boxnetFileId,
  //     'googleDriveFileId': googleDriveFileId,
  //     'oneDriveFileId': oneDriveFileId,
  //     'procoreFileId': procoreFileId,
  //     'pdfName': pdfName,
  //     'isBeingEdited': isBeingEdited,
  //     'companyDto': companyDto?.toJson(),
  //     'userDto': userDto?.toJson(),
  //     'incidentReportManagerDto': incidentReportManagerDto?.toJson(),
  //     'incidentReportUsers': incidentReportUsers?.toJson(),
  //     'incidentReportInjuryPerson': incidentReportInjuryPerson?.toJson(),
  //     'listIncidentReportManager':
  //         listIncidentReportManager.map((e) => e.toJson()).toList(),
  //     'listIncidentReportInjuryOptions':
  //         listIncidentReportInjuryOptions.map((e) => e.toJson()).toList(),
  //     'listIncidentReportOptions':
  //         listIncidentReportOptions.map((e) => e.toJson()).toList(),
  //     'listIncidentInjuryPhoto':
  //         listIncidentInjuryPhoto.map((e) => e.toJson()).toList(),
  //     'listIncidentReportWitness':
  //         listIncidentReportWitness.map((e) => e.toJson()).toList(),
  //     'listIncidentInjuredBodyParts':
  //         listIncidentInjuredBodyParts.map((e) => e.toJson()).toList(),
  //   };
  
}
