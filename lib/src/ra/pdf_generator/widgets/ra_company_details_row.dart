
import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ra/dto/risk_assessment_dto.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/tb_ra_pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class RaCompanyDetailsRow extends StatelessWidget {
  final RiskAssessmentDto  riskAssessmentEntity;

  RaCompanyDetailsRow({required this.riskAssessmentEntity});

  /// object to fetch pdf styles
  final raPdfTextStyles = TbRaPdfTextStyles();

  @override
  Widget build(Context context) {
    String companyName = riskAssessmentEntity.companyDto?.name ?? "";

    String address1 = riskAssessmentEntity.companyDto?.address1 ?? "";
    String address2 = riskAssessmentEntity.companyDto?.address2 ?? "";
    String postcode = riskAssessmentEntity.companyDto?.postcode ?? "";

    // String companyDetails1 =
    //     [companyName, address1, address2, postcode].join(", ");

    String companyDetails1 = [address1, address2, postcode]
        .where((value) => value.trim().isNotEmpty)
        .join(", ");

    String companyDetials =
        '${returnCompanyName(companyName: companyName)} $companyDetails1';

    String phone = riskAssessmentEntity.companyDto?.phone ?? "";
    String email = riskAssessmentEntity.companyDto?.email ?? "";
    String companyDetails2 = [phone, email].join(" / ");

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
              companyDetials,
              // style: raPdfTextStyles.boldWhite9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.white,
                fontSize: 9,
              ),
            ),
            Text(
              companyDetails2,
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
