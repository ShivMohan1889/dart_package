import 'package:dart_pdf_package/src/ms/ms_pdf_data.dart';
import 'package:pdf/widgets.dart';

/// A dedicated model class to hold all the data required for PDF generation
/// This separates the data preparation concerns from PDF rendering
class RaPdfData {
  RaPdfData({
    this.companyLogoMemoryImage,
    required this.titleForPDF,
    this.companyLogo,
    required this.companyDetails,
    required this.companyPhoneEmail,
    required this.name,
    required this.description,
    required this.referenceNumber,
    required this.isSubscribed,
    required this.assessmentType,
    required this.assessmentDate,
    required this.workStartDate,
    required this.workEndDate,
    required this.anotherAssessmentRequired,
    required this.anotherAssessmentDate,
    required this.location,
    required this.fire,
    required this.coshh,
    required this.manualHandling,
    required this.displayHandling,
    required this.youngPerson,
    required this.employees,
    required this.visitors,
    required this.contractors,
    required this.membersOfPublic,
    required this.others,
    required this.nursingExpectantMums,
    required this.youngPerson2,
    required this.disabled,
    required this.serviceUsers,
    required this.signOffMode,
    required this.approvalMode,
    required this.numberOfSigneeRequired,
    required this.hazardIconOpacity,
    required this.linkingPreference,
    this.mapMemoryImage,
    required this.hazards,
    this.keyStaff,
    this.assessmentImages,
    this.referenceImages,
    this.weatherItems,
    this.signOffUsers,
    required this.userSignature,
    this.reviewSignature,
    this.listChildren = const [],
    this.msPdfData,
    required this.signOffStatementReport,
    this.mapImagePath,

  });
  final String titleForPDF;
  String? companyLogo;
  MemoryImage? companyLogoMemoryImage;
  final String companyDetails;
  final String companyPhoneEmail;
  final String signOffStatementReport;
  final int? linkingPreference;

  final String name;
  final String description;
  final String? referenceNumber;
  final int isSubscribed;
  final int assessmentType;
  final String assessmentDate;
  final String workStartDate;
  final String workEndDate;
  final int anotherAssessmentRequired;
  final String? anotherAssessmentDate;
  final String? location;
  final int fire;
  final int coshh;
  final int manualHandling;
  final int displayHandling;
  final int youngPerson;
  final int employees;
  final int visitors;
  final int contractors;
  final int membersOfPublic;
  final int others;
  final int nursingExpectantMums;
  final int youngPerson2;
  final int disabled;
  final int serviceUsers;
  final int? signOffMode;
  final int? approvalMode;
  final int? numberOfSigneeRequired;
  final int? hazardIconOpacity;
  String? mapImagePath;

   MemoryImage? mapMemoryImage;
  final List<HazardPdfModel> hazards;
  final List<String>? keyStaff;
  final List<AssessmentImagePdfModel>? assessmentImages;
  final List<ReferenceImagePdfModel>? referenceImages;
  final List<WeatherPdfModel>? weatherItems;
  final List<ReviewSignOffSignatureData>? signOffUsers;
  final UserSignatureData userSignature;
  final ReviewSignOffSignatureData? reviewSignature;
  final List<RaPdfData>? listChildren;
  final MsPdfData? msPdfData;

  String? get uniqueKey => '${name}_${referenceNumber ?? ""}';

