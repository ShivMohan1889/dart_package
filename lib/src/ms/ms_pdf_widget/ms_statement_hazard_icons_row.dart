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
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Center the icons
        crossAxisAlignment: CrossAxisAlignment.start,
        children: iconsImageList,
      ),
    );
  }
}
