import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../tb_ms_pdf_constants.dart';

class MsProjectDetailsTableCell extends StatelessWidget {
  final String? templateFieldName;
  final String? templateFieldValues;

  final TextStyle? textStyleForFieldName;
  final TextStyle? textStyleForFieldValues;

  final EdgeInsets? padding;
  final double? height;
  final double? width;

  final msPdfTextStyles = TbMsPdfTextStyles();

  MsProjectDetailsTableCell({
    this.textStyleForFieldValues,
    this.textStyleForFieldName,
    this.templateFieldName,
    this.templateFieldValues,
    this.height,
    this.width,
    this.padding,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(
            top: 4,
            bottom: 4,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96,
            child: Text(
              "$templateFieldName:",
              style: textStyleForFieldName,
            ),
          ),
          Container(
            width: 8,
          ),
          Container(
            width: 160,
            child: Text(
              "$templateFieldValues",
              style: textStyleForFieldValues,
            ),
          )
        ],
      ),
    );
  }
}
