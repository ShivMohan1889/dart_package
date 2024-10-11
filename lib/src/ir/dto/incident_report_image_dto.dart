class IncidentReportImageDto {
  int? id;
  int? accidentReportId;
  String? name;
  int? orderNo;
  String? incidentUniqueKey;

  IncidentReportImageDto
  ({
    this.id,
    this.accidentReportId,
    this.name,
    this.orderNo,
    this.incidentUniqueKey,
  });



  Map<String, dynamic> toJson() {


    return {
      'id': id,
      'accidentReportId': accidentReportId,
      'name': name,
      'orderNo': orderNo,
      'incidentUniqueKey': incidentUniqueKey,
    };
  }

  

  
}
