
import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/incident_report_enum.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

class TbIrType extends StatelessWidget {
  final int incidentReportType;
  final TbIncidentReportPdfTextStyle incidentReportPdfTextStyle =
      TbIncidentReportPdfTextStyle();
  TbIrType({
    required this.incidentReportType,
  });

  @override
  Widget build(Context context) {
    return Container(
      width: TbIrPdfDimension.pageWidth,
      padding: TbIrPadding.defaultPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("EMPLOYEE'S REPORT OF INJURY /  ILL HEALTH / NEAR MISS",
                // style:
                //     incidentReportPdfTextStyle.incidentReportTextStyleBold_11(),
                style:
                    // incidentReportPdfTextStyle.incidentReportTextStyleBold_11(),
                    TbPdfHelper().textStyleGenerator(
                  fontSize: 11.55,
                  color: PdfColors.black,
                  font: Theme.of(context).header0.fontBold,
                ),
                textAlign: TextAlign.left),
          ),
          Container(
            height: 4.259,
          ),
          Text("REPORTING:",
              // style: incidentReportPdfTextStyle.pdfTextStyle_9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: PdfColors.black,
                fontSize: 9.5,
              ),
              textAlign: TextAlign.left),
          Container(
            height: 30.1,
            width: TbIrPdfDimension.pageWidth,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: PdfColors.white),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                returnReportTypeTextContainer(
                  text: "Injury",
                  isSelected: incidentReportType == IncidentReport.injuryType,
                  context: context,
                ),
                Container(width: 20),
                returnReportTypeTextContainer(
                  text: "Ill-Health",
                  context: context,
                  isSelected:
                      incidentReportType == IncidentReport.illHealthType,
                ),
                Container(width: 20),
                returnReportTypeTextContainer(
                  context: context,
                  text: "Near Miss",
                  isSelected: incidentReportType == IncidentReport.nearMissType,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /* *************** */
  // RETURN REPORT TYPE TEXT CONTAINER
  /// this method is responsible for return the given container
  /// which show ir report type text like injury, near miss, ill health
  /* *************** */

  Widget returnReportTypeTextContainer({
    required String text,
    required bool isSelected,
    required Context context,
  }) {
    return Container(
      height: TbIrPdfDimension.injuryTypeContainerHeight,
      width: TbIrPdfDimension.irTypeContainerWidth,
      decoration: BoxDecoration(
        color: isSelected == true
            ? TbIncidentReportPdfColor.incidentReportThemeColor
            : TbIncidentReportPdfColor.incidentReportGreyColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: isSelected
              // ? incidentReportPdfTextStyle.incidentReportTypeTextStyleWhite(
              ? TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 10,
                  color: PdfColors.white,
                )
              // : incidentReportPdfTextStyle.incidentReportTypeTextStyle(),
              : TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 10,
                  color: TbIncidentReportPdfColor.incidentReportTypeTextColor,
                ),
        ),
      ),
    );
  }
}
