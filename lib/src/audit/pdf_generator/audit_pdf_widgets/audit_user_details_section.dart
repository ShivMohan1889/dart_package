import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/widgets.dart';

import '../audit_pdf_constants.dart';

class AuditUserDetailsSection extends StatelessWidget {
  final String? userName;

  final String? userPosition;
  final String? userAssessmentDate;
  final auditPdfTextStyle = AuditPdfTextStyles();
  final MemoryImage? userSignature;
  final String localeName;

  AuditUserDetailsSection({
    this.userName,
    this.userPosition,
    this.userAssessmentDate,
    this.userSignature,
    required this.localeName,
  });
  @override
  Widget build(Context context) {
    return Row(children: [
      Container(
        width: MsPdfWidth.pageWidth / 2,
        height: 130,
        // height: RaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
        // height: 250,
        padding: MsPdfPaddings.paddingForMsSignOffSection,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                'Completed by: ',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 9,
                  color: MsPdfColors.black,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                userName ?? '',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  fontSize: 9,
                  color: MsPdfColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Position:',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 9,
                  color: MsPdfColors.black,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                userPosition ?? "",
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                  color: MsPdfColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            'Signature:',
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              fontSize: 9,
              color: MsPdfColors.black,
            ),
          ),
          userSignature != null
              ? Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  height: 80,
                  width: 80,
                  child: Image(
                    userSignature!,
                    height: 60,
                    width: 80,
                  ))
              : Container(),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Date of Assessment: ',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 9,
                  color: MsPdfColors.black,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                // "$userAssessmentDate",

                TbPdfHelper.dateStringForLocaleInPdf(
                  date: userAssessmentDate ?? "",
                  localeName: localeName,
                ),

                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                  color: MsPdfColors.black,
                ),
              ),
            ],
          ),
        ]),
      )
    ]);
  }

  // Widget displaySignatureImage({
  //   required MemoryImage? signatureImage,
  // }) {
  //   if (signatureImage != null) {
  //     return Container(
  //       height: 65,
  //       width: 70,
  //       alignment: Alignment.topCenter,
  //       child: Image(
  //         signatureImage,
  //         height: 65,
  //         width: 65,
  //       ),
  //     );
  //   } else {
  //     return Container(
  //       height: 65,
  //       width: 70,
  //     );
  //   }
  // }
}
