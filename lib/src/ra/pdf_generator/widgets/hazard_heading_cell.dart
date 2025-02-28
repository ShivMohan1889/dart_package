import 'package:pdf/widgets.dart';

import '../tb_ra_pdf_constants.dart';

class HazardHeadingCell extends StatelessWidget {
  /// height of the cell
  final double height;

  /// width of the cell
  final double width;

  /// Text that will be drawn as heading
  final String headingText;

  /// style of the text
  final TextStyle style;

  HazardHeadingCell({
    required this.height,
    required this.width,
    required this.headingText,
    required this.style,
  });

  @override
  Widget build(Context context) {
    return Container(
      width: width,
      height: height,

      decoration: TbRaPdfBoxDecorations.borderBoxDecoration,
      // padding: RaPdfPaddings.cellPadding,
      child: Center(
        child: Text(
          headingText,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
