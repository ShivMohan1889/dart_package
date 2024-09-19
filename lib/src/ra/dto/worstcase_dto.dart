class WorstcaseDto {
  final int? id;
  final int? score;
  final int? scoreMatrix;
  final String? name;

  WorstcaseDto({
    this.id,
    this.score,
    this.scoreMatrix,
    this.name,
  });

  factory WorstcaseDto.fromJson(Map<String, dynamic> json) {
    return WorstcaseDto(
      id: json['id'] as int?,
      score: json['score'] as int?,
      scoreMatrix: json['score_matrix'] as int?,
      name: json['name'] as String?,
    );
  }
}
