import 'package:pdf/widgets.dart';

class AuditAssetsPdfImageDto {
  MemoryImage? checkImage;
  MemoryImage? uncheckImage;
  MemoryImage? raWaterMarkImage;
  MemoryImage? msWaterMarkImage;
  MemoryImage? auditCheckImage;
  MemoryImage? auditUncheckImage;

  AuditAssetsPdfImageDto({
    this.auditCheckImage,
    this.checkImage,
    this.auditUncheckImage,
    this.msWaterMarkImage,
    this.raWaterMarkImage,
    this.uncheckImage,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'checkImage': checkImage, // Add the path or necessary info if needed
      'uncheckImage': uncheckImage,
      'raWaterMarkImage': raWaterMarkImage,
      'msWaterMarkImage': msWaterMarkImage,
      'auditCheckImage': auditCheckImage,
      'auditUncheckImage': auditUncheckImage,
    };
  }

  // Create object from JSON
  factory AuditAssetsPdfImageDto.fromJson(Map<String, dynamic> json) {
    return AuditAssetsPdfImageDto(
      checkImage: json['checkImage'], // Load from path or bytes if required
      uncheckImage: json['uncheckImage'],
      raWaterMarkImage: json['raWaterMarkImage'],
      msWaterMarkImage: json['msWaterMarkImage'],
      auditCheckImage: json['auditCheckImage'],
      auditUncheckImage: json['auditUncheckImage'],
    );
  }
}
