import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

// this widget is used  show to the list of section image in row in audit pdf
class AuditSectionImageRow extends StatelessWidget {
  // for showing section image path
  List<Widget> listSectionImage;

  AuditSectionImageRow({
    required this.listSectionImage,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
         top: 5,
        bottom: 5,
      ),
      // padding: AuditPdfPaddings.auditSectionImageRowPadding,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: listSectionImage,
        ),
      ),
    );
  }
}
