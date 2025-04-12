import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_company_details_row.dart';
import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

/// this widget is use to show  header   of the pdf
class IrHeaderRow extends StatelessWidget {
  final MemoryImage? companyLogoMemoryImage;
  final String companyDetails;
  final String companyPhoneEmail;
  final String titleForPdf;
  final EdgeInsets? paddingForHorizontal;

  /// holds the pages number
  final int? pagesNo;

  IrHeaderRow({
    this.pagesNo,
    required this.companyDetails,
    this.companyLogoMemoryImage,
    required this.companyPhoneEmail,
    required this.titleForPdf,
    this.paddingForHorizontal,
  });

  @override
  Widget build(Context context) {
    return Container(
      // color: PdfColors.amber,
      // padding: EdgeInsets.only(
      //   bottom: 10,
      // ),
      child: Column(
        children: [
          Container(
            width: TbIrPdfDimension.pageWidth,
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
            horizontalPadding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
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
