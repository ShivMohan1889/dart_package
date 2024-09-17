import 'package:dart_pdf_package/src/audit/dto/audit_assessment_dto.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';

import '../audit_pdf_constants.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

// this widget is use to  show  header name of audit template

class AuditTitleRow extends StatelessWidget {
  final AuditAssessmentDto? auditAssessmentEntity;

  AuditTitleRow({this.auditAssessmentEntity});

  final msPdfTextStyles = AuditPdfTextStyles();

  @override
  Widget build(Context context) {
    return Container(
      width: double.infinity,
      // height: 30,
      height: 29,
      color: AuditPdfColors.auditBlueLightColor,

      // padding: AuditPdfPaddings.auditTitleRowPadding,\
      padding: AuditPdfPaddings.pageLeftPadding,
      alignment: Alignment.centerLeft,
      child: Text(
        auditAssessmentEntity?.auditTemplateDto?.templateHeader.toString() ??
            "",
        style: TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.fontBoldItalic,
          color: PdfColors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
