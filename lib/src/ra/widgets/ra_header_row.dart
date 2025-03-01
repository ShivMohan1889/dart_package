import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ra/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/ra/widgets/hazard_heading_row.dart';
import 'package:dart_pdf_package/src/ra/widgets/ra_company_details_row.dart';
import 'package:dart_pdf_package/src/ra/widgets/ra_logo_row.dart';
import 'package:dart_pdf_package/src/ra/widgets/ra_project_row.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/ra_pdf_title_type.dart';
import 'package:pdf/widgets.dart';

/// creates the header for the pdf, depending on the [pageNo]
class RaHeaderRow extends StatelessWidget {
  final RaPdfData raPdfData;
  final int? pageNo;
  final TbPdfHelper pdfHelper;
  final bool? headerForSignOff;

  RaHeaderRow({
    required this.raPdfData,
    required this.pageNo,
    required this.pdfHelper,
    this.headerForSignOff,
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
              logoImage: raPdfData.companyLogoMemoryImage),
          RaCompanyDetailsRow(
            companyDetails: raPdfData.companyDetails,
            companyPhoneEmail: raPdfData.companyPhoneEmail,
          ),
          pageNo == 1
              ? RaProjectRow(
                  pdfData: raPdfData,
                  pdfHelper: pdfHelper,
                )
              : Container(),
          pageNo == 1
              ? HazardHeadingRow(
                  isStandard: raPdfData.assessmentType,
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                  ),
                  child: HazardHeadingRow(
                    isStandard: raPdfData.assessmentType,
                  ),
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
        12;
    return Container(
      height: height,
      width: double.infinity,
      child: Column(
        children: [
          RaLogoRow(
              pageTitleType: RaPdfPageTitleType.normal,
              logoImage: raPdfData.companyLogoMemoryImage),
          RaCompanyDetailsRow(
            companyDetails: raPdfData.companyDetails,
            companyPhoneEmail: raPdfData.companyPhoneEmail,
          ),
        ],
      ),
    );
  }
}
