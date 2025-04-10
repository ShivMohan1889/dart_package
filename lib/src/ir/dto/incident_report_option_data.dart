class IrOptionData {
  int? id;
  int? type;
  String? name;
  String? incidentUniqueKey;
  // this property for option selection
  int? isSelected = 0;

  IrOptionData({
    this.id,
    this.type,
    this.name,
    this.incidentUniqueKey,
    this.isSelected = 0,
  });


  factory IrOptionData.fromJson(Map<String, dynamic> json) {
    return IrOptionData(
      id: json['id'] as int?,
      type: json['type'] as int?,
      name: json['name'] as String?,
      incidentUniqueKey: json['incidentUniqueKey'] as String?,
      isSelected: json['isSelected'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'incidentUniqueKey': incidentUniqueKey,
      'isSelected': isSelected,
    };
  }
}
