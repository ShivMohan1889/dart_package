class IncidentReportWitnessDto {
  int? id;
  String? address1;
  String? address2;
  String? address3;
  String? email;
  String? jobTitle;
  String? name;
  String? postcode;
  String? telephone;
  String? incidentUniqueKey;
  IncidentReportWitnessDto({
    this.id,
    this.address1,
    this.address2,
    this.email,
    this.incidentUniqueKey,
    this.jobTitle,
    this.name,
    this.postcode,
    this.telephone,
    this.address3,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncidentReportWitnessDto &&
          runtimeType == other.runtimeType &&
          address1 == other.address1 &&
          name == other.name &&
          jobTitle == other.jobTitle &&
          address2 == other.address2 &&
          address3 == other.address3 &&
          telephone == other.telephone &&
          incidentUniqueKey == other.incidentUniqueKey &&
          postcode == other.postcode &&
          email == other.email;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'email': email,
      'jobTitle': jobTitle,
      'name': name,
      'postcode': postcode,
      'telephone': telephone,
      'incidentUniqueKey': incidentUniqueKey,
    };
  }
}
