import 'package:dart_pdf_package/src/audit/dto/audit_assessment_dto.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import '../audit_pdf_constants.dart';
import 'audit_title_row.dart';

///this  widget  use to the header section  of audit pdf
class AuditHeaderSection extends StatelessWidget {
  ///holds the auditAssessmentEntity
  final AuditAssessmentDto? auditAssessmentEntity;

  final MemoryImage? companyLogoImage;

  /// holds the page no of the pdf page
  final int? pagesNo;

  AuditHeaderSection({
    this.auditAssessmentEntity,
    this.pagesNo,
    this.companyLogoImage,
  });

  @override
  Widget build(Context context) {
    return Container(
      color: AuditPdfColors.greyCompanyDetailsBackground,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: AuditPdfColors.white,
            height: AuditPdfDimension.headerSectionHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                companyLogoImage != null
                    ? Container(
                        color: PdfColors.red,
                        margin: EdgeInsets.only(right: 20),
                        // color: RaPdfColors.black,
                        height: 80,
                        width: 80,
                        child: Image(
                          companyLogoImage!,
                          height: 60,
                          width: 80,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          AuditTitleRow(
            auditAssessmentEntity: auditAssessmentEntity,
          ),
        ],
      ),
    );
  }
}
