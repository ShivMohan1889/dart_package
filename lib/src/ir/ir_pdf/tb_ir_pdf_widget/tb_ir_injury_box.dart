import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/widgets.dart';

class TbIrInjuryOptionBox extends StatelessWidget {
  final incidentReportPdfTextStyle = TbIncidentReportPdfTextStyle();
  final String text;

  TbIrInjuryOptionBox({
    required this.text,
  });

  @override
  Widget build(Context context) {
    return Container(
        padding: TbIrPadding.defaultPadding,
        child: Row(children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            alignment: Alignment.centerLeft,
            height: TbIrPdfDimension.injuryOptionBoxHeight,
            width:
                TbIrPdfDimension.pageWidth - TbIrPdfDimension.spaceUsedForPadding,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.9,
                color: TbIncidentReportPdfColor.incidentReportThemeColor,
              ),
            ),
            child: Text(text,
                // style: incidentReportPdfTextStyle.textStyleForOptionName(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  fontSize: 10,
                )),
          )
        ]));
  }
}
