import 'package:pdf/widgets.dart';

import '../../utils/extensions/string_extension.dart';

class UserDto {
  String? userName;
  String? uniqueKey;
  String? position;
  String? signature;
  MemoryImage? signatureMemoryImage;
  int? isCloud;
  int? isSelected;
  int? cloudUserId;
  int? cloudCompanyId;
  int? id;
  int? isTermApp;
  int? subscriptionType;
  String? email;

  String? imagePath;

  UserDto({
    this.userName,
    this.uniqueKey,
    this.position,
    this.signature,
    this.signatureMemoryImage,
    this.isCloud,
    this.isSelected = 0,
    this.cloudUserId,
    this.cloudCompanyId,
    this.id,
    this.isTermApp,
    this.email,
    this.subscriptionType,
    this.imagePath,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      userName: json['userName'],
      uniqueKey: json['unique_key'],
      position: json['position'],
      signature: json['signature'],
      // Note: signatureMemoryImage cannot be created from JSON
      isCloud: json['isCloud'],
      isSelected: json['isSelected'],
      cloudUserId: json['cloudUserId'],
      cloudCompanyId: json['cloudCompanyId'],
      id: json['id'],
      isTermApp: json['isTermApp'],
      email: json['email'],
      subscriptionType: json['subscriptionType'],
      signatureMemoryImage: json["memory_image"],
      imagePath: json["image_path"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'unique_key': uniqueKey,
      'position': position,
      'signature': signature,
      "memory_image": signatureMemoryImage,
      'isCloud': isCloud,
      'isSelected': isSelected,
      'cloudUserId': cloudUserId,
      'cloudCompanyId': cloudCompanyId,
      'id': id,
      'isTermApp': isTermApp,
      'email': email,
      'subscriptionType': subscriptionType,
    };
  }

  Map<String, dynamic> jsonToUpload() {
    String? filePath;
    // if ((signature ?? '').isNotEmpty) {
    //   filePath = FileManager.userSignaturePath(uniqueKey: uniqueKey ?? "");
    // }

    return {
      "unique_key": uniqueKey,
      "userName": userName,
      "position": position,
      "key": uniqueKey,
      "file_path": filePath ?? '',
      "name": filePath == null ? "" : filePath.fileName
    };
  }
}
