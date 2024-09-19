/// Creates models for hazards so while creating rows
/// of the hazard table in the pdf we don't need to go through
/// actual hazard entity

class TbHazardRowModel {
  String? name;
  String? gridRef;
  String? controlInPlace;
  String? worstCase;
  String? likelihood;
  String? score;
  String? rating;
  String? additionalControl;
  String? additionalLikelihood;
  String? additionalScore;
  String? additionalRating;
  
  /// this is used to show the color when hazard  table is get split
  String? splitItemScore;
  /// this is used to show the color on addition score section when hazard table is get split
  
  String? splitItemAdditionalScore;




  /// will hold height of the model when it will be placed on the pdf
  double height = 0;

  /// this propety is used to if the hazard was splitted
  /// if yes we need to deduct its height from the page height, when page is changed.
  int isSplitHazard = 0;

  TbHazardRowModel({
    this.name,
    this.gridRef,
    this.controlInPlace,
    this.worstCase,
    this.likelihood,
    this.score,
    this.rating,
    this.additionalControl,
    this.additionalLikelihood,
    this.additionalScore,
    this.additionalRating,
    this.splitItemScore,
    this.splitItemAdditionalScore,

  });
}
