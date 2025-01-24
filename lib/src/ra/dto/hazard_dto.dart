import 'package:dart_pdf_package/src/ra/dto/hazard_control_dto.dart';
import 'package:pdf/widgets.dart' as w;

class HazardDto {
  int? id;
  String? name;
  String? liklihood;
  String? worstcase;
  String? imagePath;
  String? rating;
  int? score = 0;
  String? uniqueKey;
  int? isFavourite = 0;
  int? isOld = 0;
  int? companyId = 0;
  double? timestamp;
  int? order = 0;
  int? libraryId = 0;
  int? cloudCompanyId = 0;
  bool isSelected = false;

  // this given var is used to show the risk of harm related to incid
  String? harm;

  /// it will be used while generting pdf
  w.MemoryImage? memoryImage;

  /// Determines if a additional control is required
  /// [This filed is just used to make UI change to show/hide additional drop down]
  int isRequired = 0;

  /// determines if a hazard has been updated since the assessment was created
  /// and in this case we need to show that this has been updated user will
  /// see both the old and the new version of the hazard while selection
  int isUpdatedHazard = 0;

  /// Determines the name of the additional likelihood assigened to a hazard,
  /// this property will be used while creating assessment
  String? additionalLiklihood;

  /// Determines the additional score calculated for hazard,
  /// this property will be used while creating assessment
  int? additionalScore = 0;

  /// Determines the additional rating calculated for hazard,
  /// this property will be used while creating assessment
  String? additionalRating;

  /// Determines the cell position of an hazard in case of Grid Assessments
  /// this property will be used while creating assessment
  String? cellPosition;

  /// Determines the cell risk number of an hazard in case of Grid Assessments
  /// this property will be used while creating assessment
  int? cellRiskNumber = 0;

  /// uniqueKey for the assessment hazard - this will be different from the unique key
  /// which is the key for original hazard
  /// its not original hazard key. its clone's uniquekey
  String? assessmentHazardUniqueKey;

  /// this property
  int? isSelectedHazards = 0;

  List<HazardControlDto>? listHazardControlDto = List.empty(growable: true);

  int isStandard = 0;

  String? hazardIconPath;

  HazardDto({
    this.id,
    this.name,
    this.liklihood,
    this.worstcase,
    this.hazardIconPath,
    this.rating,
    this.score = 0,
    this.uniqueKey,
    this.isFavourite = 0,
    this.isOld = 0,
    this.companyId = 0,
    this.timestamp,
    this.order = 0,
    this.libraryId = 0,
    this.cloudCompanyId = 0,
    this.isSelected = false,
    this.isRequired = 0,
    this.listHazardControlDto,
    this.isSelectedHazards = 0,
    this.memoryImage,
    this.harm,
    this.additionalLiklihood,
    this.additionalScore = 0,
    this.additionalRating,
    this.cellPosition,
    this.cellRiskNumber = 0,
    this.assessmentHazardUniqueKey,
    this.isStandard = 0,
    this.imagePath,
    this.isUpdatedHazard = 0,
  });

  /* ************************************** */
  // UPDATE HAZARD FOR SCORE AND RATINGS

  /// updates the given hazard for score and ratings for provided
  /// assessment type
  /* ************************************** */
  String updateRating({int isStandard = 0, int score = 0}) {
    String rating = "";
    if (isStandard == 0) {
      if (score >= 1 && score <= 8) {
        rating = "Low";
      } else if (score >= 9 && score <= 15) {
        rating = "Medium";
      } else {
        rating = "High";
      }
    } else {
      if (score >= 1 && score <= 19) {
        rating = "Low";
      } else if (score >= 20 && score <= 49) {
        rating = "Medium";
      } else {
        rating = "High";
      }
    }
    return rating;
  }

  // Map<String, dynamic> jsonToUpload(int companyId) {
  //   var listControls = [];

  //   FetchLiklihoodDtoUsecase liklihoodUsecase =
  //       GetIt.I<FetchLiklihoodDtoUsecase>();
  //   var liklihoodDto = liklihoodUsecase.call(
  //       params: FetchLiklihoodParams(name: liklihood ?? ""));

