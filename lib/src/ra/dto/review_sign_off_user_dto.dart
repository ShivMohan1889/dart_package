import 'package:dart_pdf_package/src/ms/dto/review_sign_off_dto.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/review_sign_off_mode.dart';
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
    this.imagePath = imagePath;
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

  factory ReviewSignOffUserDto.fromJson(Map<String, dynamic> json) {
    return ReviewSignOffUserDto(
      firstName: json['firstName'],
      id: json['id'],
      lastName: json['lastName'],
      assessmentUniqueKey: json['assessmentUniqueKey'],
      signature: json['signature'],
      createdOn: json['creationDate'],
      userType: json['user_type'],
      order: json['order'],
      memoryImage: json['memoryImage'],
      imagePath: json['image_path'],
    );
  }
}
