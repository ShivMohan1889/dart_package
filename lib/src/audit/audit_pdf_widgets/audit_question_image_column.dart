import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';

import '../audit_pdf_constants.dart';

import 'package:pdf/widgets.dart';

// this widget is use to show  audit image entity in pdf
class AuditQuestionImageColumn extends StatelessWidget {
  // holds the memory image audit image entity
  final MemoryImage? auditAssessmentImage;
  // holds given index of  audit image entity from the list of listAuditImage
  final String? auditAssessmentImageIndex;

  AuditQuestionImageColumn({
    required this.auditAssessmentImage,
    this.auditAssessmentImageIndex,
  });

  @override
  Widget build(Context context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AuditPdfDimension.pageWidth,
            // padding: AuditPdfPaddings.pageHorizontalPadding,
            padding: AuditPdfPaddings.righLeftPadding,
            // alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 10,
                  height: 30,
                ),
                Container(
                  child: Text(
                    "Image Reference - $auditAssessmentImageIndex",
                    // style: auditPdfTextStyle.auditSectionTitleTextStyle(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.fontBold,
                      fontSize: 12,

                      // color: PdfColors.black,
                      color: AuditPdfColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Container(height: 30),
                Container(
                  height: 20,
                ),

                Align(
                    alignment: Alignment.center,
                    child: ((auditAssessmentImage?.height ?? 0) >= 300 ||
                            (auditAssessmentImage?.width ?? 0) >= 300)
                        ? Container(
                            // margin: const EdgeInsets.only(
                            //   left: 10,
                            // ),
                            // margin: AuditPdfPaddings.auditAssessmentImagePadding,
                            alignment: Alignment.topCenter,
                            // height: AuditPdfDimension.auditAssessmentImageHeight,
                            // height: 450,
                            // // height: 300,
                            height: 550,
                            width: 500,
                            // width:  ,
                            child: Image(
                              auditAssessmentImage!,
                            ),
                          )
                        : Container(
                            // margin: const EdgeInsets.only(
                            //   left: 10,
                            // ),
                            // margin: AuditPdfPaddings.auditAssessmentImagePadding,
                            alignment: Alignment.topCenter,
                            // height: AuditPdfDimension.auditAssessmentImageHeight,
                            // height: 450,
                            // // height: 300,

                            // width:  ,
                            child: Image(
                              auditAssessmentImage!,
                            ),
                          )),
                Container(
                  height: 40,
                ),

                ((auditAssessmentImage?.height ?? 0) >= 300 ||
                        (auditAssessmentImage?.width ?? 0) >= 300)
                    ? Container()
                    : Container(
                        height: 150,
                        // color: PdfColors.red,
                      )
              ],
            ),
          ),
        ]);
  }
}