  //   LiklihoodDto? additionalLiklihoodDto;
  //   if ((additionalLiklihood ?? "").isNotEmpty) {
  //     additionalLiklihoodDto = liklihoodUsecase.call(
  //         params: FetchLiklihoodParams(name: additionalLiklihood ?? ""));
  //   }

  //   FetchWorstcaseDtoUsecase worstcaseDtoUsecase =
  //       GetIt.I<FetchWorstcaseDtoUsecase>();
  //   var worstcaseDto = worstcaseDtoUsecase.call(
  //       params: FetchLiklihoodParams(name: worstcase ?? ""));

  //   for (var control in listHazardControlDto) {
  //     if ((control.name ?? "").isNotEmpty) {
  //       var d = control.jsonToUpload();
  //       listControls.add(d);
  //     }
  //   }

  //   var dict = {
  //     "rating": rating ?? "0",
  //     "unique_key": uniqueKey,
  //     "Actions": listControls,
  //     "risk_icon_id": imagePath,
  //     "timestamp": timestamp ?? "0",
  //     "company_id": companyId,
  //     // "original_hazard_id":
  //     //     ((cloudCompanyId ?? 0) == 0) ? 0 : (uniqueKey ?? "").parseInt(),

  //     "original_hazard_id":
  //         !isNumeric(uniqueKey) ? 0 : (uniqueKey ?? "").parseInt(),
  //     "likelihood_matrix": {
  //       "name": additionalLiklihood,
  //       "rating": isStandard == 1
  //           ? additionalLiklihoodDto?.score ?? ""
  //           : additionalLiklihoodDto?.scoreMatrix ?? ""
  //     },
  //     "Liklihood": {
  //       "name": liklihood,
  //       "rating": isStandard == 1
  //           ? liklihoodDto.score
  //           : liklihoodDto.scoreMatrix,
  //     },
  //     "hazard_library_id": !isNumeric(uniqueKey) ? 0 : (libraryId ?? 0),
  //     "Worstcase": {
  //       "name": worstcase,
  //       "rating": isStandard == 1
  //           ? worstcaseDto.score
  //           : worstcaseDto.scoreMatrix,
  //     },
  //     "cellNo": cellPosition ?? "",
  //     "riskName": name ?? "",
  //     "score": score ?? 0,
  //     "risk_order": order ?? 0,
  //     "risk_number": cellRiskNumber,
  //     "personAtRisk": WhoIsAtHarmDataSource.setRiskOfHarmOnUploading(
  //       personAtRisk: harm ?? "",
  //     ),
  //   };

  //   return dict;
  // }

  factory HazardDto.fromJson(Map<String, dynamic> json) {
    var listControls = (json['listHazardControlEntity'] as List)
        .map((control) => HazardControlDto.fromJson(control))
        .toList();

    return HazardDto(
      id: json['id'],
      name: json['name'],
      liklihood: json['liklihood'],
      worstcase: json['worstcase'],
      imagePath: json['imagePath'],
      rating: json['rating'],
      score: json['score'],
      uniqueKey: json['uniqueKey'],
      isFavourite: json['isFavourite'],
      isOld: json['isOld'],
      // companyId: json['companyId'],
      // timestamp: json['timestamp'],
      order: json['order'],
      libraryId: json['libraryId'],
      cloudCompanyId: json['cloudCompanyId'],
      isSelected: json['isSelected'],
      isRequired: json['isRequired'],
      isUpdatedHazard:
          json['isUpdatedHazard'] == null ? 0 : json['isUpdatedHazard'],
      additionalLiklihood: json['additionalLiklihood'],
      additionalScore: json['additionalScore'],
      additionalRating: json['additionalRating'],
      cellPosition: json['cellPosition'],
      cellRiskNumber: json['cellRiskNumber'],
      assessmentHazardUniqueKey: json['assessmentHazardUniqueKey'],
      isSelectedHazards: json['isSelectedHazards'],
      listHazardControlDto: listControls,
      isStandard: json['isStandard'],
      harm: json['harm'],
      hazardIconPath: json['image_path'],
    );
  }
}

bool isNumeric(String? str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}
