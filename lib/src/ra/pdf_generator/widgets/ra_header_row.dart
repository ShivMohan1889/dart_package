

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ra/dto/risk_assessment_dto.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/widgets/hazard_heading_row.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/widgets/ra_company_details_row.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/widgets/ra_logo_row.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/widgets/ra_project_row.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/ra_pdf_title_type.dart';
import 'package:pdf/widgets.dart';

/// creates the header for the pdf, depending on the [pageNo]
class RaHeaderRow extends StatelessWidget {
  final RiskAssessmentDto riskAssessmentEntity;
  final int? pageNo;
  final MemoryImage? logoImage;
  final TbPdfHelper pdfHelper;
  final bool? headerForSignOff;
  final String localeName;

  RaHeaderRow({
    required this.riskAssessmentEntity,
    required this.pageNo,
    this.logoImage,
    this.headerForSignOff,
    required this.pdfHelper,
    required this.localeName,
  });

  @override
  Widget build(Context context) {
    if (headerForSignOff == true) {
      return signOffHeader();
    } else {
      return header();
    }
  }

  /* ************************************** */
  // HEADER

  /// header for all the pages other than Sign Off
  /* ************************************** */
  Widget header() {
    var height = pageNo == 1
        ? TbRaPdfSectionHeights.LOGO_SECTION +
            TbRaPdfSectionHeights.COMPANY_DETAILS_BAR +
            TbRaPdfSectionHeights.PROJECT_DETAILS +
            TbRaPdfSectionHeights.HAZARD_HEADING +
            12
        : TbRaPdfSectionHeights.LOGO_SECTION +
            TbRaPdfSectionHeights.COMPANY_DETAILS_BAR +
            TbRaPdfSectionHeights.HAZARD_HEADING +
            6;

    return Container(
      height: height,
      width: double.infinity,
      child: Column(
        children: [
          RaLogoRow(
              pageTitleType: RaPdfPageTitleType.normal,
              riskAssessmentEntity: riskAssessmentEntity,
              logoImage: logoImage),
          RaCompanyDetailsRow(riskAssessmentEntity: riskAssessmentEntity),
          pageNo == 1
              ? RaProjectRow(
                  localeName: localeName,
                  riskAssessmentEntity: riskAssessmentEntity,
                  pdfHelper: pdfHelper,
                )
              : Container(),
          pageNo == 1
              ? HazardHeadingRow(
                  isStandard: riskAssessmentEntity.assessmentType ?? 0)
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                  ),
                  child: HazardHeadingRow(
                      isStandard: riskAssessmentEntity.assessmentType ?? 0),
                )
        ],
      ),
    );
  }

  /* ************************************** */
  // HEADER FOR SIGN OFF PAGE
  /* ************************************** */
  Widget signOffHeader() {
    var height = TbRaPdfSectionHeights.LOGO_SECTION +
        TbRaPdfSectionHeights.COMPANY_DETAILS_BAR +
        TbRaPdfSectionHeights.PROJECT_DETAILS +
        12;
    return Container(
      height: height,
      width: double.infinity,
      child: Column(
        children: [
          RaLogoRow(
              pageTitleType: RaPdfPageTitleType.normal,
              riskAssessmentEntity: riskAssessmentEntity,
              logoImage: logoImage),
          RaCompanyDetailsRow(riskAssessmentEntity: riskAssessmentEntity),
          RaProjectRow(
              localeName: localeName,
              riskAssessmentEntity: riskAssessmentEntity,
              pdfHelper: pdfHelper)
        ],
      ),
    );
  }
}
