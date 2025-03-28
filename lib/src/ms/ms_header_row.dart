import 'package:dart_pdf_package/dart_pdf_package.dart';

class MsHeaderRows {
  String name;
  int level;
  List<HeaderStatementData>? statements;
  List<HazardIconData>? hazardIcons;
  List<HeaderReferenceImageData>? images;
  List<HeaderRows>? headerRows;
  String? subHeaderName;
  String? statementName;
  



  MsHeaderRows({
    required this.name,
    required this.level,
    this.statements,
    this.hazardIcons,
    required this.images,
    this.headerRows,
    this.statementName,
    this.subHeaderName,

  });
}
