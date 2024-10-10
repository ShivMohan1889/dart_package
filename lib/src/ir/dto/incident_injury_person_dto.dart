class IncidentInjuryPersonDto {
  int? id;
  String? address1;
  String? address2;
  String? address3;
  String? email;
  String? name;
  String? position;
  String? postcode;
  String? telephone;
  String? incidentUniqueKey;
  String? jobTitle;

  IncidentInjuryPersonDto({
    
    this.jobTitle,
    this.id,
    this.address1,
    this.address2,
    this.address3,
    this.email,
    this.name,
    this.incidentUniqueKey,
    this.position,
    this.postcode,
    this.telephone,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'email': email,
      'name': name,
      'position': position,
      'postcode': postcode,
      'telephone': telephone,
      'incidentUniqueKey': incidentUniqueKey,
      'jobTitle': jobTitle,
    };
  }
}
