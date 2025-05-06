import 'dart:convert';

import 'package:dart_pdf_package/src/ms/ms_pdf_data.dart';
import 'package:pdf/widgets.dart';

class IrPdfData {
  String? referenceNumber;
  int? access;
  String? companyLogo;
  int? accidentRelatedToWork;
  MemoryImage? companyLogoMemoryImage;
  String? titleForPDF;
  String? companyPhoneEmail;
  String companyDetails;
  String? anotherIllHealth;
  String? anotherInjury;
  int? anySubtanceInvolve = 0;
  int? anyWitness = 0;
  String? bodySketchPath;
  int? isSubscribed;
  int? connectionToIncident;
  String? areaManagerName;
  String? currentLocation;
  String? location;
  int? firstAidGiven = 0;
  String? firstAidDetails;

  String? howRelatedToWork;
  String? illHealthComment;
  String? injuredBodyPart;
  String? injuryComment;
  String? injurySeriousness;
  int? isInfoBeingShared;
  int? isManagerAware = 0;
  int? isRiddor;
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

  String? whatHappen;
  String? whatHappenNext;

  String? zipCode;
  String? otherReasonForPresence;

  // is draft is for show
  int? isDraft = 1;

  // use holds the incident report Manager
  IrManagerData? incidentReportManagerData;

  String? reportingManagerId;

  String? reportingTime;

  UserSignatureData? userSignature;

  /// Determines if incident Report is being edited or is the fresh Incident Report

  IrUserData? incidentReportUsers;

  IrInjuryPersonData? incidentReportInjuryPerson;

  // this list holds the manager
  List<IrManagerData>? listIncidentReportManager = List.empty(growable: true);

  // this list holds the selected options
  List<IrInjuryOptionData>? listIncidentReportInjuryOptions =
      List.empty(growable: true);

  // holds the all the options
  List<IrOptionData>? listIncidentReportOptions = List.empty(growable: true);

  // this list holds the photo related to incident report which having reportingtype injury type and near miss type
  List<IrInjuryPhoto>? listIncidentInjuryPhoto = List.empty(
    growable: true,
  );
  // this list holds the witness
  List<IrWitnessData>? listIncidentReportWitness = List.empty(
    growable: true,
  );
  List<IrInjuredBodyPartData>? listIncidentInjuredBodyParts = List.empty(
    growable: true,
  );

  // holds the memory sket
  MemoryImage? memorySketchImage;
  // holds the memory image of map image
  MemoryImage? memoryLocationMapImage;

  // holds the ir logo memory image

  String? locationMapImagePath;

  String? bodySketchImagePath;

