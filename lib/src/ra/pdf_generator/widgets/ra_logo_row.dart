import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/ra_pdf_title_type.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class RaLogoRow extends StatelessWidget {
  final MemoryImage? logoImage;

  final RaPdfPageTitleType pageTitleType;

  final int? index;

  RaLogoRow({
    this.logoImage,
    this.index,
    required this.pageTitleType,
  });

  final raPdfTextStyles = TbRaPdfTextStyles();

  @override
  Widget build(Context context) {
    return Container(
      padding: TbRaPdfPaddings.pageHorizontalPadding,
      height: TbRaPdfSectionHeights.LOGO_SECTION,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget(
            context: context,
          ),
          (logoImage != null)
              ? Container(
                  // color: RaPdfColors.black,
                  height: 80,
                  width: 80,
                  child: Image(
                    logoImage!,
                    height: 60,
                    width: 80,
                  ),
                )
              : Container(height: 50, width: 50),
        ],
      ),
    );
  }

  Widget textWidget({
    required Context context,
  }) {
    String title = "RISK ASSESSMENT FORM";

    switch (pageTitleType.index) {
      case 0:
        title = "RISK ASSESSMENT FORM";
        break;
      case 1:
        // title = "RISK ASSESSMENT FORM - Reference Image - ${String.fromCharCode(
        //   96 + (index ?? 0),
        // )}";
        title = "RISK ASSESSMENT FORM - Reference Image - $index";

        break;
      case 2:
        title = "RISK ASSESSMENT FORM - Reference Image - ${String.fromCharCode(
          96 + (index ?? 0),
        )}";
        break;
      case 3:
        title = "RISK ASSESSMENT FORM MAP";
        break;
      default:
    }
    // if (showAlphabetOrNumber == null) {
    //   a = Text(
    //     "RISK ASSESSMENT FORM ",
    //     style: raPdfTextStyles.headerTextStyle(),
    //   );
    // } else if (showAlphabetOrNumber == 1) {
    //   a = Text(
    //     "RISK ASSESSMENT FORM - Reference Image - ${String.fromCharCode(
    //       96 + (index ?? 0),
    //     )}",
    //     style: raPdfTextStyles.headerTextStyle(),
    //   );
    // } else {
    //   a = Text(
    //     "RISK ASSESSMENT FORM - Reference Image - $index",
    //     style: raPdfTextStyles.headerTextStyle(),
    //   );
    // }
    return Text(
      title,
      // style: raPdfTextStyles.headerTextStyle(),
      style: TbPdfHelper().textStyleGenerator(
        font: Theme.of(context).header0.fontBold,
        color: TbRaPdfColors.black,
        fontSize: 13,
      ),
    );
  }
}
