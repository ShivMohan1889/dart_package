import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/widgets.dart';

class TbIncidentReportInjuryImageBox extends StatelessWidget {
  // this list holds the image Widget Row
  List<Widget> listRowItems;

  TbIncidentReportInjuryImageBox({
    required this.listRowItems,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: TbIrPadding.paddingLeftRight_20,
      width: TbIrPdfDimension.pageWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width:
                  TbIrPdfDimension.pageWidth - TbIrPdfDimension.spaceUsedForPadding,
              decoration: BoxDecoration(
                  border: Border.all(
                color: TbIncidentReportPdfColor.incidentReportThemeColor,
                width: 1,
              )),
              child: Column(
                children: listRowItems,
              ))
        ],
      ),
    );
  }
}
