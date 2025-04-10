import 'package:pdf/widgets.dart';

class IrInjuryPhoto {
  IrInjuryPhoto({
    int? id,
    String? name,
    int? order,
    String? incidentUniqueKey,
    String? uniqueKey,
    String? imagePath,
    MemoryImage? memoryImage,
    String? irImagePath,

  }) : super() {
    this.id = id;
    this.name = name;
    this.order = order;
    this.incidentUniqueKey = incidentUniqueKey;
    this.uniqueKey = uniqueKey;
    this.imagePath = imagePath;
    this.memoryImage = memoryImage;
    this.irImagePath = irImagePath;
  }

  int? id;
  String? name;
  int? order;
  String? incidentUniqueKey;
  String? uniqueKey;

  String? imagePath;
  MemoryImage? memoryImage;   
  String ? irImagePath;


   




  factory IrInjuryPhoto.fromJson(Map<String, dynamic> json) {
    return IrInjuryPhoto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      order: json['order'] as int?,
      incidentUniqueKey: json['incidentUniqueKey'] as String?,
      uniqueKey: json['uniqueKey'] as String?,
      imagePath: json['imagePath'] as String?,
      irImagePath: json['image_path'] as String?,
    );
  }

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
