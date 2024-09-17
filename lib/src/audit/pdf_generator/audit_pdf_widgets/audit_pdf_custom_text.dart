import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

/// this widget use to holds  and show  text in audit  pdf
class AuditPdfCustomText extends StatelessWidget {
  final TextStyle? textStyle;

  final String? text;

  final double? height;
  final double? width;

  final PdfColor? color;

  final EdgeInsets? padding;

  AuditPdfCustomText({
    this.textStyle,
    this.text,
    this.height,
    this.width,
    this.padding,
    this.color,
  });

  @override
  Widget build(Context context) {
    return Container(
      color: color,
      padding: padding,
      height: height,
      width: width,
      alignment: Alignment.centerLeft,
      child: Text(
        "$text",
        style: textStyle,
        textAlign: TextAlign.left,
      ),
    );
  }
}
