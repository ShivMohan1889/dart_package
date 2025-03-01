
import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';
import 'package:pdf/widgets.dart';

import '../../../dart_pdf_package.dart';

class MsAssessmentImageColumn extends StatelessWidget {
  final MemoryImage msAssessmentImage;
  final String? msAssessmentImageIndex;

  MsAssessmentImageColumn({
    required this.msAssessmentImage,
    this.msAssessmentImageIndex,
  });

  @override
  Widget build(Context context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("Image Reference - $msAssessmentImageIndex",
                  // style: msPdfTextStyle.imageReferenceIndexTextStyle(),
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    color: MsPdfColors.msBlueThemeColor,
                    fontSize: 10,
                  )),
            ),
            Container(
              // color: PdfColors.green,
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 25,
              ),
              // color: PdfColors.red,
              height: 550,
              width: 500,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image(
                  msAssessmentImage,
                ),
              ),
            )
          ],
        )
      ],
    );

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(
    //         top: 10,
    //         left: 25,
    //       ),
    //       child: Align(
    //         alignment: Alignment.topLeft,
    //         child: Text(
    //           "Image Reference $msAssessmentImageIndex",
    //           style: msPdfTextStyle.imageReferenceIndexTextStyle(),
    //         ),
    //       ),
    //     ),
    //     Container(
    //       // color: PdfColors.red,
    //       margin:
    //           const EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 100),
    //       height: 550,
    //       child: Align(
    //         alignment: Alignment.topCenter,
    //         child: Image(
    //           msAssessmentImage,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
