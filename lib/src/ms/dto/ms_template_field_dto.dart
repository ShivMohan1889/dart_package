class MsTemplateFieldDto {
  int? id;
  String? keyName;
  String? dbKeyName;
  String? externalUrl;
  int? isDefault;
  int? templateCloudId;
  int? isDeleted;
  int? order;
  String? options;
  String? type;
  String? values;
  int? cloudCompanyId;
  int? cloudUserId;

  MsTemplateFieldDto({
    this.id,
    this.keyName,
    this.dbKeyName,
    this.externalUrl,
    this.isDefault,
    this.templateCloudId,
    this.isDeleted,
    this.order,
    this.options,
    this.type,
    this.cloudCompanyId,
    this.cloudUserId,
    this.values,
  });

  // Convert a JSON map to an instance of MsTemplateFieldDto
  factory MsTemplateFieldDto.fromJson(Map<String, dynamic> json) {
    return MsTemplateFieldDto(
      id: json['id'],
      keyName: json['keyName'],
      dbKeyName: json['dbKeyName'],
      externalUrl: json['externalUrl'],
      isDefault: json['isDefault'],
      templateCloudId: json['templateCloudId'],
      isDeleted: json['isDeleted'],
      order: json['order'],
      options: json['options'],
      type: json['type'],
      values: json['values'],
      cloudCompanyId: json['cloudCompanyId'],
      cloudUserId: json['cloudUserId'],
    );
  }
}
