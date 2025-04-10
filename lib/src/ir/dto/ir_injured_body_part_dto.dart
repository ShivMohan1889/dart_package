class IrInjuredBodyPartData {
  String? injuredBodyName;
  int? isSelected = 0;

  IrInjuredBodyPartData({
    this.injuredBodyName,
    this.isSelected = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'injuredBodyName': injuredBodyName,
      'isSelected': isSelected,
    };
  }

  factory IrInjuredBodyPartData.fromJson(Map<String, dynamic> json) {
    return IrInjuredBodyPartData(
      injuredBodyName: json['injuredBodyName'] as String?,
      isSelected: json['isSelected'] as int?,
    );
  }
}
