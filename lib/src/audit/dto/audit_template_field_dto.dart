class AuditTemplateFieldDto {
  int? id;
  String? name;
  int? cloudFieldId;
  int? templateCloudId;
  int? isDeleted;
  int? order;
  int? cloudCompanyId;
  int? cloudUserId;
  String? value;
  String? date;
  String? referenceName;
  int? isInput;

  AuditTemplateFieldDto({
    this.id,
    this.name,
    this.cloudFieldId,
    this.templateCloudId,
    this.isDeleted,
    this.order,
    this.cloudCompanyId,
    this.cloudUserId,
    this.value,
    this.date,
    this.referenceName,
    this.isInput,
  });

  // Factory constructor to create an instance from JSON
  factory AuditTemplateFieldDto.fromJson(Map<String, dynamic> json) {
    return AuditTemplateFieldDto(
      id: json['id'],
      name: json['name'],
      cloudFieldId: json['cloud_field_id'],
      templateCloudId: json['template_cloud_id'],
      isDeleted: json['is_deleted'],
      order: json['order'],
      cloudCompanyId: json['cloud_company_id'],
      cloudUserId: json['cloud_user_id'],
      value: json['value'],
      date: json['date'],
      referenceName: json['reference_name'],
      isInput: json['is_input'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cloud_field_id': cloudFieldId,
      'template_cloud_id': templateCloudId,
      'is_deleted': isDeleted,
      'order': order,
      'cloud_company_id': cloudCompanyId,
      'cloud_user_id': cloudUserId,
      'value': value,
      'date': date,
      'reference_name': referenceName,
      'is_input': isInput,
    };
  }
}
