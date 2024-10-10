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
