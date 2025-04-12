import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:pdf/widgets.dart';

import '../../audit/audit_pdf_constants.dart';
import '../../utils/pdf/tb_pdf_helper.dart';

class MsCompanyDetailsRow extends StatelessWidget {
  final String? companyDetails;
  final String? companyPhoneEmail;
  final EdgeInsets? horizontalPadding;

  MsCompanyDetailsRow({
    this.companyDetails,
    this.companyPhoneEmail,
    this.horizontalPadding,
  });

  final raPdfTextStyles = MsPdfTextStyles();
  @override
  Widget build(Context context) {
    return Container(
      height: TbMsPdfHeights.COMPANY_DETAILS_BAR,
      width: double.infinity,
      color: MsPdfColors.greyCompanyDetailsBackground,
      child: Container(
        padding: horizontalPadding ?? MsPdfPaddings.pageHorizontalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              companyDetails ?? "",
              // style: raPdfTextStyles.boldWhite9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: MsPdfColors.white,
                fontSize: 9,
              ),
            ),
            Text(
              companyPhoneEmail ?? "",
              // style: raPdfTextStyles.boldWhite9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: MsPdfColors.white,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
