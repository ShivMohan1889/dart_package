import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class MsAssessmentImageBox extends StatelessWidget {
  final MemoryImage? image;
  final int index;

  MsAssessmentImageBox({
    this.image,
    required this.index,
  });

  @override
  Widget build(Context context) {
    return Stack(
      children: [
        Container(
          height: 176,
          width: 269,
          decoration: BoxDecoration(
     
            border: Border.all(
              width: 0.5,
              color: PdfColors.black,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: image == null
              ? Container()
              : Center(
                  child: Image(
                    image!,
                  ),
                ),
        ),
      ],
    );
  }
}
