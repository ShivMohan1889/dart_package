import 'audit_image_dto.dart';
import 'chain_option_dto.dart';
import 'section_dto.dart';

class QuestionDto {
  int? id;
  String? question;
  int? isDelete;
  int? parentId;
  int? questionType;
  int? answerType;
  List<ChainOptionDto>? chainOption;
  List<QuestionDto>? subQuestions;
  String? chainStatus;
  int? cloudQuestionId;
  int? sectionCloudId;
  String? values;
  int? cloudCompanyId;
  int? cloudUserId;
  int? templateCloudId;
  String? comment;
  SectionDto? sectionEntity;

  List<ChainOptionDto>? chainOptionsForPdf;
  String? chainOptionsString;
  List<AuditImageDto> listAuditImageDto = List.empty(growable: true);
  String? questionNumber;
  int? questionNumberForPdf;
  int? isQuestionSelected = 0;
  QuestionDto? parent;

  QuestionDto({
    this.id,
    this.question,
    this.isDelete,
    this.parentId,
    this.questionType,
    this.answerType,
    this.chainOption,
    this.subQuestions,
    this.chainStatus,
    this.cloudQuestionId,
    this.sectionCloudId,
    this.values,
    this.cloudCompanyId,
    this.cloudUserId,
    this.templateCloudId,
    this.parent,
    required this.listAuditImageDto,
    this.comment,
    this.questionNumber,
    this.isQuestionSelected = 0,
    this.sectionEntity,
    this.questionNumberForPdf,
    this.chainOptionsForPdf,
    this.chainOptionsString,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) {
    var questionDto = QuestionDto(
      id: json['id'],
      question: json['question'],
      isDelete: json['is_delete'],
      parentId: json['parent_id'],
      questionType: json['question_type'],
      answerType: json['answer_type'],
      chainOption: (json['chain_option'] as List<dynamic>?)
          ?.map((e) => ChainOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),

      // subQuestions: (json['sub_questions'] as List<dynamic>?)
      //     ?.map((e) => QuestionDto.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      chainStatus: json['chain_status'],
      cloudQuestionId: json['cloud_question_id'],
      sectionCloudId: json['section_cloud_id'],
      values: json['values'],
      cloudCompanyId: json['cloud_company_id'],
      cloudUserId: json['cloud_user_id'],
      templateCloudId: json['template_cloud_id'],
      comment: json['comment'],

      // sectionEntity: json['section_entity'] != null
      //     ? SectionDto.fromJson(json['section_entity'])
      //     : null,
      chainOptionsForPdf: (json['chain_options_for_pdf'] as List<dynamic>?)
          ?.map((e) => ChainOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),

      chainOptionsString: json['chain_options_string'],
      listAuditImageDto: (json['list_audit_image_entity'] as List<dynamic>)
          .map((e) => AuditImageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionNumber: json['question_number'],
      questionNumberForPdf: json['question_number_for_pdf'],
      isQuestionSelected: json['is_question_selected'],
      parent:
          json['parent'] != null ? QuestionDto.fromJson(json['parent']) : null,
    );

    questionDto.subQuestions =
        (json['sub_questions'] as List<dynamic>?)?.map((e) {
      var subQuestion = QuestionDto.fromJson(e as Map<String, dynamic>);
      subQuestion.parent = questionDto; // Set the parent here
      return subQuestion;
    }).toList();

    return questionDto;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'is_delete': isDelete,
      'parent_id': parentId,
      'question_type': questionType,
      'answer_type': answerType,
      'chain_option': chainOption?.map((e) => e.toJson()).toList(),
      'sub_questions': subQuestions?.map((e) => e.toJson()).toList(),
      'chain_status': chainStatus,
      'cloud_question_id': cloudQuestionId,
      'section_cloud_id': sectionCloudId,
      'values': values,
      'cloud_company_id': cloudCompanyId,
      'cloud_user_id': cloudUserId,
      'template_cloud_id': templateCloudId,
      'comment': comment,
      'section_entity': sectionEntity?.toJson(),
      'chain_options_for_pdf':
          chainOptionsForPdf?.map((e) => e.toJson()).toList(),
      'chain_options_string': chainOptionsString,
      'list_audit_image_entity':
          listAuditImageDto.map((e) => e.toJson()).toList(),
      'question_number': questionNumber,
      'question_number_for_pdf': questionNumberForPdf,
      'is_question_selected': isQuestionSelected,
      'parent': parent?.toJson(),
    };
  }
}
