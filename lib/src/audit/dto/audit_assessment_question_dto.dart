import 'audit_image_dto.dart'; // Assuming you renamed AuditImageEntity to AuditImageDto

class AuditAssessmentQuestionDto {
  int? id;
  int? cloudQuestionId;
  int? sectionCloudId;
  String? answer;
  String? comment;
  int? assessmentId;
  int? answerType;
  String? chainStatus;
  String? assessmentUniqueKey;
  int? questionNo;
  String? question;
  int? parentId;

  List<AuditImageDto> listAuditImageDto = List.empty(growable: true);

  AuditAssessmentQuestionDto({
    this.id,
    this.cloudQuestionId,
    this.sectionCloudId,
    this.answer,
    this.comment,
    this.assessmentId,
    this.answerType,
    this.chainStatus,
    this.assessmentUniqueKey,
    this.questionNo,
    this.question,
    this.parentId,
    required this.listAuditImageDto,
  });

  // Factory constructor to create an instance from JSON
  factory AuditAssessmentQuestionDto.fromJson(Map<String, dynamic> json) {
    return AuditAssessmentQuestionDto(
      id: json['id'],
      cloudQuestionId: json['cloud_question_id'],
      sectionCloudId: json['section_cloud_id'],
      answer: json['answer'],
      comment: json['comment'],
      assessmentId: json['assessment_id'],
      answerType: json['answer_type'],
      chainStatus: json['chain_status'],
      assessmentUniqueKey: json['assessment_unique_key'],
      questionNo: json['question_no'],
      question: json['question'],
      parentId: json['parent_id'],
      listAuditImageDto: json['images'] != null
          ? List<AuditImageDto>.from(json['images'].map((x) => AuditImageDto.fromJson(x)))
          : [],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cloud_question_id': cloudQuestionId,
      'section_cloud_id': sectionCloudId,
      'answer': answer,
      'comment': comment,
      'assessment_id': assessmentId,
      'answer_type': answerType,
      'chain_status': chainStatus,
      'assessment_unique_key': assessmentUniqueKey,
      'question_no': questionNo,
      'question': question,
      'parent_id': parentId,
      'images': listAuditImageDto.map((x) => x.toJson()).toList(),
   
   
    };
  }

  // Custom method to prepare JSON for upload
  Map<String, dynamic> jsonToUpload() {
    var listReferenceImages = [];
    for (var element in listAuditImageDto) {
      var index = listAuditImageDto.indexOf(element);
      var dict = element.jsonToUpload();
      dict['reference_no'] = (index + 1).toString();
      listReferenceImages.add(dict);
    }

    var dict = {
      'id': cloudQuestionId,
      'checklist_section_id': sectionCloudId,
      'comment': comment,
      'images': listReferenceImages,
      'question': question,
      'parent_id': parentId,
    };

    return dict;
  }
}
