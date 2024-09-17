import 'package:pdf/widgets.dart';

class SectionImageDto {
  String? imagePath;
  String? imageUrl;
  String? id;
  int? isDelete;
  int? order;
  int? sectionCloudId;
  String? uniqueKey;
  int? cloudUserId;
  int? templateCloudId;
  int? cloudCompanyId;
  MemoryImage? memoryImage;

  SectionImageDto({
    this.imagePath,
    this.id,
    this.isDelete,
    this.order,
    this.sectionCloudId,
    this.uniqueKey,
    this.cloudUserId,
    this.templateCloudId,
    this.cloudCompanyId,
    this.imageUrl,
    this.memoryImage,
  });

  factory SectionImageDto.fromJson(Map<String, dynamic> json) {
    return SectionImageDto(
      imagePath: json['image_path'],
      imageUrl: json['image_url'],
      id: json['id'],
      isDelete: json['is_delete'],
      order: json['order'],
      sectionCloudId: json['section_cloud_id'],
      uniqueKey: json['unique_key'],
      cloudUserId: json['cloud_user_id'],
      templateCloudId: json['template_cloud_id'],
      cloudCompanyId: json['cloud_company_id'],
      memoryImage: json["memory_image"],

      // MemoryImage cannot be created directly from JSON, so it's excluded
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_path': imagePath,
      'image_url': imageUrl,
      'id': id,
      'is_delete': isDelete,
      'order': order,
      'section_cloud_id': sectionCloudId,
      'unique_key': uniqueKey,
      'cloud_user_id': cloudUserId,
      'template_cloud_id': templateCloudId,
      'cloud_company_id': cloudCompanyId,
      // MemoryImage cannot be serialized directly to JSON, so it's excluded
    };
  }
}
