class ChainOptionDto {
  int? id;
  String? name;
  int? cloudQuestionId;
  int? sectionCloudId;
  int? cloudUserId;
  int? templateCloudId;
  int? cloudCompanyId;
  int? isDeleted;

  ChainOptionDto({
    this.id,
    this.name,
    this.cloudQuestionId,
    this.sectionCloudId,
    this.cloudUserId,
    this.templateCloudId,
    this.cloudCompanyId,
    this.isDeleted,
  });

  // Factory constructor to create an instance from JSON
  factory ChainOptionDto.fromJson(Map<String, dynamic> json) {
    return ChainOptionDto(
      id: json['id'],
      name: json['name'],
      cloudQuestionId: json['cloud_question_id'],
      sectionCloudId: json['section_cloud_id'],
      cloudUserId: json['cloud_user_id'],
      templateCloudId: json['template_cloud_id'],
      cloudCompanyId: json['cloud_company_id'],
      isDeleted: json['is_deleted'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cloud_question_id': cloudQuestionId,
      'section_cloud_id': sectionCloudId,
      'cloud_user_id': cloudUserId,
      'template_cloud_id': templateCloudId,
      'cloud_company_id': cloudCompanyId,
      'is_deleted': isDeleted,
    };
  }
}
