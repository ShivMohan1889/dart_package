class AuditAnswerFieldDto {
  int? id;
  int? fieldId;
  String? value;
  String? name;
  int? inputType;
  String? uniqueKey;

  AuditAnswerFieldDto({
    this.id,
    this.fieldId,
    this.value,
    this.name,
    this.uniqueKey,
    this.inputType,
  });

  factory AuditAnswerFieldDto.fromJson(Map<String, dynamic> json) {
    return AuditAnswerFieldDto(
      id: json['id'],
      fieldId: json['fieldId'],
      value: json['value'],
      name: json['name'],
      uniqueKey: json['uniqueKey'],
      inputType: json['inputType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fieldId': fieldId,
      'value': value,
      'name': name,
      'uniqueKey': uniqueKey,
      'inputType': inputType,
    };
  }

  Map<String, dynamic> jsonToUpload() {
    return {
      'value': value,
      'name': name,
    };
  }
}
