import 'package:dart_pdf_package/src/ra/dto/hazard_dto.dart';

class HazardLibraryDto {
  String? libraryName;
  int? id;
  int? cloudCompanyId;
  int? isSelected;
  int? cloudLibraryId;
  int? companyId;
  List<HazardDto>? hazards;

  HazardLibraryDto({
    this.libraryName,
    this.id,
    this.cloudCompanyId,
    this.isSelected,
    this.companyId,
    this.hazards,
    this.cloudLibraryId,
  });

  factory HazardLibraryDto.fromJson(Map<String, dynamic> json) {
    return HazardLibraryDto(
      libraryName: json['libraryName'],
      id: json['id'],
      cloudCompanyId: json['cloudCompanyId'],
      isSelected: json['isSelected'] ?? false, // default to false if null
      cloudLibraryId: json['cloudLibraryId'],
      companyId: json['companyId'],
      hazards: (json['hazards'] as List<dynamic>?)
          ?.map((hazard) => HazardDto.fromJson(hazard))
          .toList(),
    );
  }
}
