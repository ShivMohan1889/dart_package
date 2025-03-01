import 'package:dart_pdf_package/src/ms/ms_pdf_data.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_company_details_row.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_title_row.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import '../../audit/audit_pdf_constants.dart';
import '../tb_ms_pdf_constants.dart';

/// this widget is use to show  header   of the pdf
class MsHeaderRow extends StatelessWidget {
  final MemoryImage? companyLogoMemoryImage;
  final String companyDetails;
  final String companyPhoneEmail;
  final String titleForPdf;

  /// holds the pages number
  final int? pagesNo;

  MsHeaderRow({
    this.pagesNo,
    required this.companyDetails,
    this.companyLogoMemoryImage,
    required this.companyPhoneEmail,
    required this.titleForPdf,
  });

  @override
  Widget build(Context context) {
    return Container(
      color: PdfColors.deepOrange,
      child: Column(
        children: [
          Container(
            width: TbMsPdfWidth.pageWidth,
            color: MsPdfColors.white,
            height: MsPdfHeights.blankSpaceContainerHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget(
                  context: context,
                ),
                companyLogoMemoryImage != null
                    ? Container(
                        // color: RaPdfColors.black,
                        height: 80,
                        width: 80,
                        child: Image(
                          companyLogoMemoryImage!,
                          height: 60,
                          width: 80,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          MsCompanyDetailsRow(
            companyDetails: companyDetails,
            companyPhoneEmail: companyPhoneEmail,
          ),
        ],
      ),
    );
  }

  Widget textWidget({
    required Context context,
  }) {
    return Container(
      padding: MsPdfPaddings.pageHorizontalPadding,
      child: Text(
        titleForPdf,
        // style: raPdfTextStyles.headerTextStyle(),
        style: TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.fontBold,
          color: TbMsPdfColors.black,
          fontSize: 13,
        ),
      ),
    );
  }
}
