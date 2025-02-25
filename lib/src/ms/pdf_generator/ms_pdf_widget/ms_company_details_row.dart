import 'package:dart_pdf_package/src/ms/pdf_generator/tb_ms_pdf_constants.dart';
import 'package:pdf/widgets.dart';

import '../../../audit/pdf_generator/audit_pdf_constants.dart';
import '../../../utils/pdf/tb_pdf_helper.dart';

class MsCompanyDetailsRow extends StatelessWidget {
  final String? companyDetails;
  final String? companyPhoneEmail;

  MsCompanyDetailsRow({
    this.companyDetails,
    this.companyPhoneEmail,
  });

  final raPdfTextStyles = MsPdfTextStyles();
  @override
  Widget build(Context context) {
    return Container(
      height: TbMsPdfHeights.COMPANY_DETAILS_BAR,
      width: double.infinity,
      color: MsPdfColors.greyCompanyDetailsBackground,
      child: Container(
        padding: MsPdfPaddings.pageHorizontalPadding,
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