  IrPdfData({
    this.companyLogo,
    this.companyLogoMemoryImage,
    required this.companyDetails,
    this.isSubscribed,
    this.companyPhoneEmail,
    this.referenceNumber,
    this.access,
    this.accidentRelatedToWork,
    this.anotherIllHealth,
    this.anotherInjury,
    this.anySubtanceInvolve = 0,
    this.anyWitness = 0,
    this.bodySketchPath,
    this.connectionToIncident,
    this.currentLocation,
    this.firstAidGiven = 0,
    this.firstAidDetails,
    this.howRelatedToWork,
    this.illHealthComment,
    this.injuredBodyPart,
    this.injuryComment,
    this.injurySeriousness,
    this.incidentReportUsers,
    this.isInfoBeingShared,
    this.isManagerAware = 0,
    this.isRiddor,
    this.lattitude,
    this.incidentReportInjuryPerson,
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
    this.titleForPDF,
    this.reportedRelation = 0,
    this.reportingDate,
    this.reportingType,
    this.reportingUserId,
    this.sameOrganisation = 0,
    this.substanceDetails,
    this.whatHappen,
    this.whatHappenNext,
    this.userSignature,
    this.zipCode,
    this.reportingTime,
    this.listIncidentReportManager,
    this.listIncidentReportOptions,
    this.listIncidentReportInjuryOptions,
    this.listIncidentInjuryPhoto,
    this.reportingManagerId,
    required this.listIncidentReportWitness,
    this.incidentReportManagerData,
    this.listIncidentInjuredBodyParts,
    this.otherReasonForPresence,
    this.areaManagerName,
    this.location,
    this.memoryLocationMapImage,
    this.memorySketchImage,
    this.locationMapImagePath,
    this.bodySketchImagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'referenceNumber': referenceNumber,
      'access': access,
      'accidentRelatedToWork': accidentRelatedToWork,
      'anotherIllHealth': anotherIllHealth,
      'anotherInjury': anotherInjury,
      'anySubtanceInvolve': anySubtanceInvolve,
      'anyWitness': anyWitness,
      'bodySketchPath': bodySketchPath,
      'isSubscribed': isSubscribed,
      'connectionToIncident': connectionToIncident,
      'areaManagerName': areaManagerName,
      'currentLocation': currentLocation,
      'location': location,
      'firstAidGiven': firstAidGiven,
      'firstAidDetails': firstAidDetails,
      'howRelatedToWork': howRelatedToWork,
      'illHealthComment': illHealthComment,
      'injuredBodyPart': injuredBodyPart,
      'injuryComment': injuryComment,
      'injurySeriousness': injurySeriousness,
      'isInfoBeingShared': isInfoBeingShared,
      'isManagerAware': isManagerAware,

      'managerName': managerName,
      'mapImagePath': mapImagePath,
      'numberOfDaysOffWork': numberOfDaysOffWork,
      'offWorkNeed': offWorkNeed,
      'otherBodyPart': otherBodyPart,
      'otherConnection': otherConnection,
      'preventionOfIncident': preventionOfIncident,
      'reasonForPresence': reasonForPresence,
      'refNo': refNo,
      'reportedRelation': reportedRelation,
      'reportingDate': reportingDate,
      'reportingType': reportingType,
      'reportingUserId': reportingUserId,
      'sameOrganisation': sameOrganisation,
      'substanceDetails': substanceDetails,
      'whatHappen': whatHappen,
      'whatHappenNext': whatHappenNext,
      'zipCode': zipCode,
      'otherReasonForPresence': otherReasonForPresence,
      'reportingManagerId': reportingManagerId,
      'reportingTime': reportingTime,
      'userData': userSignature?.toJson(),
      'irManagerData': incidentReportManagerData?.toJson(),
      'irUsers': incidentReportUsers?.toJson(),
      'irInjuryPerson': incidentReportInjuryPerson?.toJson(),
      'irManager': listIncidentReportManager?.map((e) => e.toJson()).toList(),
      // 'listIncidentReportInjuryOptions':
      "irInjuryOptionsData":
          listIncidentReportInjuryOptions?.map((e) => e.toJson()).toList(),
      // 'listIncidentReportOptions':
      // "irOptionsData":
      //     listIncidentReportOptions?.map((e) => e.toJson()).toList(),
      // 'listIncidentInjuryPhoto':
      "irInjuryPhoto": listIncidentInjuryPhoto?.map((e) => e.toJson()).toList(),
      // 'listIncidentReportWitness':

      "irWitnessData":
          listIncidentReportWitness?.map((e) => e.toJson()).toList(),
      // 'listIncidentInjuredBodyParts':
      "irInjuredBodyPart":
          listIncidentInjuredBodyParts?.map((e) => e.toJson()).toList(),
    };
  }

