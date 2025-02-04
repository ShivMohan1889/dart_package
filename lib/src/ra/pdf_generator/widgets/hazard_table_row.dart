import 'package:dart_pdf_package/src/ra/pdf_generator/widgets/hazard_text.dart';
import 'package:dart_pdf_package/src/utils/extensions/string_extension.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../models/tb_hazard_row_model.dart';
import '../tb_ra_pdf_constants.dart';

/// creates heading of the hazards table
class HazardTableRow extends StatelessWidget {
  final TbHazardRowModel row;
  final int isStandard;
  final raPdfTextStyles = TbRaPdfTextStyles();

  final String? hazardScore;

  HazardTableRow({
    required this.row,
    required this.isStandard,
    this.hazardScore,
  });

  @override
  Widget build(Context context) {
    if (isStandard == 1) {
      return standardHazardRow(
        context: context,
      );
    } else {
      return matrixHazardRow(
        context: context,
      );
    }
  }

  Widget matrixHazardRow({
    required Context context,
  }) {
    PdfColor controlInPlaceColor =
        colorForScore(row.score ?? row.splitItemScore ?? "0");
    // PdfColor additionalControlColor = PdfColors.amber;
    PdfColor additionalControlColor = colorForScore(
        row.additionalScore ?? row.splitItemAdditionalScore ?? "0");
    return Container(
      padding: TbRaPdfPaddings.pageHorizontalPadding,
      child: Table(
        border: TableBorder.all(width: 0.5, color: TbRaPdfColors.greyBorder),
        children: [
          TableRow(
            verticalAlignment: TableCellVerticalAlignment.full,
            children: [
              HazardTableCell(
                text: row.name ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[0],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  fontSize: 9,
                  color: TbRaPdfColors.black,
                ),
              ),
              HazardTableCell(
                text: row.gridRef ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[1],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  fontSize: 9,
                  color: TbRaPdfColors.black,
                ),
              ),
              HazardTableCell(
                text: row.controlInPlace ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[2],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.worstCase ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[3] / 4 + 4,
                // style: raPdfTextStyles.italicBlack7(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 7,
                ),
              ),
              HazardTableCell(
                text: row.likelihood ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[3] / 4 + 4,
                // style: raPdfTextStyles.italicBlack7(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 7,
                ),
              ),
              HazardTableCell(
                text: row.score ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[3] / 4 - 4 - 3,
                // style: raPdfTextStyles.italicBlack7(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 7,
                ),
                backgroundColor: controlInPlaceColor,
              ),
              HazardTableCell(
                text: row.rating ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[3] / 4 - 4 + 3,
                // style: raPdfTextStyles.italicBlack7(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 7,
                ),
                backgroundColor: controlInPlaceColor,
              ),
              HazardTableCell(
                text: row.additionalControl ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[4],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.additionalLikelihood ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[5] / 3 + 8,
                // style: raPdfTextStyles.italicBlack7(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 7,
                ),
              ),
              HazardTableCell(
                text:
                    row.additionalScore == "0" ? "" : row.additionalScore ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[5] / 3 - 4 - 3,
                // style: raPdfTextStyles.italicBlack7(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 7,
                ),
                backgroundColor: additionalControlColor,
              ),
              HazardTableCell(
                text: row.additionalScore == "0"
                    ? ""
                    : row.additionalRating ?? "",
                width: TbRaPdfWidth.columnWidthMatrix[5] / 3 - 4 + 3,
                // style: raPdfTextStyles.italicBlack7(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 7,
                ),
                backgroundColor: additionalControlColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget standardHazardRow({
    required Context context,
  }) {
    return Container(
      padding: TbRaPdfPaddings.pageHorizontalPadding,
      child: Table(
        border: TableBorder.all(
          width: 0.5,
          color: TbRaPdfColors.greyBorder,
        ),
        children: [
          TableRow(
            verticalAlignment: TableCellVerticalAlignment.full,
            children: [
              HazardTableCell(
                text: row.name ?? "",
                width: TbRaPdfWidth.columnWidthStandard[0],
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.gridRef ?? "",
                width: TbRaPdfWidth.columnWidthStandard[1],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.controlInPlace ?? "",
                width: TbRaPdfWidth.columnWidthStandard[2],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.worstCase ?? "",
                width: TbRaPdfWidth.columnWidthStandard[3],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.likelihood ?? "",
                width: TbRaPdfWidth.columnWidthStandard[4],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.additionalControl ?? "",
                width: TbRaPdfWidth.columnWidthStandard[5],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.score ?? "",
                width: TbRaPdfWidth.columnWidthStandard[6],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              HazardTableCell(
                text: row.rating ?? "",
                width: TbRaPdfWidth.columnWidthStandard[7],
                // style: raPdfTextStyles.italicBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontItalic,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /* ************************************** */
  // COLOR FOR SCORE
  /* ************************************** */
  PdfColor colorForScore(String score) {
    print("Score Given score $score");
    int s = score.parseInt();

    // score.parseInt():  (hazardScore ?? "0").parseInt();
    if (s <= 25 && s >= 16) {
      return TbRaPdfColors.red;
    } else if (s <= 15 && s >= 9) {
      return TbRaPdfColors.yellow;
    } else if (s <= 8 && s >= 1) {
      return TbRaPdfColors.green;
    } else {
      return TbRaPdfColors.white;
    }
  }
}
