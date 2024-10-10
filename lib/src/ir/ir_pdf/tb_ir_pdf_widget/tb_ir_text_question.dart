import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIrTextQuestion extends StatelessWidget {
  final String question;

  final String answer;

  final double? answerBoxWidth;

  final double? textWidth;

  final double? middleDistance;

  final incidentReportTextStyle = TbIncidentReportPdfTextStyle();

  TbIrTextQuestion({
    required this.question,
    required this.answer,
    this.answerBoxWidth,
    this.middleDistance,
    this.textWidth,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 5,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: textWidth,
            child: Text(question,
                textAlign: TextAlign.left,
                // style: incidentReportTextStyle.incientReportQuestionTextStyle(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  color: PdfColors.black,
                  fontSize: 10,
                )),
          ),
          Container(
            width: middleDistance,
          ),
          Container(
            height: TbIrPdfDimension.irTextQuestionHeight,
            width: answerBoxWidth ?? 391.5 - 40,
            decoration: BoxDecoration(
              color: TbIncidentReportPdfColor.incidentReportThemeColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: Center(
              child: Text(answer,
                  // style:
                  // incidentReportTextStyle.incidentReportTypeTextStyleWhite(),

                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    color: PdfColors.white,
                    fontSize: 10,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
