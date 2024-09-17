import 'question_dto.dart';
import 'section_image_dto.dart';

class SectionDto {
  String? name;
  int? order;
  String? description;
  int? id;
  int? isDelete;
  List<QuestionDto>? questionsDto;
  List<SectionImageDto>? image;
  int? templateCloudId;
  int? cloudUserId;
  int? sectionCloudId;
  int? cloudCompanyId;
  int isSelected = 0;

  SectionDto({
    this.name,
    this.order,
    this.description,
    this.id,
    this.isDelete,
    this.questionsDto,
    this.templateCloudId,
    this.cloudUserId,
    this.sectionCloudId,
    this.cloudCompanyId,
    this.image,
    this.isSelected = 0,
  });

  factory SectionDto.fromJson(Map<String, dynamic> json) {
    return SectionDto(
      name: json['name'],
      order: json['order'],
      description: json['description'],
      id: json['id'],
      isDelete: json['is_delete'],
      questionsDto: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => SectionImageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      templateCloudId: json['template_cloud_id'],
      cloudUserId: json['cloud_user_id'],
      sectionCloudId: json['section_cloud_id'],
      cloudCompanyId: json['cloud_company_id'],
      isSelected: json['is_selected'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'order': order,
      'description': description,
      'id': id,
      'is_delete': isDelete,
      'questions': questionsDto?.map((e) => e.toJson()).toList(),
      'image': image?.map((e) => e.toJson()).toList(),
      'template_cloud_id': templateCloudId,
      'cloud_user_id': cloudUserId,
      'section_cloud_id': sectionCloudId,
      'cloud_company_id': cloudCompanyId,
      'is_selected': isSelected,
    };
  }
}
