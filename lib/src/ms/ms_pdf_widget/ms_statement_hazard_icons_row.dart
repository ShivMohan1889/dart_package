import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class MsStatementHazardIconsRow extends StatelessWidget {
  final List<Widget> iconsImageList;

  MsStatementHazardIconsRow({
    required this.iconsImageList,
  });

  @override
  Widget build(Context context) {
    return Container(
      // color: PdfColors.green100,
      padding: TbMsPdfPaddings.marginTbMsStatementHazardIconRow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: iconsImageList,
      ),
    );
  }
}
