class WorstCaseDto {
  final int? id;
  final int? score;
  final int? scoreMatrix;
  final String? name;

  WorstCaseDto({
    this.id,
    this.score,
    this.scoreMatrix,
    this.name,
  });

  factory WorstCaseDto.fromJson(Map<String, dynamic> json) {
    return WorstCaseDto(
      id: json['id'] as int?,
      score: json['score'] as int?,
      scoreMatrix: json['score_matrix'] as int?,
      name: json['name'] as String?,
    );
  }
}
