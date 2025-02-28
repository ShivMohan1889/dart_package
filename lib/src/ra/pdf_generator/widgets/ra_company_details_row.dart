import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/tb_ra_pdf_constants.dart';
import 'package:pdf/widgets.dart';

class RaCompanyDetailsRow extends StatelessWidget {
  final String companyDetails;
  final String companyPhoneEmail;
  RaCompanyDetailsRow({
    required this.companyDetails,
    required this.companyPhoneEmail,
  });

  /// object to fetch pdf styles
  final raPdfTextStyles = TbRaPdfTextStyles();

  @override
  Widget build(Context context) {
    return Container(
      height: TbRaPdfSectionHeights.COMPANY_DETAILS_BAR,
      width: double.infinity,
      color: TbRaPdfColors.greyCompanyDetailsBackground,
      child: Container(
        padding: TbRaPdfPaddings.pageHorizontalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              companyDetails,
              // style: raPdfTextStyles.boldWhite9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.white,
                fontSize: 9,
              ),
            ),
            Text(
              companyPhoneEmail,
              // style: raPdfTextStyles.boldWhite9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.white,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String returnCompanyName({
    String? companyName,
  }) {
    if ((companyName ?? "").isEmpty) {
      return "";
    } else {
      return '$companyName,';
    }
  }
}
