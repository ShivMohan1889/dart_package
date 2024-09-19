

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../tb_ra_pdf_constants.dart';
import 'hazard_heading_cell.dart';

/// creates heading of the hazards table
class HazardHeadingRow extends StatelessWidget {
  final int isStandard;
  final raPdfTextStyles = TbRaPdfTextStyles();
  HazardHeadingRow({
    required this.isStandard,
  });

  @override
  Widget build(Context context) {
    if (isStandard == 1) {
      return standardHazardHeading(
        context: context,
      );
    } else {
      return matrixHazardHeading(
        context: context,
      );
    }
  }

  Widget standardHazardHeading({
    required Context context,
  }) {
    return Container(
      // color: PdfColors.green,
      padding: TbRaPdfPaddings.pageHorizontalPadding,
      child: Row(
        children: [
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthStandard[0],
            headingText: "Hazard Identified \nand\nWho is at Risk",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthStandard[1],
            headingText: "Grid\nRef",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthStandard[2],
            headingText: "Controls in Place",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthStandard[3],
            headingText: "Worst Case\nOutcome",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthStandard[4],
            headingText: "Likelihood\nWithout\naction",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthStandard[5],
            headingText: "Additional Control\nMeasures Required",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthStandard[6],
            headingText: "Score",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthStandard[7],
            headingText: "Rating",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget matrixHazardHeading({
    required Context context,
  }) {
    return Padding(
      padding: TbRaPdfPaddings.pageHorizontalPadding,
      child: Row(
        children: [
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthMatrix[0],
            headingText: "Hazard Identified \nand\nWho is at Risk",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthMatrix[1],
            headingText: "Grid\nRef",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthMatrix[2],
            headingText: "Controls in Place",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          Container(
            width: TbRaPdfWidth.columnWidthMatrix[3],
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            decoration: TbRaPdfBoxDecorations.borderBoxDecoration,
            child: Center(
              child: Column(
                children: [
                  HazardHeadingCell(
                    height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.6,
                    width: TbRaPdfWidth.columnWidthMatrix[3],
                    headingText: "Based on\nExisting Controls",
                    // style: raPdfTextStyles.hazardTableHeading(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.fontBold,
                      color: TbRaPdfColors.black,
                      // fontSize: 9,
                      fontSize: 8,
                    ),
                  ),
                  Container(
                    decoration: TbRaPdfBoxDecorations.borderBoxDecoration,
                    height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HazardHeadingCell(
                          height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                          width: TbRaPdfWidth.columnWidthMatrix[3] / 4 + 4,
                          headingText: "Worst\nCase",
                          // style: raPdfTextStyles.hazardTableSubHeading(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.fontBold,
                            // fontSize: 8,
                            fontSize: 7,
                            color: TbRaPdfColors.black,
                          ),
                        ),
                        HazardHeadingCell(
                          height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                          width: TbRaPdfWidth.columnWidthMatrix[3] / 4 + 4,
                          headingText: "Likeli\nhood",
                          // style: raPdfTextStyles.hazardTableSubHeading(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.fontBold,
                            // fontSize: 8,
                            fontSize: 7,

                            color: TbRaPdfColors.black,
                          ),
                        ),
                        HazardHeadingCell(
                          height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                          width: TbRaPdfWidth.columnWidthMatrix[3] / 4 - 4 - 3,
                          headingText: "Score",
                          // style: raPdfTextStyles.hazardTableSubHeading(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.fontBold,
                            // fontSize: 8,
                            fontSize: 7,
                            color: TbRaPdfColors.black,
                          ),
                        ),
                        HazardHeadingCell(
                          height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                          width: TbRaPdfWidth.columnWidthMatrix[3] / 4 - 4 + 3,
                          headingText: "Rating",
                          // style: raPdfTextStyles.hazardTableSubHeading(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.fontBold,
                            // fontSize: 8,
                            fontSize: 7,
                            color: TbRaPdfColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          HazardHeadingCell(
            height: TbRaPdfSectionHeights.HAZARD_HEADING,
            width: TbRaPdfWidth.columnWidthMatrix[4],
            headingText: "Additional Control\nMeasures Required",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              // fontSize: 9,
              fontSize: 8,
            ),
          ),
          Container(
            decoration: TbRaPdfBoxDecorations.borderBoxDecoration,
            height: 50,
            width: TbRaPdfWidth.columnWidthMatrix[5],
            child: Center(
              child: Column(
                children: [
                  HazardHeadingCell(
                    height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.6,
                    width: TbRaPdfWidth.columnWidthMatrix[5],
                    headingText: "Residual Risk",
                    // style: raPdfTextStyles.hazardTableHeading(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.fontBold,
                      color: TbRaPdfColors.black,
                      // fontSize: 9,
                      fontSize: 8,
                    ),
                  ),
                  Container(
                    height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HazardHeadingCell(
                          height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                          width: TbRaPdfWidth.columnWidthMatrix[5] / 3 + 8,
                          headingText: "Likeli\nhood",
                          // style: raPdfTextStyles.hazardTableSubHeading(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.fontBold,
                            // fontSize: 8,
                            fontSize: 7,

                            color: TbRaPdfColors.black,
                          ),
                        ),
                        HazardHeadingCell(
                          height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                          width: TbRaPdfWidth.columnWidthMatrix[5] / 3 - 4 - 3,
                          headingText: "Score",
                          // style: raPdfTextStyles.hazardTableSubHeading(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.fontBold,
                            // fontSize: 8,
                            fontSize: 7,

                            color: TbRaPdfColors.black,
                          ),
                        ),
                        HazardHeadingCell(
                          height: TbRaPdfSectionHeights.HAZARD_HEADING * 0.4,
                          width: TbRaPdfWidth.columnWidthMatrix[5] / 3 - 4 + 3,
                          headingText: "Rating",
                          // style: raPdfTextStyles.hazardTableSubHeading(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.fontBold,
                            // fontSize: 8,
                            fontSize: 7,

                            color: TbRaPdfColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
