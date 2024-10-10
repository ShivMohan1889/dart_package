class IncidentReportUserDto {
  int? id;
  String? userName;
  String? address1;
  String? address2;
  String? email;
  String? position;
  String? postcode;
  String? telephone;
  String? incidentUniqueKey;
  String? jobTitle;
  IncidentReportUserDto({
    this.id,
    this.address1,
    this.address2,
    this.email,
    this.position,
    this.postcode,
    this.telephone,
    this.incidentUniqueKey,
    this.userName,
    this.jobTitle,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'address1': address1,
      'address2': address2,
      'email': email,
      'position': position,
      'postcode': postcode,
      'telephone': telephone,
      'incidentUniqueKey': incidentUniqueKey,
      'jobTitle': jobTitle,
    };
  }
}
