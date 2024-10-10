import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

/// Class used to display a box with Title with the green background
///  and clear box below it with value
///
class TbIrInfoBox extends StatelessWidget {
  /// title of the box
  String title;

  /// value to be show in the box
  String value;

  final incidentReportTextStyle = TbIncidentReportPdfTextStyle();

  TbIrInfoBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(Context context) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 19,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title.toUpperCase(),
                      // style: incidentReportTextStyle
                      //     .incidentReportTextStyleWhiteNormal(),
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        color: PdfColors.white,
                        fontSize: 10,
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7,
                // top: 6.5,
                // bottom: 6.5,
                top: 6,
                bottom: 6,
              ),
              width:
                  TbIrPdfDimension.pageWidth - TbIrPdfDimension.spaceUsedForPadding,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.9,
                  color: TbIncidentReportPdfColor.incidentReportThemeColor,
                ),
              ),
              child: Text(value,
                  // style: incidentReportTextStyle
                  //     .textStyleForSecondTextInIncidentUser(),
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    fontSize: 10,
                  )),
            ),
          ],
        ),
      )
    ]);
  }
}
