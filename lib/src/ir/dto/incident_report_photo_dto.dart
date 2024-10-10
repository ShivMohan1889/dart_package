import 'package:pdf/widgets.dart';

class IncidentInjuryPhotoDto {
  IncidentInjuryPhotoDto({
    int? id,
    String? name,
    int? order,
    String? incidentUniqueKey,
    String? uniqueKey,
    String? imagePath,
    MemoryImage? memoryImage,
  }) : super() {
    this.id = id;
    this.name = name;
    this.order = order;
    this.incidentUniqueKey = incidentUniqueKey;
    this.uniqueKey = uniqueKey;
    this.imagePath = imagePath;
    this.memoryImage = memoryImage;
  }

  int? id;
  String? name;
  int? order;
  String? incidentUniqueKey;
  String? uniqueKey;

  String? imagePath;
  MemoryImage? memoryImage;   

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'incidentUniqueKey': incidentUniqueKey,
      'uniqueKey': uniqueKey,
      'imagePath': imagePath,
    };
  }
}
