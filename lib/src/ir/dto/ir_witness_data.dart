class IrWitnessData {
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
  IrWitnessData({
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
      other is IrWitnessData &&
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

  factory IrWitnessData.fromJson(Map<String, dynamic> json) {
    return IrWitnessData(
      id: json['id'] as int?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      email: json['email'] as String?,
      jobTitle: json['jobTitle'] as String?,
      name: json['name'] as String?,
      postcode: json['postcode'] as String?,
      telephone: json['telephone'] as String?,
      incidentUniqueKey: json['incidentUniqueKey'] as String?,
    );
  }

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
