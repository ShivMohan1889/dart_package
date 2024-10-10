import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIrHeader extends StatelessWidget {
  final MemoryImage incidentReportLogoImage;
  final MemoryImage? companyLogoImage;

  TbIrHeader({
    required this.incidentReportLogoImage,
    this.companyLogoImage,
  });

  @override
  Widget build(Context context) {
    return Container(
      height: TbIrPdfDimension.headerHeight,
      padding: TbIrPadding.headerPadding,
      width: TbIrPdfDimension.pageWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: TbIrPdfDimension.irLogoImageHeight,
            width: TbIrPdfDimension.irLogoWidth,
            child: Image(
              incidentReportLogoImage,
            ),
          ),
          Container(
            width: TbIrPdfDimension.pageWidth -
                79 -
                80 -
                TbIrPdfDimension.spaceUsedForPadding,
          ),
          companyLogoImage != null
              ? Container(
                  color: PdfColors.purple,
                  height: 100,
                  width: 100,
                  child: Image(
                    companyLogoImage!,
                    height: TbIrPdfDimension.companyLogoImageHeight,
                    width: TbIrPdfDimension.companyLogoImageWidth,
                  ))
              : Container()
        ],
      ),
    );
  }
}
