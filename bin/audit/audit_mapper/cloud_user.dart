class User {
  int? userSignatureId;
  String? userName;
  String? uniqueKey;
  String? position;
  String? userSignature;
  int? userId;

  User({
    this.userSignatureId,
    this.userName,
    this.uniqueKey,
    this.position,
    this.userSignature,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userSignatureId: json['userSignature_id'] as int?,
        userId: json['user_id'] as int?,
        userName: json['userName'] as String?,
        uniqueKey: json['unique_key'] as String?,
        position: json['position'] as String?,
        userSignature: json['userSignature'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'userSignature_id': userSignatureId,
        'user_id': userId,
        'userName': userName,
        'unique_key': uniqueKey,
        'position': position,
        'userSignature': userSignature,
      };
}
