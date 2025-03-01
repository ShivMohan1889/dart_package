import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/audit_enum.dart';

import '../audit_pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

/// this widget the Details related to question Entity to question Entity  in a row
class AuditQuestionRow extends StatelessWidget {
  // holds the question entity
  final AuditPdfQuestion? questionEntity;

  final PdfColor? questionColor;
  final auditPdfTextStyle = AuditPdfTextStyles();
  final TbPdfHelper pdfHelper;

  AuditQuestionRow({
    required this.pdfHelper,
    this.questionEntity,
    this.questionColor,
  });

  @override
  Widget build(Context context) {
    return Container(
      // padding: AuditPdfPaddings.questionRowPadding,
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 3,
        left: 20,
        right: 20,
      ),
      color: questionColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AuditPdfDimension.questionWidth - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 20,
                  // width: 15,
                  width: 30,

                  alignment: Alignment.centerLeft,
                  child: Text(
                    questionEntity?.questionNumber != null
                        ? "${questionEntity?.questionNumber}"
                        : "",

                    // style: auditPdfTextStyle.questionNumberTextStyle(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      fontSize: 11,
                      color: AuditPdfColors.black,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Container(
                  width: AuditPdfDimension.questionWidth,
                  child: Text(
                    "${questionEntity?.question}",
                    // style: auditPdfTextStyle.questionNameTextStyle(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: AuditPdfColors.companyDetailsTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: PdfColors.green,
            height: 10,
            width: 20,
          ),
          (questionEntity?.listChainOption ?? []).isEmpty
              ?
              //show only the values of those question entity whose answer type is equal to dateType
              questionEntity?.runtimeType == AnswerType.date
                  ? Container(
                      width: AuditPdfDimension.pageWidth -
                          AuditPdfDimension.questionWidth -
                          20 -
                          20,
                      padding: const EdgeInsets.only(
                        left: 138,
                      ),
                      child: Text(
                        // "${questionEntity?.values}",
                        TbPdfHelper.dateStringForLocaleInPdf(
                          date: questionEntity?.answer ?? "",
                        ),
                        // style: auditPdfTextStyle.questionNameTextStyle(),
                        style: TbPdfHelper().textStyleGenerator(
                          font: Theme.of(context).header0.fontItalic,
                          fontSize: 11,
                          color: AuditPdfColors.companyDetailsTextColor,
                        ),
                      ),
                    )
                  : Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // children: []
                  children: chainOptionWidget(
                    context,
                    AuditPdfDimension.pageWidth -
                        AuditPdfDimension.questionWidth -
                        20 -
                        20,
                  ),
                ),
        ],
      ),
    );
  }

  /* ****************** */
  // CHAIN OPTION WIDGET
  ///  this method return the list of widget that contain chainoptions
  /* *************** */

  List<Widget> chainOptionWidget(
    Context context,
    double width,
  ) {
    List<Widget> list = [];

    var options = questionEntity?.listChainOption ?? [];
    int totalOption = 5;
    for (int i = 0; i < 5; i++) {
      int index = totalOption - options.length;
      Image? image;
      if (i >= index) {
        int currentIndex = i - index;

        if (questionEntity?.answer == options[currentIndex]) {
          image = Image(pdfHelper.auditCheckImage, height: 17, width: 17);
        } else {
          image = Image(pdfHelper.aduitUncheckImage, height: 17, width: 17);
        }
      }

      Widget widget = Container(
        width: width / totalOption,
        child: Center(child: image),
      );

      list.add(widget);
    }
    return list;
  }

  Widget returnSpace() {
    if ((questionEntity?.questionNumber ?? "").contains(".")) {
      return Container(
        width: 5,
      );
    } else {
      return Container();
    }
  }
}
