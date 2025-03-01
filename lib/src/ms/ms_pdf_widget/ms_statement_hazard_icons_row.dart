import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:pdf/widgets.dart';

class MsStatementHazardIconsRow extends StatelessWidget {
  final List<Widget> iconsImageList;

  MsStatementHazardIconsRow({
    required this.iconsImageList,
  });

  @override
  Widget build(Context context) {
    return Container(
      height: 90,

      margin: TbMsPdfPaddings.marginTbMsStatementHazardIconRow,
      // margin: const EdgeInsets.only(
      //   top: 10,
      //   left: 20,
      //   right: 20,
      //   bottom: 10,
      // ),
      // color: PdfColors.red,
      // padding: const EdgeInsets.only(
      //   left: 5,
      //   right: ,
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: iconsImageList,
      ),
    );
  }
}
