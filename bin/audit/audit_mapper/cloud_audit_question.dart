import 'cloud_audit_question_image.dart';

class CloudAuditQuestion {
  int? id;
  String? question;
  int? parentId;
  String? answer;
  String? answerText;
  int? answerType;
  List<CloudAuditQuestionImage>? images;
  String? comment;

  CloudAuditQuestion({
    this.id,
    this.question,
    this.parentId,
    this.answer,
    this.answerText,
    this.answerType,
    this.images,
    this.comment,
  });

  factory CloudAuditQuestion.fromJson(Map<String, dynamic> json) =>
      CloudAuditQuestion(
        id: json['id'] as int?,
        question: json['question'] as String?,
        parentId: json['parent_id'] as int?,
        answer: json['answer'] as String?,
        answerText: json['answer_text'] as String?,
        answerType: json['answer_type'] as int?,
        // images: json['images'] as List<dynamic>?,
        images: List<CloudAuditQuestionImage>.from(
            json["images"].map((e) => CloudAuditQuestionImage.fromJson(e))),
        comment: json['comment'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'parent_id': parentId,
        'answer': answer,
        'answer_text': answerText,
        'answer_type': answerType,
        'images': images,
        'comment': comment,
      };
}
