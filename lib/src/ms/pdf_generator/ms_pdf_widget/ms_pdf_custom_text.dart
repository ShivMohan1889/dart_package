import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class MsPdfCustomText extends StatelessWidget {
  final String? text;

  final PdfColor? color;
  final double? height;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final TextAlign? textAlign;
  MsPdfCustomText({
    this.text,
    this.height,
    this.padding,
    this.textAlign,
    this.textStyle,
    this.color,
  });

  @override
  Widget build(Context context) {
    return Container(
      color: color,
      padding: padding,
      alignment: Alignment.centerLeft,
      child: Text(
        text ?? "",
        style: textStyle,
        textAlign: textAlign,
      ),
    );
  }
}
