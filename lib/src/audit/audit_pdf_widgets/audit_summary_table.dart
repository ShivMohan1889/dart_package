import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import '../audit_pdf_constants.dart';

import 'audit_summary_table_cell.dart';

// this widget is use to show summary table in pdf
class AuditSummaryTable extends StatelessWidget {
  final Map<String, int> chainOptionMap;

  final auditPdfTextStyle = AuditPdfTextStyles();

  AuditSummaryTable({
    required this.chainOptionMap,
  });

  @override
  Widget build(Context context) {
    return Container(
      // padding: AuditPdfPaddings.summeryTablePadding,
      padding: AuditPdfPaddings.righLeftPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(
                // bottom: 8,
                // left: 4,
                ),
            child: Text(
              "SUMMARY OF RESULTS",
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: AuditPdfColors.black,
                fontSize: 15,
              ),
            ),
          ),
          Container(
            height: 15,
          ),
          Table(
            border: TableBorder.all(width: 1, color: AuditPdfColors.black),
            columnWidths: {
              0: const FlexColumnWidth(8),
              1: const FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  Container(
                    color: AuditPdfColors.black,
                    // height: 50,
                    height: 30,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      left: 8,
                      // top: 15,
                    ),
                    child: Text(
                      "Answers",
                      // style:
                      //     auditPdfTextStyle.auditSummeryTableTitleTextStyle(),
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        fontSize: 12,
                        // fontSize: 11,
                        color: PdfColors.white,
                      ),
                    ),
                  ),
                  Container(
                    color: AuditPdfColors.black,
                    // height: 50,
                    height: 30,
                    padding: const EdgeInsets.only(
                      left: 15,
                      // top: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Count",
                      style: TbPdfHelper().textStyleGenerator(
                        // font: Theme.of(context).header0.fontBoldItalic,
                        font: Theme.of(context).header0.font,
                        fontSize: 12,
                        // fontSize: 11,
                        // color: AuditPdfColors.black,
                        color: PdfColors.white,
                      ),
                    ),
                  )
                ],
              ),

              // loop for iterating the key and value  pair of the given chainOptionMap
              for (var e in chainOptionMap.entries)
                TableRow(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    AuditSummaryTableCell(
                      name: e.key,
                      width: 25,
                      // height: 25,
                      height: 30,

                      padding: const EdgeInsets.only(
                        // left: 18,
                        left: 8,

                        // top: 15,
                      ),
                      // textStyle:
                      //     auditPdfTextStyle.auditCompanyUserNameTextStyle(),
                      textStyle: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        fontSize: 11,
                        color: AuditPdfColors.companyDetailsTextColor,
                      ),
                    ),
                    AuditSummaryTableCell(
                      name: e.value.toString(),
                      width: 10,
                      // height: 50,
                      height: 30,
                      alignment: Alignment.center,

                      padding: const EdgeInsets.only(
                          // left: 30,
                          // top: 15,
                          ),
                      textStyle: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        fontSize: 11,
                        color: AuditPdfColors.companyDetailsTextColor,
                      ),
                    )
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
