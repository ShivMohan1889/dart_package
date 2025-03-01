import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:pdf/widgets.dart';

class MsBorder extends StatelessWidget {
  final double? height;

  MsBorder({
    this.height,
  });
  @override
  Widget build(Context context) {
    return Container(
      width: TbMsPdfWidth.pageWidth,
      height: height ?? 0.5,
      color: TbMsPdfColors.projectDetailsBorderColor,
    );
  }
}
