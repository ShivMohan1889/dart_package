import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ra/tb_ra_pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class SignOffSignature extends StatelessWidget {
  final ReviewSignOffSignatureData user;

  SignOffSignature({
    required this.user,
  });

  final raPdfTextStyles = TbRaPdfTextStyles();

  @override
  Widget build(Context context) {
    return Container(
      // color: PdfColors.amber,x
      // color: PdfColors.amber,
      height: TbRaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
      padding: const EdgeInsets.only(top: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Signature:',
            // style: raPdfTextStyles.boldBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 9,
            ),
          ),
          Expanded(
            child: Container(
              // color: PdfColors.green,
              child: user.signatureMemoryImage != null
                  ? Image(
                      user.signatureMemoryImage!,
                    )
                  : Container(
                      width: 100,
                      height: 40,
                      // color: TbRaPdfColors.lightGreySignatureBgColor,
                      color: PdfColors.white,
                    ),
            ),
          ),
          Row(
            children: [
              Text(
                'Print Name: ',
                // style: raPdfTextStyles.boldBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                user.name,
                // style: raPdfTextStyles.normalBlack8(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  color: TbRaPdfColors.black,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Date: ',
                // style: raPdfTextStyles.boldBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                user.date,
                // style: raPdfTextStyles.normalBlack8(),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  color: TbRaPdfColors.black,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
