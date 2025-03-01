import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../audit_pdf_constants.dart';

import 'audit_pdf_custom_text.dart';

class AuditQuestionTextInputAnswerSection extends StatelessWidget {
  final String? questionEntityValues;
  final PdfColor? color;

  final auditPdfTextStyle = AuditPdfTextStyles();

  AuditQuestionTextInputAnswerSection({this.questionEntityValues, this.color});

  @override
  Widget build(Context context) {
    return Container(
      color: color,
      padding: AuditPdfPaddings.auditQuestionTextInputAnswerSectionPadding,
      // padding: const EdgeInsets.only(
      //   left: 40,
      //   right: 20,
      // ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuditPdfCustomText(
            text: "A",
            // textStyle: auditPdfTextStyle.questionNumberTextStyle(),
            textStyle: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: AuditPdfColors.black,
              fontSize: 12,
            ),
          ),
          Container(
            width: 4,
          ),
          AuditPdfCustomText(
            text: questionEntityValues,
            textStyle: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: AuditPdfColors.companyDetailsTextColor,
              fontSize: 12,
            ),
            // textStyle: auditPdfTextStyle.questionNameTextStyle(),
          ),
        ],
      ),
    );
  }
}
