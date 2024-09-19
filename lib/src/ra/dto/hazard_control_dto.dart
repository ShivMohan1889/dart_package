

import 'package:dart_pdf_package/src/utils/utils.dart';

class HazardControlDto {
  String? name;
  String? hazardUniqueKey;
  int? id = 0;
  int? order = 0;
  int? cloudCompanyId = 0;

  /// Determines if a control is selected or not.
  /// Used form the Check Your Control Screen.
  /// [This filed will be saved with clone controls]
  int isSelected;

  /// Determines if a additional control is required
  /// [This filed will be saved with clone controls]
  int isRequired;

  /// Property that will be used only for check hazard list screen,
  /// using this property we will not have to manage to arrays,
  /// one for these controllers and other one for HazardControls

  HazardControlDto({
    this.name,
    this.hazardUniqueKey,
    this.id,
    this.order = 0,
    this.cloudCompanyId = 0,
    this.isSelected = 0,
    this.isRequired = 0,
  });


  factory HazardControlDto.fromJson(Map<String, dynamic> json) {
  return HazardControlDto(
    name: json['name'],
    hazardUniqueKey: json['hazardUniqueKey'],
    id: json['id'],
    order: json['order'],
    cloudCompanyId: json['cloudCompanyId'],
    isSelected: json['isSelected'] ?? false, // default to false if null
    isRequired: json['isRequired'] ?? 0, // default to 0 if null
  );
}


}
