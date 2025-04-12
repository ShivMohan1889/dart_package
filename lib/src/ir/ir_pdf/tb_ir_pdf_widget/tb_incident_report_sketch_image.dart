import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIncidentReportSketchImage extends StatelessWidget {
  final MemoryImage image;
  final incidentReportPdfTextStyle = TbIncidentReportPdfTextStyle();

  TbIncidentReportSketchImage({
    required this.image,
  });

  @override
  Widget build(Context context) {
    return Container(
      // padding: TbIrPadding.defaultPadding,
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(
        children: [
          Column(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "WHICH PART OF THE BODY WAS INJURED SKETCH? ",
                      // style: incidentReportPdfTextStyle
                      //     .incidentReportTextStyleWhiteNormal(),
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 6.5,
                    bottom: 6.5,
                  ),
                  // width: 551.35,
                  width: TbIrPdfDimension.pageWidth -
                      TbIrPdfDimension.spaceUsedForPadding,
                  height: TbIrPdfDimension.sketchImageHeight,
                  decoration: BoxDecoration(
                    // color: PdfColors.indigo,
                    border: Border.all(
                      width: 0.9,
                      color: TbIncidentReportPdfColor.incidentReportThemeColor,
                    ),
                  ),
                  child: Image(
                    image,
                    fit: BoxFit.fitHeight,
                    width: TbIrPdfDimension.pageWidth -
                        TbIrPdfDimension.spaceUsedForPadding,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
