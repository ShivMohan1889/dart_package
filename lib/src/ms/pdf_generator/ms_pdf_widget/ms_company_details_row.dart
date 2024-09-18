import 'package:dart_pdf_package/src/ms/dto/ms_assessment_dto.dart';
import 'package:pdf/widgets.dart';

import '../../../audit/pdf_generator/audit_pdf_constants.dart';
import '../../../utils/pdf/tb_pdf_helper.dart';

class MsCompanyDetailsRow extends StatelessWidget {
  final MsAssessmentDto? msAssessmentDto;

  MsCompanyDetailsRow({this.msAssessmentDto});

  @override
  Widget build(Context context) {
    String? userName = msAssessmentDto?.user ?? "";
    String? companyName = msAssessmentDto?.companyDto?.name ?? "";
    String address1 = msAssessmentDto?.companyDto?.address1 ?? "";
    String address2 = msAssessmentDto?.companyDto?.address2 ?? "";
    String countryName = msAssessmentDto?.companyDto?.county ?? "";

    String postcode = msAssessmentDto?.companyDto?.postcode ?? "";

    String phone = msAssessmentDto?.companyDto?.phone ?? "";
    String email = msAssessmentDto?.companyDto?.email ?? "";

    return Container(
      decoration: MsPdfBoxDecorations.boxDecorationForCompanyRow,
      height: 98,
      padding: const EdgeInsets.only(
        bottom: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            width: MsPdfWidth.pageWidth / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 6,
                ),
                Text(
                  userName,
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    fontSize: 10,
                    color: MsPdfColors.companyDetailsTextColor,
                  ),
                ),
                Container(
                  height: 2,
                ),
                Text(
                  companyName,
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    color: MsPdfColors.companyDetailsTextColor,
                    fontSize: 10,
                  ),
                ),
                Container(
                  height: 2,
                ),
                Text(address1,
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: MsPdfColors.companyDetailsTextColor,
                      fontSize: 10,
                    )),
                Container(
                  height: 2,
                ),
                Text(address2,
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: MsPdfColors.companyDetailsTextColor,
                      fontSize: 10,
                    )),
                Container(
                  height: 2,
                ),
                Text(countryName,
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: MsPdfColors.companyDetailsTextColor,
                      fontSize: 10,
                    )),
                Container(
                  height: 2,
                ),
                Text(
                  postcode,
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    color: MsPdfColors.companyDetailsTextColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MsPdfWidth.pageWidth / 2,
            padding: const EdgeInsets.only(
              top: 7,
              left: 5,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "T:  ",
                    style: TbPdfHelper().textStyleGenerator(
                      color: MsPdfColors.companyDetailsTextColor,
                      fontSize: 10,
                      font: Theme.of(context).header0.fontBold,
                    ),
                    children: [
                      TextSpan(
                        text: "$phone\n",
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.font,
                          color: MsPdfColors.companyDetailsTextColor,
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: "E:  ",
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.fontBold,
                          color: MsPdfColors.companyDetailsTextColor,
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: email,
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.font,
                          color: MsPdfColors.companyDetailsTextColor,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
