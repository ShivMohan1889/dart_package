import 'package:pdf/widgets.dart';

class AuditSummaryTableCell extends StatelessWidget {
  String? name;
  EdgeInsets? padding;
  double? height;
  double? width;
  AlignmentGeometry? alignment;
  TextStyle? textStyle;

  AuditSummaryTableCell({
    this.name,
    this.padding,
    this.height,
    this.width,
    this.textStyle,
    this.alignment,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      alignment: alignment ?? Alignment.centerLeft,
      child: Text(
        "$name",
        style: textStyle,
      ),
    );
  }
}
