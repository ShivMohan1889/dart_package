import 'package:pdf/widgets.dart';

class ReferenceImageDto {
  ReferenceImageDto({
    int? id,
    String? imagePath,
    int? order,
    String? assessmentUniqueKey,
    String? uniqueKey,
    String? image,
    MemoryImage? memoryImage,
    String? referenceImagePath,
  }) : super() {
    this.imagePath = imagePath;
    this.order = order;
    this.assessmentUniqueKey = assessmentUniqueKey;
    this.uniqueKey = uniqueKey;
    this.image = image;
    this.memoryImage = memoryImage;
    this.referenceImagePath = referenceImagePath;
  }

  String? imagePath;
  int? order;
  String? assessmentUniqueKey;
  String? uniqueKey;
  String? image;
  MemoryImage? memoryImage;
  String? referenceImagePath;

  /// this feild is only used when we are uploading assessments
  String? uniqueKeyToUpload;

  factory ReferenceImageDto.fromJson(Map<String, dynamic> json) {
    return ReferenceImageDto(
      imagePath: json['imagePath'] as String?, // Can be null
      order: json['order'] as int?, // Can be null
      assessmentUniqueKey:
          json['assessmentUniqueKey'] as String?, // Can be null
      uniqueKey: json['uniqueKey'] as String?, // Can be null
      image:
          json['image'], // Depending on its type, it can be handled accordingly
      referenceImagePath: json["image_path"],
    );
  }
}
