import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_data.dart';
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
    this.mapMemoryImage,
    required this.hazards,
    required this.keyStaff,
    required this.assessmentImages,
    required this.referenceImages,
    required this.weatherItems,
    required this.signOffUsers,
    required this.userSignature,
    this.reviewSignature,
    this.listChildren = const [],
    this.msPdfData,
    this.signOffStatementReport,
  });
  final String titleForPDF;
  final String? companyLogo;
  final MemoryImage? companyLogoMemoryImage;
  final String companyDetails;
  final String companyPhoneEmail;
  final String? signOffStatementReport;

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

  final MemoryImage? mapMemoryImage;
  final List<HazardPdfModel> hazards;
  final List<String> keyStaff;
  final List<AssessmentImagePdfModel> assessmentImages;
  final List<ReferenceImagePdfModel> referenceImages;
  final List<WeatherPdfModel> weatherItems;
  final List<ReviewSignOffSignatureData> signOffUsers;
  final UserSignatureData userSignature;
  final ReviewSignOffSignatureData? reviewSignature;
  final List<RaPdfData> listChildren;
  final MsPdfData? msPdfData;

  String? get uniqueKey => '${name}_${referenceNumber ?? ""}';
}

class HazardPdfModel {
  HazardPdfModel({
    required this.name,
    required this.cellPosition,
    required this.harm,
    required this.worstCase,
    required this.likelihoods,
    required this.additionalLikelihood,
    required this.score,
    required this.rating,
    required this.additionalRating,
    required this.additionalScore,
    required this.cellRiskNumber,
    required this.existingControls,
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
  final MemoryImage? memoryImage;
  final List<String> existingControls;
  final List<String>? additionalControls;
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
  final MemoryImage? memoryImage;
  final int index;
}

class ReferenceImagePdfModel {
  ReferenceImagePdfModel({
    required this.index,
    required this.image,
    this.memoryImage,
  });

  final String? image;
  final MemoryImage? memoryImage;
  final String index;
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
}
