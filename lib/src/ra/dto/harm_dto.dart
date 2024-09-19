import 'dart:convert';

import 'package:dart_pdf_package/src/ra/dto/hazard_dto.dart';

class HarmDto {
  String? name;
  int? isSelected = 0;
  String? keyName;

  HarmDto({
    this.name,
    this.keyName,
    this.isSelected = 0,
  });

  factory HarmDto.fromJson(Map<String, dynamic> json) {
    return HarmDto(
      name: json["name"] as String?,
      isSelected: json["isSelected"],
      keyName: json["key_name"] as String,
    );
  }
}
