

import 'package:dart_pdf_package/src/ir/dto/incident_report_dto.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_question.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_table_cell.dart';
import 'package:dart_pdf_package/src/utils/enums/yes_and_no_enum.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

class TbIrLineAreaManager extends StatelessWidget {
  final IncidentReportDto? incidentReportEntity;

  final incidentReportPdfTextStyle = TbIncidentReportPdfTextStyle();
  TbIrLineAreaManager({
    this.incidentReportEntity,
  });

  @override
  Widget build(Context context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TbIrQuestionRow(
              middleDistance: 28,
              question: incidentReportEntity?.isManagerAware ==
                      YesAndNoOptions.no.index
                  ? "HAVE THE RELEVANT LINE / AREA MANAGER'S BEEN DIRECTLY NOTIFIED?"
                  : "HAVE THE RELEVANT LINE / AREA MANAGER'S\nBEEN DIRECTLY NOTIFIED?",
              answer: incidentReportEntity?.isManagerAware ?? 0,
            ),
          ),
          Container(
            // width: 20.5,
            width: 13,
          ),
          incidentReportEntity?.isManagerAware == YesAndNoOptions.yes.index
              ? Container(
                  child: TbIrTableCell(
                    padding: TbIrPadding.irALMBoxPadding,
                    width: TbIrPdfDimension.irAreaLineManagerBoxWidth,
                    title: "Name of Manager:",
                    titleTextStyle: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.fontBold,
                      color: TbIncidentReportPdfColor
                          .incidentReportTextdarkGreyColor,
                      fontSize: 10,
                    ),
                    value: (incidentReportEntity?.areaManagerName ?? ""),
                    valueWidth: 80,
                    valueTextStyle: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.fontBold,
                      color: PdfColors.black,
                      fontSize: 10,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
