
import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_dto.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIrImageTitle extends StatelessWidget {
  // this widget is used for how show the incident injury Image title
  final incidentReportTextStyle = TbIncidentReportPdfTextStyle();
  final IrPdfData incidentReportEntity;

  TbIrImageTitle({
    required this.incidentReportEntity, 
  });

  @override
  Widget build(Context context) {
    // don't remvoe this Row from here, it has been put intensionally
    return Row(children: [
      Container(
        padding: TbIrPadding.irImageTitlePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: TbIrPdfDimension.irImageTitleHeight,
              height: TbIrPdfDimension.irImageTitleHeight,
              width:
                  TbIrPdfDimension.pageWidth - TbIrPdfDimension.spaceUsedForPadding,
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
                  irPdfData: incidentReportEntity,
                  injuryTypeText: "PHOTOS OF THE INCIDENT:",
                  illHealthTypeText: "",
                  nearMissType: "PHOTOS OF THE NEAR MISS:",
                ),
                // style: incidentReportTextStyle
                //     .incidentReportTextStyleWhiteNormal(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  color: PdfColors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
