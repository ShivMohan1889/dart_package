import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class MsAssessmentImageRow extends StatelessWidget {
  final List<Widget> listChildren;

  MsAssessmentImageRow({
    required this.listChildren,
  });

  @override
  Widget build(Context context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10,
            // bottom: 10,
          ),
          // color: PdfColors.amber,
          // padding: MsPdfPaddings.paddingForMsHeaderEntityHeaderLevelNotZero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: listChildren,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
