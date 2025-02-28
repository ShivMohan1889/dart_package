import 'package:dart_pdf_package/src/ra/pdf_generator/tb_ra_pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';


class HazardTableCell extends StatelessWidget {
  /// text string that you need to draw
  final String text;

  /// predefine width in which you need to draw
  final double width;

  /// style of the text
  final TextStyle style;

  /// background color
  final PdfColor? backgroundColor;

  HazardTableCell({
    required this.text,
    required this.width,
    required this.style,
    this.backgroundColor,
  });

  @override
  Widget build(Context context) {
    var listText = text.split("...");
    List<TextSpan> listTextSpans = [];

    for (var item in listText) {
      TextSpan span = TextSpan(
        text: item,
        style: style,
      );
      listTextSpans.add(span);

      if (listText.last != item) {
        TextSpan span2 =
            TextSpan(text: ".", style: TextStyle(color: TbRaPdfColors.white));
        listTextSpans.add(span2);
      }
    }
    return Container(
      padding: TbRaPdfPaddings.cellPadding,
      width: width,
      color: backgroundColor ?? TbRaPdfColors.white,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "",
            children: listTextSpans,
          ),
        ),
      ),
    );
  }
}
