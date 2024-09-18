import 'package:dart_pdf_package/src/utils/extensions/string_extension.dart';
import 'package:pdf/widgets.dart';

class ReviewSignOffUserDto {
  ReviewSignOffUserDto({
    int? id,
    String? firstName,
    String? lastName,
    String? signature,
    String? assessmentUniqueKey,
    String? createdOn,
    int? userType,
    int? order,
    MemoryImage? memoryImage,
    String? imagePath,
  }) : super() {
    this.firstName = firstName;
    this.id = id;
    this.lastName = lastName;
    this.assessmentUniqueKey = assessmentUniqueKey;
    this.signature = signature;
    this.createdOn = createdOn;
    this.userType = userType;
    this.memoryImage = memoryImage;
    this.order = order;
    this.imagePath  = imagePath;
    

  }

  String? firstName;
  String? lastName;
  String? signature;
  String? assessmentUniqueKey;
  String? createdOn;
  int? id;
  int? userType;
  int? order;
  MemoryImage? memoryImage;
  String? imagePath;

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "creationDate": createdOn,
      "user_type": userType,
      "signature_key": signature,
      "image_key": signature?.nameWithoutExtension,
      "lastName": lastName,
      "order": order
    };
  }

  factory ReviewSignOffUserDto.fromJson(Map<String, dynamic> json) {
    return ReviewSignOffUserDto(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      signature: json['signature_key'] as String?,
      assessmentUniqueKey: json['assessmentUniqueKey'] as String?,
      createdOn: json['creationDate'] as String?,
      userType: json['user_type'] as int?,
      order: json['order'] as int?,
      imagePath: json["image_path"] as String?,

      // MemoryImage cannot be directly created from JSON,
      // it typically comes from a file or image asset, so it's not included here.
    );
  }
}
