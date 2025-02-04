class TimeLogsDto {
  int? assessmentTime;
  int startTime = 0;
  int id = 0;

  String? uniqueKey;
  String? created;

  TimeLogsDto({
    this.assessmentTime,
    this.uniqueKey,
    this.created,
    this.startTime = 0,
    this.id = 0,
  });

  Map<String, dynamic> jsonToUpload() {
    return {
      "unique_key": uniqueKey,
      "assessment_time": assessmentTime,
      "created": created,
    };
  }

  factory TimeLogsDto.fromJson(Map<String, dynamic> json) {
    return TimeLogsDto(
      assessmentTime: json['assessmentTime'] as int?, // Can be null
      // startTime: json['startTime'], // Can be null
      id: json['id'], // Can be null
      uniqueKey: json['uniqueKey'] as String?, // Can be null
      created: json['created'] as String?, // Can be null
    );
  }
}
