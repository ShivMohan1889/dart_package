class IncidentInjuredBodyPartEntity {
  String? injuredBodyName;
  int? isSelected = 0;

  IncidentInjuredBodyPartEntity({
    this.injuredBodyName,
    this.isSelected = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'injuredBodyName': injuredBodyName,
      'isSelected': isSelected,
    };
  }
}