  Map<String, dynamic> toJson() {
    return {
      'titleForPDF': titleForPDF,
      'companyLogo': companyLogo,
      'companyDetails': companyDetails,
      'companyPhoneEmail': companyPhoneEmail,
      'name': name,
      'description': description,
      'referenceNumber': referenceNumber,
      'isSubscribed': isSubscribed,
      'assessmentType': assessmentType,
      'assessmentDate': assessmentDate,
      'workStartDate': workStartDate,
      'workEndDate': workEndDate,
      'anotherAssessmentRequired': anotherAssessmentRequired,
      'anotherAssessmentDate': anotherAssessmentDate,
      'location': location,
      'fire': fire,
      'coshh': coshh,
      'mapImagePath': mapImagePath,
      'manualHandling': manualHandling,
      'displayHandling': displayHandling,
      'youngPerson': youngPerson,
      'employees': employees,
      'visitors': visitors,
      'contractors': contractors,
      'membersOfPublic': membersOfPublic,
      'others': others,
      'nursingExpectantMums': nursingExpectantMums,
      'youngPerson2': youngPerson2,
      'disabled': disabled,
      'serviceUsers': serviceUsers,
      'signOffMode': signOffMode,
      'approvalMode': approvalMode,
      'numberOfSigneeRequired': numberOfSigneeRequired,
      'hazardIconOpacity': hazardIconOpacity,
      'hazards': hazards.map((h) => h.toJson()).toList(),
      'keyStaff': keyStaff,
      'assessmentImages': assessmentImages?.map((img) => img.toJson()).toList(),
      'referenceImages': referenceImages?.map((img) => img.toJson()).toList(),
      'weatherItems': weatherItems?.map((w) => w.toJson()).toList(),
      'signOffUsers': signOffUsers?.map((u) => u.toJson()).toList(),
      'userSignature': userSignature.toJson(),
      'reviewSignature': reviewSignature?.toJson(),
      'listChildren': listChildren?.map((child) => child.toJson()).toList(),
      'msPdfData': msPdfData?.toJson(),
      'signOffStatementReport': signOffStatementReport,
    };
  }

  /// Create a model from a JSON map, ignoring MemoryImage fields
  static RaPdfData fromJson(Map<String, dynamic> json) {
    return RaPdfData(
      linkingPreference: json['linkingPreference'],
      titleForPDF: json['titleForPDF'],
      companyLogo: json['companyLogo'],
      companyDetails: json['companyDetails'],
      companyPhoneEmail: json['companyPhoneEmail'],
      name: json['name'],
      description: json['description'],
      referenceNumber: json['referenceNumber'],
      isSubscribed: json['isSubscribed'],
      assessmentType: json['assessmentType'],
      assessmentDate: json['assessmentDate'],
      workStartDate: json['workStartDate'],
      workEndDate: json['workEndDate'],
      anotherAssessmentRequired: json['anotherAssessmentRequired'],
      anotherAssessmentDate: json['anotherAssessmentDate'],
      location: json['location'],
      fire: json['fire'],
      coshh: json['coshh'],
      manualHandling: json['manualHandling'],
      displayHandling: json['displayHandling'],
      youngPerson: json['youngPerson'],
      employees: json['employees'],
      visitors: json['visitors'],
      contractors: json['contractors'],
      membersOfPublic: json['membersOfPublic'],
      others: json['others'],
      nursingExpectantMums: json['nursingExpectantMums'],
      youngPerson2: json['youngPerson2'],
      disabled: json['disabled'],
      serviceUsers: json['serviceUsers'],
      signOffMode: json['signOffMode'],
      approvalMode: json['approvalMode'],
      numberOfSigneeRequired: json['numberOfSigneeRequired'],
      hazardIconOpacity: json['hazardIconOpacity'],
      mapImagePath:   json["mapImagePath"] as String?,
      
      hazards: (json['hazards'] as List)
          .map((h) => HazardPdfModel.fromJson(h))
          .toList(),
      keyStaff:
          json['keyStaff'] == null ? [] : List<String>.from(json['keyStaff']),
      assessmentImages: (json['assessmentImages'] as List<dynamic>?)
          ?.map((img) => AssessmentImagePdfModel.fromJson(img))
          .toList(),
      referenceImages: (json['referenceImages'] as List<dynamic>?)
          ?.map((img) => ReferenceImagePdfModel.fromJson(img))
          .toList(),
      weatherItems: (json['weatherItems'] as List<dynamic>?)
          ?.map((w) => WeatherPdfModel.fromJson(w))
          .toList(),
      signOffUsers: (json['signOffUsers'] as List<dynamic>?)
          ?.map((u) => ReviewSignOffSignatureData.fromJson(u))
          .toList(),
      userSignature: UserSignatureData.fromJson(json['userSignature']),
      reviewSignature: json['reviewSignature'] != null
          ? ReviewSignOffSignatureData.fromJson(json['reviewSignature'])
          : null,
      listChildren: json['listChildren'] != null
          ? (json['listChildren'] as List)
              .map((child) => RaPdfData.fromJson(child))
              .toList()
          : [],
      msPdfData: json['msPdfData'] != null
          ? MsPdfData.fromJson(json['msPdfData'])
          : null,
      signOffStatementReport: json['signOffStatementReport'],
    );
  }
}