  factory IrPdfData.fromJson(Map<String, dynamic> json) {
    return IrPdfData(
      companyDetails: json['companyDetails'],
      companyPhoneEmail: json['companyPhoneEmail'],
      referenceNumber: json['referenceNumber'],
      access: json['access'],
      accidentRelatedToWork: json['accidentRelatedToWork'],
      anotherIllHealth: json['anotherIllHealth'],
      anotherInjury: json['anotherInjury'],
      anySubtanceInvolve: json['anySubtanceInvolve'] ?? 0,
      anyWitness: json['anyWitness'] ?? 0,
      bodySketchPath: json['bodySketchPath'],
      isSubscribed: json['isSubscribed'],
      connectionToIncident: json['connectionToIncident'],
      areaManagerName: json['areaManagerName'],
      currentLocation: json['currentLocation'],
      location: json['location'],
      firstAidGiven: json['firstAidGiven'] ?? 0,
      firstAidDetails: json['firstAidDetails'],
      howRelatedToWork: json['howRelatedToWork'],
      illHealthComment: json['illHealthComment'],
      injuredBodyPart: json['injuredBodyPart'],
      injuryComment: json['injuryComment'],
      injurySeriousness: json['injurySeriousness'],
      isInfoBeingShared: json['isInfoBeingShared'],
      isManagerAware: json['isManagerAware'] ?? 0,
      isRiddor: json['isRiddor'],
      lattitude: json['lattitude'],
      longitude: json['longitude'],
      managerName: json['managerName'],
      mapImagePath: json['mapImagePath'],
      numberOfDaysOffWork: json['numberOfDaysOffWork'],
      offWorkNeed: json['offWorkNeed'],
      otherBodyPart: json['otherBodyPart'],
      otherConnection: json['otherConnection'],
      preventionOfIncident: json['preventionOfIncident'],
      procoreId: json['procoreId'],
      reasonForPresence: json['reasonForPresence'],
      refNo: json['refNo'] as String?,
      reportedRelation: json['reportedRelation'] ?? 0,
      reportingDate: json['reportingDate'],
      reportingType: json['reportingType'],
      reportingUserId: json['reportingUserId'],
      sameOrganisation: json['sameOrganisation'] ?? 0,
      substanceDetails: json['substanceDetails'],
      whatHappen: json['whatHappen'],
      whatHappenNext: json['whatHappenNext'],
      zipCode: json['zipCode'],
      otherReasonForPresence: json['otherReasonForPresence'],
      reportingManagerId: json['reportingManagerId'],
      reportingTime: json['reportingTime'],
      locationMapImagePath: json["map_image_path"],
      bodySketchImagePath: json["body_sketch_path"] as String?,
      userSignature: json['userSignature'] != null
          ? UserSignatureData.fromJson(json['userData'])
          : null,
      incidentReportManagerData: json['irManagerData'] != null
          ? IrManagerData.fromJson(json['irManagerData'])
          : null,
      incidentReportUsers: json['irUserData'] != null
          ? IrUserData.fromJson(json['irUserData'])
          : null,
      incidentReportInjuryPerson: json['irInjuryPerson'] != null
          ? IrInjuryPersonData.fromJson(json['irInjuryPerson'])
          : null,
      listIncidentReportManager: (json['irManagerData'] as List<dynamic>?)
              ?.map((e) => IrManagerData.fromJson(e))
              .toList() ??
          [],
      listIncidentReportInjuryOptions:
          (json['irInjuryOptionsData'] as List<dynamic>?)
                  ?.map((e) => IrInjuryOptionData.fromJson(e))
                  .toList() ??
              [],
      listIncidentReportOptions: (json['irOptionData'] as List<dynamic>?)
              ?.map((e) => IrOptionData.fromJson(e))
              .toList() ??
          [],
      listIncidentInjuryPhoto: (json['irInjuryPhoto'] as List<dynamic>?)
              ?.map((e) => IrInjuryPhoto.fromJson(e))
              .toList() ??
          [],
      listIncidentReportWitness: (json['irWitnessData'] as List<dynamic>?)
              ?.map((e) => IrWitnessData.fromJson(e))
              .toList() ??
          [],
      listIncidentInjuredBodyParts:
          (json['irInjuredBodyPart'] as List<dynamic>?)
                  ?.map((e) => IrInjuredBodyPartData.fromJson(e))
                  .toList() ??
              [],
    );
  }

  factory IrPdfData.fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return IrPdfData.fromJson(jsonMap);
  }
}

class IrInjuredBodyPartData {
  String? injuredBodyName;

  IrInjuredBodyPartData({
    this.injuredBodyName,
  });

  Map<String, dynamic> toJson() {
    return {
      'injuredBodyName': injuredBodyName,
    };
  }

  factory IrInjuredBodyPartData.fromJson(Map<String, dynamic> json) {
    return IrInjuredBodyPartData(
      injuredBodyName: json['injuredBodyName'] as String?,
    );
  }
}

class IrUserData {
  String? userName;
  String? address1;
  String? address2;
  String? email;
  String? position;
  String? postcode;
  String? telephone;
  String? jobTitle;

