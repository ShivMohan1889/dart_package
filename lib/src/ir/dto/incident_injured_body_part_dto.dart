class IncidentInjuredBodyPartDto {
  String? injuredBodyName;
  int? isSelected = 0;

  IncidentInjuredBodyPartDto({
    this.injuredBodyName,
    this.isSelected = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'injuredBodyName': injuredBodyName,
      'isSelected': isSelected,
    };
  }

  factory IncidentInjuredBodyPartDto.fromJson(Map<String, dynamic> json) {
    return IncidentInjuredBodyPartDto(
      injuredBodyName: json['injuredBodyName'] as String?,
      isSelected: json['isSelected'] as int?,
    );
  }
}
