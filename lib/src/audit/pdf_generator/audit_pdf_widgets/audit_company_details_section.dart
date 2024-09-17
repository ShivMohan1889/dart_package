import 'package:dart_pdf_package/src/audit/dto/audit_assessment_dto.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import '../audit_pdf_constants.dart';

/// this widget is use to show company detials on audit pdf
class AuditCompanyDetailsSection extends StatelessWidget {
  final AuditAssessmentDto? auditAssessmentEntity;

  AuditCompanyDetailsSection({this.auditAssessmentEntity});

  final auditPdfTextStyle = AuditPdfTextStyles();
  @override
  Widget build(Context context) {
    String? userName = auditAssessmentEntity?.userName ?? "";
    String? companyName = auditAssessmentEntity?.companyDto?.name ?? "";
    String address1 = auditAssessmentEntity?.companyDto?.address1 ?? "";
    String address2 = auditAssessmentEntity?.companyDto?.address2 ?? "";
    String countryName = auditAssessmentEntity?.companyDto?.county ?? "";

    String postcode = auditAssessmentEntity?.companyDto?.postcode ?? "";

    String phone = auditAssessmentEntity?.companyDto?.phone ?? "";
    String email = auditAssessmentEntity?.companyDto?.email ?? "";

    return Container(
      height: AuditPdfDimension.auditCompanyDetailsSectionHeight,
      color: PdfColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AuditPdfDimension.pageWidth / 2,
            padding:
                AuditPdfPaddings.companyDetialsSectionFirstContainerPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 5,
                ),
                Container(
                  child: Text(
                    userName,
                    // style: auditPdfTextStyle.auditCompanyUserNameTextStyle(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.fontBold,
                      color: AuditPdfColors.companyDetailsTextColor,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  height: 5,
                ),
                companyName.isNotEmpty
                    ? Container(
                        child: Text(
                          companyName,
                          // style: auditPdfTextStyle.auditCompanyNameTextStyle(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.font,
                            color: AuditPdfColors.companyDetailsTextColor,
                            fontSize: 11,
                          ),
                        ),
                      )
                    : Container(),
                companyName.isNotEmpty
                    ? Container(
                        height: 7,
                      )
                    : Container(),
                address1.isNotEmpty
                    ? Text(
                        address1,
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.font,
                          color: AuditPdfColors.companyDetailsTextColor,
                          fontSize: 11,
                        ),
                      )
                    : Container(),
                address1.isNotEmpty
                    ? Container(
                        height: 7,
                      )
                    : Container(),
                address2.isNotEmpty
                    ? Text(
                        address2,
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.font,
                          color: AuditPdfColors.companyDetailsTextColor,
                          fontSize: 11,
                        ),
                      )
                    : Container(),
                (address2).isNotEmpty
                    ? Container(
                        height: 7,
                      )
                    : Container(),
                countryName.isNotEmpty
                    ? Text(
                        countryName,
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.font,
                          color: AuditPdfColors.companyDetailsTextColor,
                          fontSize: 11,
                        ),
                      )
                    : Container(),
                countryName.isNotEmpty
                    ? Container(
                        height: 7,
                      )
                    : Container(),
                postcode.isNotEmpty
                    ? Text(
                        postcode,
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.font,
                          color: AuditPdfColors.companyDetailsTextColor,
                          fontSize: 11,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            // color: PdfColors.amber,
            width: AuditPdfDimension.pageWidth / 2,

            // // padding:
            //     AuditPdfPaddings.companyDetailsSectionSecondContainerPadding,
            padding: const EdgeInsets.only(
              left: 4,
              top: 7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: RichText(
                    text: TextSpan(
                      text: "T:  ",
                      // style: auditPdfTextStyle.auditCompanyUserNameTextStyle(),
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.fontBold,
                        color: AuditPdfColors.auditTextStyleColor,
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: "$phone\n",
                          // style: auditPdfTextStyle.auditCompanyNameTextStyle(),
                          style: TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.font,
                            color: AuditPdfColors.auditTextStyleColor,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 5,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "E: ",
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.fontBold,
                          color: AuditPdfColors.auditTextStyleColor,
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        width: 5,
                      ),
                      Text(
                        email,
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.font,
                          color: AuditPdfColors.auditTextStyleColor,
                          fontSize: 11,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
