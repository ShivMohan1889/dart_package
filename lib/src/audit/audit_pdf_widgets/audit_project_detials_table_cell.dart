import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';

import '../audit_pdf_constants.dart';
import 'package:pdf/widgets.dart';

import 'audit_pdf_custom_text.dart';

class AuditProjectDetailsTableCell extends StatelessWidget {
  final String? fieldName;
  final String? fieldValue;
  final TextStyle? fieldValueTextStyle;

  final auditPdfTextStyles = AuditPdfTextStyles();
  AuditProjectDetailsTableCell({
    this.fieldName,
    this.fieldValue,
    this.fieldValueTextStyle,
  });

  @override
  Widget build(Context context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AuditPdfDimension.projectDetailsTableCellWidth,
            child: AuditPdfCustomText(
              text: fieldName?.trim(),
              textStyle: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBoldItalic,
                color: AuditPdfColors.auditTextStyleColor,
                fontSize: 11,
              ),
            ),
          ),
          Container(
            width: 20,
          ),
          Container(
            // color: PdfColors.red,
            width: AuditPdfDimension.pageWidth -
                AuditPdfDimension.projectDetailsTableCellWidth -
                70,
            child: AuditPdfCustomText(
              padding: const EdgeInsets.only(
                top: 1,
                bottom: 1,
              ),
              text: fieldValue,
              textStyle: fieldValueTextStyle ??
                  // auditPdfTextStyles.textStyleForProjectDetailsFieldValue(),
                  TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    color: AuditPdfColors.auditTextStyleColor,
                    fontSize: 11,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
