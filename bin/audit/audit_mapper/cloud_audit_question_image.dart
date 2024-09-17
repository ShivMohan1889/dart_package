class CloudAuditQuestionImage {
  String? image;
  int? referenceNo;
  int? checklistQuestionId;

  CloudAuditQuestionImage(
      {this.image, this.referenceNo, this.checklistQuestionId});

  CloudAuditQuestionImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    referenceNo = json['reference_no'];
    checklistQuestionId = json['checklist_question_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['reference_no'] = this.referenceNo;
    data['checklist_question_id'] = this.checklistQuestionId;
    return data;
  }
}
