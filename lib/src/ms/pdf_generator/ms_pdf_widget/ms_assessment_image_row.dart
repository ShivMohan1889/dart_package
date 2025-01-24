

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/audit/pdf_generator/audit_pdf_constants.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_pdf_custom_text.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_statement_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class MsAssessmentImageRow extends StatelessWidget {
  final List<Widget> listChildren;
  final String? text;
  final String? statement;

  MsAssessmentImageRow({
    required this.listChildren,
    this.text,
    this.statement,
  });

  @override
  Widget build(Context context) {
    return Wrap(
      children: [
        Container(
          // color: PdfColors.amber,
          // padding: MsPdfPaddings.paddingForMsHeaderEntityHeaderLevelNotZero,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (statement ?? "").isNotEmpty
                  ? 
                  
                  MsStatementRow(
                      statementName: statement,
                      // color: PdfColors.amber,
                      // statmentTextStyle: msPdfTextStyle.msStatementTextStyle(),
                      statmentTextStyle: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        color: MsPdfColors.companyDetailsTextColor,
                        fontSize: 11,
                      ),
                    )
                  : Container(),
              (statement ?? '').isNotEmpty
                  ? Container(
                      height: 10,
                    )
                  : Container(),
              (text ?? '').isNotEmpty
                  ? MsPdfCustomText(
                      // color: PdfColors.red,
                      text: "Header Reference Images",
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),

                      // padding: MsPdfPaddings.paddingForMsheaderEntity,
                      textStyle: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        color: MsPdfColors.msBlueThemeColor,
                        fontSize: 12,
                      ),
                    )
                  : Container(),
              (text ?? '').isNotEmpty
                  ? Container(
                      height: 10,
                    )
                  : Container(),
              Container(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: listChildren,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