class HazardPdfModel {
  HazardPdfModel({
    required this.name,
    required this.cellPosition,
    this.harm,
    required this.worstCase,
    required this.likelihoods,
    required this.additionalLikelihood,
    required this.score,
    required this.rating,
    required this.additionalRating,
    required this.additionalScore,
    required this.cellRiskNumber,
    this.existingControls,
    this.additionalControls,
    this.memoryImage,
    this.imageURL,


  });

  final String name;
  final String? cellPosition;
  final String? harm;
  final String worstCase;
  final String likelihoods;
  final String? additionalLikelihood;
  final int score;
  final String rating;
  final String? additionalRating;
  final int? additionalScore;
  final int? cellRiskNumber;
  final String? imageURL;
  MemoryImage? memoryImage;
  final List<String>? existingControls;
  final List<String>? additionalControls;
  
  /// Convert the model to a JSON map, ignoring MemoryImage fields
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cellPosition': cellPosition,
      'harm': harm,
      'worstCase': worstCase,
      'likelihoods': likelihoods,
      'additionalLikelihood': additionalLikelihood,
      'score': score,
      'rating': rating,
      'additionalRating': additionalRating,
      'additionalScore': additionalScore,
      'cellRiskNumber': cellRiskNumber,
      'imageURL': imageURL,
      'existingControls': existingControls,
      'additionalControls': additionalControls,
    };
  }

  /// Create a model from a JSON map, ignoring MemoryImage fields
  static HazardPdfModel fromJson(Map<String, dynamic> json) {
    return HazardPdfModel(
      name: json['name'],
      cellPosition: json['cellPosition'],
      harm: json['harm'] as String?,
      worstCase: json['worstCase'] as String,
      likelihoods: json['likelihoods'],
      additionalLikelihood: json['additionalLikelihood'],
      score: json['score'],
      rating: json['rating'],
      additionalRating: json['additionalRating'],
      additionalScore: json['additionalScore'],
      cellRiskNumber: json['cellRiskNumber'],
      imageURL: json['imageURL'],
      existingControls: json['existingControls'] == null
          ? []
          : List<String>.from(json['existingControls']),
      additionalControls: json['additionalControls'] != null
          ? List<String>.from(json['additionalControls'])
          : null,
    );
  }
}

class AssessmentImagePdfModel {
  AssessmentImagePdfModel({
    required this.isSelected,
    this.image,
    this.memoryImage,
    required this.index,
  });

  final int isSelected;
  final String? image;
  MemoryImage? memoryImage;
  final int index;

  /// Convert the model to a JSON map, ignoring MemoryImage fields
  Map<String, dynamic> toJson() {
    return {
      'isSelected': isSelected,
      'image': image,
      'index': index,
    };
  }

  /// Create a model from a JSON map, ignoring MemoryImage fields
  static AssessmentImagePdfModel fromJson(Map<String, dynamic> json) {
    return AssessmentImagePdfModel(
      isSelected: json['isSelected'],
      image: json['image'],
      index: json['index'],
    );
  }
}

class ReferenceImagePdfModel {
  ReferenceImagePdfModel({
    required this.index,
    required this.image,
    this.memoryImage,
  });

  final String? image;
  MemoryImage? memoryImage;
  final int index;

  /// Convert the model to a JSON map, ignoring MemoryImage fields
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'index': index,
    };
  }

  /// Create a model from a JSON map, ignoring MemoryImage fields
  static ReferenceImagePdfModel fromJson(Map<String, dynamic> json) {
    return ReferenceImagePdfModel(
      image: json['image'],
      index: json['index'],
    );
  }
}

class WeatherPdfModel {
  WeatherPdfModel({
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.chancesOfRain,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    required this.uvIndex,
  });

  final String? date;
  final String? sunrise;
  final String? sunset;
  final String? chancesOfRain;
  final String? humidity;
  final String? windSpeed;
  final String? pressure;
  final String? visibility;
  final String? uvIndex;

  /// Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'sunrise': sunrise,
      'sunset': sunset,
      'chancesOfRain': chancesOfRain,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'pressure': pressure,
      'visibility': visibility,
      'uvIndex': uvIndex,
    };
  }

  /// Create a model from a JSON map
  static WeatherPdfModel fromJson(Map<String, dynamic> json) {
    return WeatherPdfModel(
      date: json['date'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      chancesOfRain: json['chancesOfRain'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'],
      pressure: json['pressure'],
      visibility: json['visibility'],
      uvIndex: json['uvIndex'],
    );
  }
}