  IrUserData({
    this.address1,
    this.address2,
    this.email,
    this.position,
    this.postcode,
    this.telephone,
    this.userName,
    this.jobTitle,
  });

  factory IrUserData.fromJson(Map<String, dynamic> json) {
    return IrUserData(
      userName: json['userName'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      email: json['email'] as String?,
      position: json['position'] as String?,
      postcode: json['postcode'] as String?,
      telephone: json['telephone'] as String?,
      jobTitle: json['jobTitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'address1': address1,
      'address2': address2,
      'email': email,
      'position': position,
      'postcode': postcode,
      'telephone': telephone,
      'jobTitle': jobTitle,
    };
  }
}

class IrInjuryPersonData {
  String? address1;
  String? address2;
  String? address3;
  String? email;
  String? name;
  String? position;
  String? postcode;
  String? telephone;
  String? jobTitle;

  IrInjuryPersonData({
    this.jobTitle,
    this.address1,
    this.address2,
    this.address3,
    this.email,
    this.name,
    this.position,
    this.postcode,
    this.telephone,
  });

  Map<String, dynamic> toJson() {
    return {
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'email': email,
      'name': name,
      'position': position,
      'postcode': postcode,
      'telephone': telephone,
      'jobTitle': jobTitle,
    };
  }

  factory IrInjuryPersonData.fromJson(Map<String, dynamic> json) {
    return IrInjuryPersonData(
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      position: json['position'] as String?,
      postcode: json['postcode'] as String?,
      telephone: json['telephone'] as String?,
      jobTitle: json['jobTitle'] as String?,
    );
  }
}

class IrOptionData {
  int? id;
  int? type;
  String? name;

  IrOptionData({
    this.id,
    this.type,
    this.name,
  });

  factory IrOptionData.fromJson(Map<String, dynamic> json) {
    return IrOptionData(
      id: json['id'] as int?,
      type: json['type'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
    };
  }
}

class IrInjuryPhoto {
  String? image;
  int? order;

  MemoryImage? memoryImage;

  IrInjuryPhoto({
    this.image,
    this.order,
    this.memoryImage,
  });

  factory IrInjuryPhoto.fromJson(Map<String, dynamic> json) {
    return IrInjuryPhoto(
      image: json['image'] as String?,
      order: json['order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'order': order,
    };
  }
}

class IrWitnessData {
  String? address1;
  String? address2;
  String? address3;
  String? email;
  String? name;
  String? position;
  String? postcode;
  String? telephone;
  String? jobTitle;

  IrWitnessData({
    this.jobTitle,
    this.address1,
    this.address2,
    this.address3,
    this.email,
    this.name,
    this.position,
    this.postcode,
    this.telephone,
  });

  Map<String, dynamic> toJson() {
    return {
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'email': email,
      'name': name,
      'position': position,
      'postcode': postcode,
      'telephone': telephone,
      'jobTitle': jobTitle,
    };
  }

  factory IrWitnessData.fromJson(Map<String, dynamic> json) {
    return IrWitnessData(
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      position: json['position'] as String?,
      postcode: json['postcode'] as String?,
      telephone: json['telephone'] as String?,
      jobTitle: json['jobTitle'] as String?,
    );
  }
}

class IrManagerData {
  String? email;
  String? jobTitle;

  String? name;

  IrManagerData({
    this.email,
    this.jobTitle,
    this.name,
  });

  factory IrManagerData.fromJson(Map<String, dynamic> json) {
    return IrManagerData(
      email: json['email'] as String?,
      jobTitle: json['jobTitle'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'jobTitle': jobTitle,
    };
  }
}

class IrInjuryOptionData {
  int? id;
  String? name;
  int? order;
  int? type;
  IrInjuryOptionData({
    this.id,
    this.order,
    this.name,
    this.type,
  });

  factory IrInjuryOptionData.fromJson(Map<String, dynamic> json) {
    return IrInjuryOptionData(
      id: json['id'] as int?,
      order: json['order'] as int?,
      name: json['name'] as String?,
      type: json['type'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'name': name,
      'type': type,
    };
  }
}
