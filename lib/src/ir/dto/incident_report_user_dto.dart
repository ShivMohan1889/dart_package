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


  factory IncidentReportUserDto.fromJson(Map<String, dynamic> json) {
    return IncidentReportUserDto(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      email: json['email'] as String?,
      position: json['position'] as String?,
      postcode: json['postcode'] as String?,
      telephone: json['telephone'] as String?,
      incidentUniqueKey: json['incidentUniqueKey'] as String?,
      jobTitle: json['jobTitle'] as String?,
    );
  }
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
