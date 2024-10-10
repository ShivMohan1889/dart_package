import 'dart:math';


import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_table_cell.dart';
import 'package:pdf/widgets.dart';

/// widget that works as a row in the tables we create in the incident report
/// this widget can be dived on the two parts depending on the need
/// like name and job description
class TbIrTableRow extends StatelessWidget {
  /// first heading
  final String firstTitle;

  /// value of first heading
  final String firstValue;

  /// second heading
  final String? secondTitle;

  /// value of second title/heading
  final String? secondValue;

  // width of value part
  final double? valueWidth;

  /// if second part is avaialable we need to specify width of the second part
  final double? secondContainerWidth;

  // if second part is aviable then we need to give the width to value of second container to overcome the text
  final double? secondContainerValueWidth;

  TbIrTableRow({
    required this.firstTitle,
    required this.firstValue,
    this.secondTitle,
    this.secondValue,
    this.secondContainerWidth,
    this.valueWidth,
    this.secondContainerValueWidth,
  });

  @override
  Widget build(Context context) {
    // here we will first calculte width of the row by subracting padding
    double w = TbIrPdfDimension.pageWidth - TbIrPdfDimension.spaceUsedForPadding;

    // then calculate first part width by subtracting secondContainerWidth
    double widthFirstContainer = w - (secondContainerWidth ?? 0);

    // find max height of both of the parts, as sometimes one can have more data then another
    var maxHeight = returnMaximumHeight(
      firstContainerWidth: widthFirstContainer,
      secondContainerWidth: secondContainerWidth ?? 0,
    );

    return Container(
        child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TbIrTableCell(
            width: widthFirstContainer,
            title: firstTitle,
            value: firstValue,
            height: maxHeight,
            valueWidth: valueWidth,
          ),
          secondValue == null || secondTitle == null
              ? Container()
              : TbIrTableCell(
                  width: secondContainerWidth ?? 0,
                  title: secondTitle ?? "",
                  value: secondValue ?? "",
                  height: maxHeight,
                  valueWidth: secondContainerValueWidth,
                ),
        ],
      ),
    ));
  }

  /* ********************** */
  // RETURN MAXIMUM HEIGHT
  /// in this method we return the max height by
  /// comparing  the firstSection Height  and secondSectionHeight
  /// this thing we did to provide same height to the both section
  /* *********************** */

  double returnMaximumHeight({
    required double firstContainerWidth,
    required double secondContainerWidth,
  }) {
    double maxContainerHeight = 0;

    double firstWidgetHeight = 0;
    double secondWidgetHeight = 0;

    Widget w = TbIrTableCell(
        width: firstContainerWidth,
        title: firstTitle,
        value: firstValue,
        valueWidth: valueWidth);

    Widget w2 = TbIrTableCell(
        width: secondContainerWidth,
        title: secondTitle ?? "",
        value: secondValue ?? "",
        valueWidth: valueWidth);

    // the first section Height
    firstWidgetHeight = TbPdfHelper()
        .calculateHeightOfWidget(widget: w, width: firstContainerWidth);
    // get the second Section Height
    secondWidgetHeight = TbPdfHelper()
        .calculateHeightOfWidget(widget: w2, width: secondContainerWidth);

    // get the width
    maxContainerHeight = max(firstWidgetHeight, secondWidgetHeight);
    maxContainerHeight = max(maxContainerHeight, 26);

    return maxContainerHeight;
  }
}
