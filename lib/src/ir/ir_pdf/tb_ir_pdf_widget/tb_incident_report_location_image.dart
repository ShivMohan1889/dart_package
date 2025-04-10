

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_dto.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';



class TbIncidentReportLocationImage extends StatelessWidget {
  final MemoryImage image;
  final IrPdfData? incidentReportDto;
  final incidentReportPdfTextStyle = TbIncidentReportPdfTextStyle();

  TbIncidentReportLocationImage({
    required this.image,
    this.incidentReportDto,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: TbIrPadding.paddingForLocationImage,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: TbIrPdfDimension.irLocationMapTitleBoxHeight,
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
                child: Row(
                  children: [
                    Text(
                      "REPORT LOCATION:",
                      // style: incidentReportPdfTextStyle
                      //     .incidentReportTextStyleWhiteNormal(),
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      incidentReportDto?.currentLocation ?? "",
                      // style: incidentReportPdfTextStyle
                      //     .incidentReportTextStyleWhiteNormal_10(),
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
                  width: TbIrPdfDimension.pageWidth -
                      TbIrPdfDimension.spaceUsedForPadding,
                  // padding: IrPadding.paddingForLocationMapImage,
                  height: TbIrPdfDimension.irMapImageHeight,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.9,
                      color: TbIncidentReportPdfColor.incidentReportThemeColor,
                    ),
                  ),
                  child: Center(
                    child: Image(
                      image,
                      fit: BoxFit.contain,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
