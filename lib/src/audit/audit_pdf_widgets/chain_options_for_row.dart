import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

/// this widget is use to show  the row  that  contains name of chainOptions
class ChainOptionsForPdfRow extends StatelessWidget {
  final List<String>? chainOptionsForPdf;

  final auditTextStyle = AuditPdfTextStyles();

  ChainOptionsForPdfRow({
    this.chainOptionsForPdf,
  });
  @override
  Widget build(Context context) {
    return Container(
      // padding: AuditPdfPaddings.chainOptionRowPaddng,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: AuditPdfDimension.questionWidth - 20,
            height: 10,
          ),
          Container(
            // color: PdfColors.red,
            width: 20,
            height: 10,
          ),
          Container(
            // color: PdfColors.blue,
            // width: AuditPdfDimension.pageWidth -
            //     AuditPdfDimension.questionWidth -
            //     20 -
            //     20,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: chainOptionWidget(
                context,
                AuditPdfDimension.pageWidth -
                    AuditPdfDimension.questionWidth -
                    20 -
                    20,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> chainOptionWidget(Context context, double width) {
    List<Widget> list = [];
    var options = chainOptionsForPdf ?? [];
    int totalOption = 5;
    for (int i = 0; i < 5; i++) {
      int index = totalOption - options.length;
      String text = "";
      if (i >= index) {
        int currentIndex = i - index;
        text = options[currentIndex];
      }
      Widget widget = Container(
        width: width / 5,
        padding: const EdgeInsets.all(
          5,
        ),
        child: Text(
            tightBounds: true,
            textAlign: TextAlign.center,
            text,
            // style: auditTextStyle.auditChainOptionTextStyle(),
            // style: PdfHelper().textStyleGenerator(
            //   font: Theme.of(context).header0.fontBoldItalic,
            //   color: AuditPdfColors.black,
            //   fontSize: 8,
            // ),
            style: TextStyle(
              font: Theme.of(context).header0.fontBoldItalic,
              color: AuditPdfColors.black,
              fontSize: 8.3,
              // letterSpacing: 1.2,
              lineSpacing: 1.6,
            )),
      );
      list.add(widget);
    }

    return list;
  }
}
