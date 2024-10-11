class IncidentReportInjuryOptionDto {
  int? id;
  String? name;
  int? order;
  String? incidentUniqueKey;
  int? type;
  IncidentReportInjuryOptionDto({
    this.id,
    this.order,
    this.incidentUniqueKey,
    this.name,
    this.type,
  });


  factory IncidentReportInjuryOptionDto.fromJson(Map<String, dynamic> json) {
    return IncidentReportInjuryOptionDto(
      id: json['id'] as int?,
      order: json['order'] as int?,
      incidentUniqueKey: json['incidentUniqueKey'] as String?,
      name: json['name'] as String?,
      type: json['type'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'incidentUniqueKey': incidentUniqueKey,
      'name': name,
      'type': type,
    };
  }

}
