import 'package:dart_pdf_package/src/ir/model/ir_pdf_data.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_table_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../dart_pdf_package.dart';

class TbIrDateTime extends StatelessWidget {
  final incidentReportTextStyle = TbIncidentReportPdfTextStyle();
  final IrPdfData? incidentReportData;
  final String localName;

  TbIrDateTime({
    this.incidentReportData,
    required this.localName,
  });

  @override
  Widget build(Context context) {
    return Container(
      width: TbIrPdfDimension.pageWidth,
      padding: TbIrPadding.paddingForIrDateTime,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 19,
            width: TbIrPdfDimension.pageWidth -
                TbIrPdfDimension.spaceUsedForPadding,
            decoration: BoxDecoration(
              color: TbIncidentReportPdfColor.incidentReportThemeColor,
              border: Border.all(
                width: 1,
                color: TbIncidentReportPdfColor.incidentReportThemeColor,
              ),
            ),
            padding: const EdgeInsets.only(
              left: 7,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              TbPdfHelper().returnTextForIncidentReportType(
                irPdfData: incidentReportData,
                injuryTypeText: "DETAILS OF THE ACCIDENT",
                illHealthTypeText: "DETAILS OF THE ILL-HEALTH",
                nearMissType: "DETAILS OF THE NEAR MISS",
              ),
              // style:
              //     incidentReportTextStyle.incidentReportTextStyleWhiteNormal(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: PdfColors.white,
                fontSize: 10,
              ),
            ),
          ),
          TbIrTableRow(
            firstTitle: "Start Date:",
            // firstValue: " ${incidentReportEntity?.reportingDate}",
            firstValue: incidentReportData?.reportingDate ?? "",

            secondTitle: "Time:",
            secondValue: " ${incidentReportData?.reportingTime}",
            secondContainerWidth: 300,
          ),
          Container(
            width: TbIrPdfDimension.pageWidth -
                TbIrPdfDimension.spaceUsedForPadding,
            padding: const EdgeInsets.only(
              left: 7,
              top: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: TbIncidentReportPdfColor.incidentReportThemeColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Location:",
                    // style: incidentReportTextStyle.textStyleIncidentReportUser(),
                    style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        fontSize: 10,
                        color: TbIncidentReportPdfColor
                            .incidentReportTextlightGreyColor)),
                Container(width: 5),
                Text(incidentReportData?.location ?? "",
                    // style: incidentReportTextStyle
                    //     .textStyleForSecondTextInIncidentUser(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      fontSize: 10,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
