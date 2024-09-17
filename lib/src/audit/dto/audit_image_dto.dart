import 'package:pdf/widgets.dart';
import '../../utils/extensions/index.dart';

class AuditImageDto {
  AuditImageDto({
    this.questionId,
    this.imageName,
    this.assessmentUniqueKey,
    this.uniqueKey,
    this.assessmentId,
    this.image,
    this.imageReferenceIndex,
    this.memoryImage,
    this.imagePath,
  });

  int? questionId;
  String? imageName;
  String? assessmentUniqueKey;
  String? uniqueKey;
  int? assessmentId;

  /// Property to hold path of the image provided by the
  /// image picker, written when user clicks done to save audit
  String? image;
  MemoryImage? memoryImage;
  int? imageReferenceIndex;

  String? imagePath;

  /// Field used only when uploading assessments
  String? uniqueKeyToUpload;

  // Factory constructor to create an instance from JSON
  factory AuditImageDto.fromJson(Map<String, dynamic> json) {
    return AuditImageDto(
      memoryImage: json['memory_image'],
      questionId: json['question_id'],
      imageName: json['image_name'],
      assessmentUniqueKey: json['assessment_unique_key'],
      uniqueKey: json['unique_key'],
      assessmentId: json['assessment_id'],
      image: json['image'],
      imageReferenceIndex: json['image_reference_index'],
      imagePath: json['image_path'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'image_name': imageName,
      'assessment_unique_key': assessmentUniqueKey,
      'unique_key': uniqueKey,
      'assessment_id': assessmentId,
      'image': image,
      'image_reference_index': imageReferenceIndex,
    };
  }

  // Method to prepare JSON for uploading assessments
  Map<String, dynamic> jsonToUpload() {
    String uniqueKey = imageName?.nameWithoutExtension ?? "";

    var dict = {
      "reference_no": "1",
      "key": uniqueKey,
      "unique_key": uniqueKey,
    };

    return dict;
  }
}
