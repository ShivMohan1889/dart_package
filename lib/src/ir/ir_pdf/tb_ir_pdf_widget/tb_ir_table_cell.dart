import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

/// Widget that creates a cell that has heading and value
class TbIrTableCell extends StatelessWidget {
  final incidentReportPdfTextStyle = TbIncidentReportPdfTextStyle();

  /// title of the cell, you can call it heading
  final String title;

  ///  value related to the title
  final String value;

  final double? height;
  final double width;

  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;

  // this property is add to give width to value part

  final double? valueWidth;
  // this property is basically add for the managing line manager box height
  final EdgeInsets? padding;

  TbIrTableCell({
    required this.title,
    required this.value,
    this.height,
    required this.width,
    this.valueWidth,
    this.padding,
    this.titleTextStyle,
    this.valueTextStyle,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(
            left: 7,
            top: 6.5,
            bottom: 6.5,
          ),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: TbIncidentReportPdfColor.incidentReportThemeColor,
        ),
        // color: firstText == "Name:" ? PdfColors.amber : PdfColors.amber100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(title,
                // style: incidentReportPdfTextStyle.textStyleIncidentReportUser(),
                style: titleTextStyle ??
                    TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbIncidentReportPdfColor
                          .incidentReportTextlightGreyColor,
                      fontSize: 10,
                    )),
          ),
          Container(
            width: 10,
          ),
          Container(
            width: valueWidth,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: valueTextStyle ??
                  TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    fontSize: 10,
                  ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
