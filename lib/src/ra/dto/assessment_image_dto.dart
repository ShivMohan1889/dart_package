import 'package:pdf/widgets.dart';

class AssessmentImageDto {
  AssessmentImageDto({
    int? id,
    String? imagePath,
    int? order,
    int? isSelected = 0,
    String? assessmentUniqueKey,
    String? uniqueKey,
    String? image,
    MemoryImage? memoryImage,
    String? assessmentImagePath
  }) : super() {
    this.imagePath = imagePath;
    this.order = order;
    this.isSelected = isSelected;
    this.assessmentUniqueKey = assessmentUniqueKey;
    this.uniqueKey = uniqueKey;
    this.image = image;
    this.memoryImage = memoryImage;
    this.assessmentImagePath  =assessmentImagePath;
    
  }

  //
  String? imagePath;
  int? order;
  int? isSelected = 0;
  String? assessmentUniqueKey;
  String? uniqueKey;
  String? image;
  MemoryImage? memoryImage;

  /// this feild is only used when we are uploading assessments
  String? uniqueKeyToUpload;

  String? assessmentImagePath;



factory AssessmentImageDto.fromJson(Map<String, dynamic> json) {
  return AssessmentImageDto(
    imagePath: json['imagePath'] as String?, // Can be null
    order: json['order'] as int?, // Can be null
    assessmentUniqueKey: json['assessmentUniqueKey'] as String?, // Can be null
    uniqueKey: json['uniqueKey'] as String?, // Can be null
    image: json['image'] as String?, // Can be null
    assessmentImagePath : json['image_path'] as String?,
    // memoryImage is not handled here because it's not included in the provided `toJson` method
  );
}
   
}
