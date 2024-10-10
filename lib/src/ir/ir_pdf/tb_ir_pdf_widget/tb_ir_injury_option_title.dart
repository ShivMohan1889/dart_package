
import 'package:dart_pdf_package/src/ir/dto/incident_report_dto.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIrInjuryOptionTitle extends StatelessWidget {
  final incidentReportTextStyle = TbIncidentReportPdfTextStyle();
  final IncidentReportDto? incidentReportEntity;

  TbIrInjuryOptionTitle({
    this.incidentReportEntity,
  });

  @override
  Widget build(Context context) {
    return Container(
      // padding: TbIrPadding.irOptionTitleBoxPadding,
      // padding: TbIrPadding.defaultPadding,
      padding: TbIrPadding.irOptionTitlePadding,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width:
                TbIrPdfDimension.pageWidth - TbIrPdfDimension.spaceUsedForPadding,
            // height: 50,
            height: TbIrPdfDimension.irInjuryOptionTitleHeight,
            decoration: BoxDecoration(
              color: TbIncidentReportPdfColor.incidentReportThemeColor,
              // color: PdfColors.amber,
              border: Border.all(
                width: 1,
                color: TbIncidentReportPdfColor.incidentReportThemeColor,
              ),
            ),
            padding: const EdgeInsets.only(
              left: 7,
              right: 7,
            ),
            // alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: TbIrPdfDimension.pageWidth -
                      TbIrPdfDimension.spaceUsedForPadding,
                  child: Text(
                    TbPdfHelper().returnTextForIncidentReportType(
                      incidentReportEntity: incidentReportEntity,
                      injuryTypeText: "ABOUT THE INJURY OR NEAR MISS",
                      illHealthTypeText: "ABOUT ILL HEALTH",
                      nearMissType: "ABOUT THE INJURY OR NEAR MISS",
                    ),
                    // style: incidentReportTextStyle
                    //     .incidentReportTextStyleWhiteNormal_10(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: PdfColors.white,
                      fontSize: 10,
                    ),

                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                    child: Text(
                  TbPdfHelper().returnTextForIncidentReportType(
                    incidentReportEntity: incidentReportEntity,
                    injuryTypeText:
                        "Complete this section to specify what the injury is & which parts of the body are injured. How serious is the injury? If it was a near-miss, how could somebody have been hurt?",
                    illHealthTypeText:
                        "Complete this section to specify what the ill heath is",
                    nearMissType:
                        "Complete this section to specify what the injury is & which parts of the body are injured. How serious is the injury? If it was a near-miss, how could somebody have been hurt?",
                  ),
                  // style: incidentReportTextStyle
                  //     .incidentReportTextStyleWhiteNormal_9(),
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    color: PdfColors.white,
                    fontSize: 9,
                  ),

                  textAlign: TextAlign.left,
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
