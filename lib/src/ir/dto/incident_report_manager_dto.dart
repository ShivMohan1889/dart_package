class IncidentReportManagerDto  {
  int? id;
  String? email;
  String? managerCloudId;
  String? jobTitle;
  int? createdBy;
  int? companyId;
  int? isDeleted;
  int? userId;
  String? name;

  IncidentReportManagerDto({
    this.id,
    this.email,
    this.managerCloudId,
    this.jobTitle,
    this.createdBy,
    this.isDeleted,
    this.userId,
    this.name,
    this.companyId,
  });


  factory IncidentReportManagerDto.fromJson(Map<String, dynamic> json) {
    return IncidentReportManagerDto(
      id: json['id'] as int?,
      email: json['email'] as String?,
      managerCloudId: json['managerCloudId'] as String?,
      jobTitle: json['jobTitle'] as String?,
      createdBy: json['createdBy'] as int?,
      isDeleted: json['isDeleted'] as int?,
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      companyId: json['companyId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'managerCloudId': managerCloudId,
      'jobTitle': jobTitle,
      'createdBy': createdBy,
      'isDeleted': isDeleted,
    };

}
}
