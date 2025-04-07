import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../tb_ms_pdf_constants.dart';

class MsStatementRow extends StatelessWidget {
  // final String? statementName;
  final TbStatementRowModel statementRowModel;
  final TextStyle? statmentTextStyle;

  final EdgeInsets? padding;

  double? height;

  MsStatementRow({
    // this.statementName,
    this.statmentTextStyle,
    this.padding,
    this.height,
    required this.statementRowModel,
  });
  @override
  Widget build(Context context) {
    // var arr = statementRowModel.statementName.split('\n') ?? [];
    // var first = arr.first;

    // arr.removeAt(0);
    List<Widget> arrStatement = [];

    var row = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          statementRowModel.isShowBulletPoint
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Container(
                    height: 3,
                    width: 3,
                    decoration: BoxDecoration(
                      color: PdfColors.black,
                      shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                )
              : Container(),
          Container(
            width: 5,
          ),
          Container(
            width: TbMsPdfWidth.statementWidth,
            child: Text(
              // statementRowModel.statementName,
              statementRowModel.statementName,
              style: statmentTextStyle ??
                  TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    color: MsPdfColors.black,
                    fontSize: 11,
                  ),
            ),
          ),
        ],
      ),
    );

    arrStatement.add(row);
    // for (var s in arr) {
    //   arrStatement.add(
    //     Container(
    //       child: Text(
    //         s.trim(),
    //         style: statmentTextStyle,
    //       ),
    //     ),
    //   );
    // }
    return Container(
      padding: padding ?? TbMsPdfPaddings.paddingTbMsStatementRow,
      child: Container(
        child: Column(
          children: arrStatement,

          // direction: Axis.horizontal,
          // verticalDirection: VerticalDirection.down,
        ),
      ),
    );
  }
}
