
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/yes_and_no_enum.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIrQuestionRow extends StatelessWidget {
  final String question;

  final int answer;

  final double? middleDistance;

  final incidentTextStyle = TbIncidentReportPdfTextStyle();

  TbIrQuestionRow({
    required this.question,
    required this.answer,
    this.middleDistance,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: TbIrPadding.defaultPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
              // style: incidentTextStyle.incidentReportForTextInYesAndNoOption(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                fontSize: 9.8,
              )),
          Container(width: middleDistance ?? 17),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "YES",
                  // style: incidentTextStyle.incidentReportYesNoOptionTextStyle(),
                  style: TbPdfHelper().textStyleGenerator(
                    fontSize: 9.7,
                    font: Theme.of(context).header0.fontBold,
                  ),
                ),
                Container(
                  // width: 3.5,
                  width: 6,
                ),
                circleWidget(
                  color: answer == YesAndNoOptions.yes.index
                      ? TbIncidentReportPdfColor.incidentReportThemeColor
                      : PdfColors.white,
                ),
              ],
            ),
          ),
          Container(width: 10),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "NO",
                  // style: incidentTextStyle.incidentReportYesNoOptionTextStyle(),
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    fontSize: 9.7,
                  ),
                ),
                Container(
                  // width: 4.5,
                  width: 5,
                  color: PdfColors.purple,
                ),
                circleWidget(
                  color: answer == YesAndNoOptions.no.index
                      ? TbIncidentReportPdfColor.incidentReportThemeColor
                      : PdfColors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget circleWidget({required PdfColor color}) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 1.2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }
}
