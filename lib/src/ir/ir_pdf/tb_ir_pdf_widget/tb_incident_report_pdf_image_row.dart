import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIncidentReportPdfImageRow extends StatelessWidget {
  final MemoryImage? incidentReportInjuryPhoto;
  final List<Widget> children;

  TbIncidentReportPdfImageRow({
    this.incidentReportInjuryPhoto,
    required this.children,
  });

  @override
  Widget build(Context context) {
    return Container(
      height: TbIrPdfDimension.incidentReportImageBoxHeight,
      child: Container(
        padding: TbIrPadding.paddingForIrPdfImageRow,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
