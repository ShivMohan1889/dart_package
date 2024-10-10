import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIrSpaceBox extends StatelessWidget {
  double? height;
  PdfColor? color;
  TbIrSpaceBox({this.height, this.color});

  @override
  Widget build(Context context) {
    return Container(
      height: height,
      // color:  color,
      // color: PdfColors.amber,
    );
  }
}
