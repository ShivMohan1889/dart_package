class LiklihoodDto {
  final int? id;
  final int? score;
  final int? scoreMatrix;
  final String? name;

  LiklihoodDto({this.id, this.score, this.scoreMatrix, this.name});

  factory LiklihoodDto.fromJson(Map<String, dynamic> json) {
    return LiklihoodDto(
      id: json['id'] as int?, // Can be null, handled accordingly
      score: json['score'] as int?, // Can be null
      scoreMatrix: json['scoreMatrix'] as int?, // Can be null
      name: json['name'] as String?, // Can be null
    );
  }
}
