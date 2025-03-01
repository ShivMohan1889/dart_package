import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../audit_pdf_constants.dart';

/// this widget is use to show  section Entity  image on pdf

class AuditSectionImageItem extends StatelessWidget {
  // holds  the audit Section image
  final MemoryImage auditSectionImage;

  AuditSectionImageItem({required this.auditSectionImage});

  @override
  Widget build(Context context) {
    return Container(
      // color: PdfColors.red

      // height: 100,
      // width: 100,

      height: 125,
      width: 118,
      // margin: AuditPdfPaddings.sectionImageItemMargin,
      padding: const EdgeInsets.only(

          // left: 1,
          // right: 1,
          ),
      // padding: AuditPdfPaddings.sectionImageItemPadding,
      decoration: AuditPdfBoxDecorations.auditSectionImageItemBoxDecoration,

      child: Align(
        child: Image(
          auditSectionImage,
          height: 125 - 1,
          width: 118 - 1,
          // fit: BoxFit.fill,
        ),
      ),
    );
  }
}
