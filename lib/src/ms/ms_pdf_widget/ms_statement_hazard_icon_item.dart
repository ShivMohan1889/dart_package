import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class MsStatementHazardIconItem extends StatelessWidget {
  final MemoryImage iconImage;
  final String? iconText;

  MsStatementHazardIconItem({
    required this.iconImage,
    this.iconText,
  });

  @override
  Widget build(Context context) {
    // Calculate the actual width based on the container
    double containerWidth =
        (TbMsPdfWidth.pageWidth - 90) / 6; // Account for margins and spacing
    print("Image Height:${iconImage.height}");
    print("Image Width:${iconImage.width}");
    print(iconText);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: PdfColors.grey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      width: containerWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image container
          Container(
            // color: PdfColors.red,
            // height: 70,
            height: 80,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: Image(
              iconImage,
              height: 70, // Slightly reduce height
              width: containerWidth - 10, // Account for padding
              fit: BoxFit.contain,
            ),
          ),

          // Text container with dark gray background
          if ((iconText ?? "").isNotEmpty)
            Container(
              width: double.infinity,
              height: 30,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                  color: PdfColors.grey600,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  )),
              child: Text(
                iconText!,
                // "Technology continues to evolve rapidly",
                textAlign: TextAlign.center,
                // style: TbPdfHelper().textStyleGenerator(
                //   font: Theme.of(context).header0.fontBold,
                //   color: TbMsPdfColors.white,
                //   fontSize: 12,
                // ),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontNormal,
                  color: TbMsPdfColors.white,
                  fontSize: 7,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
