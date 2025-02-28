import 'package:dart_pdf_package/src/ra/pdf_generator/ra_pdf_data.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/widgets/ra_company_details_row.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/widgets/ra_logo_row.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/ra_pdf_title_type.dart';
import 'package:pdf/widgets.dart';

/// creates the header for the pdf, depending on the [pageNo]
class RaMapHeaderRow extends StatelessWidget {
  final raPdfTextStyles = TbRaPdfTextStyles();
  final RaPdfData pdfData;
  final MemoryImage? logoImage;

  RaMapHeaderRow({
    required this.pdfData,
    this.logoImage,
  });

  @override
  Widget build(Context context) {
    return header();
  }

  /* ************************************** */
  // HEADER

  /// header for all the pages other than Sign Off
  /* ************************************** */
  Widget header() {
    var height = TbRaPdfSectionHeights.LOGO_SECTION +
        TbRaPdfSectionHeights.COMPANY_DETAILS_BAR;

    return Container(
      height: height,
      width: double.infinity,
      child: Column(
        children: [
          RaLogoRow(
            pageTitleType: RaPdfPageTitleType.mapImage,
            logoImage: logoImage,
          ),
          RaCompanyDetailsRow(
            companyDetails: pdfData.companyDetails,
            companyPhoneEmail: pdfData.companyPhoneEmail,
          ),
        ],
      ),
    );
  }
}
