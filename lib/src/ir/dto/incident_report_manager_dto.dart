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
