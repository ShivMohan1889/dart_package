import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../tb_ms_pdf_constants.dart';

class MsStatementRow extends StatelessWidget {
  final String? statementName;
  final TextStyle? statmentTextStyle;

  final EdgeInsets? padding;

  MsStatementRow({
    this.statementName,
    this.statmentTextStyle,
    this.padding,
  });
  @override
  Widget build(Context context) {
    var arr = statementName?.split('/n') ?? [];
    var first = arr.first;

    arr.removeAt(0);
    List<Widget> arrStatement = [];

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
          ),
          child: Container(
            height: 3,
            width: 3,
            decoration: BoxDecoration(
              color: PdfColors.blue,
              shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        Container(
          width: 5,
        ),
        Container(
          width: TbMsPdfWidth.statementWidth,
          child: Text(
            first,
            style: statmentTextStyle,
          ),
        ),
      ],
    );

    arrStatement.add(row);
    for (var s in arr) {
      arrStatement.add(Text(
        s.trim(),
        style: statmentTextStyle,
      ));
    }
    return Padding(
      padding: padding ?? TbMsPdfPaddings.paddingTbMsStatementRow,
      child: Container(
        child: Wrap(
          children: arrStatement,
          direction: Axis.horizontal,
          verticalDirection: VerticalDirection.down,
        ),
      ),
    );
  }
}
