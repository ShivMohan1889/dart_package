import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import '../../../utils/pdf/tb_pdf_helper.dart';
import '../../dto/ms_assessment_dto.dart';
import '../tb_ms_pdf_constants.dart';

class MsReviewSignatureSection extends StatelessWidget {
  // holds the user name
  final String? userName;

  /// holds the user position
  final String? userPosition;

  /// holds the user signature;
  final MemoryImage? userSignature;

  /// holds the review user name;
  final String? reviewUserName;

  /// holds the review user signatureImage;
  final MemoryImage? reviewSignatureImage;

  final String? reviewDate;

  final String? userAssessmentDate;

  final MsAssessmentDto msAssessmentDto;

  final String localeName;

  MsReviewSignatureSection({
    this.userAssessmentDate,
    this.userName,
    this.userSignature,
    this.reviewDate,
    this.reviewUserName,
    this.userPosition,
    this.reviewSignatureImage,
    required this.msAssessmentDto,
    required this.localeName,
  });

  @override
  Widget build(Context context) {
    return Container(
      // margin: MsPdfPaddings.marginForMsReviewSignatureSection,
      padding: TbMsPdfPaddings.rightAndLeftPadding,
      width: TbMsPdfWidth.pageWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          drawUserSignature(context),
          SizedBox(width: 100, height: 20),
          reviewSignature(context),
        ],
      ),
    );
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

  Widget drawUserSignature(Context context) {
    return Container(
      height: 130,
      // height: RaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
      padding: const EdgeInsets.only(top: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Completed by: ',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 9,
                  color: TbMsPdfColors.black,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                userName ?? '',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  fontSize: 9,
                  color: TbMsPdfColors.black,
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
                  color: TbMsPdfColors.black,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                userPosition ?? "",
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                  color: TbMsPdfColors.black,
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
              color: TbMsPdfColors.black,
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
          // Expanded(
          //     child: Container(
          //         // color: PdfColors.green,
          //         child: userSignature != null
          //             ? Image(
          //                 userSignature!,
          //               )
          //             : null)),

          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Date of Assessment: ',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 9,
                  color: TbMsPdfColors.black,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                msAssessmentDto.isSubscribed == 0
                    ? "Upgrade to Unlock"
                    : TbPdfHelper.dateStringForLocaleInPdf(
                        date: userAssessmentDate ?? "", localeName: localeName),
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                  color: TbMsPdfColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget reviewSignature(Context context) {
    if (((reviewUserName ?? "").isNotEmpty ||
        msAssessmentDto.approvalMode == 2)) {
      return Container(
        height: TbMsPdfHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
        padding: const EdgeInsets.only(top: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Reviewed by: ',
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    fontSize: 9,
                    color: TbMsPdfColors.black,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  reviewUserName ?? "",
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    fontSize: 8,
                    color: TbMsPdfColors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                Text(
                  ':',
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    fontSize: 9,
                    color: TbMsPdfColors.white,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  ':',
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    fontSize: 9,
                    color: TbMsPdfColors.white,
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
                color: TbMsPdfColors.black,
              ),
            ),
            Expanded(
                child: Container(
                    // color: PdfColors.green,
                    child: reviewSignatureImage != null
                        ? Image(
                            reviewSignatureImage!,
                          )
                        : null)),
            SizedBox(height: 4.0),
            Row(
              children: [
                Text(
                  'Date of Approval: ',
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    fontSize: 9,
                    color: TbMsPdfColors.black,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  // reviewDate ?? '',
                  TbPdfHelper.dateStringForLocaleInPdf(
                      date: reviewDate ?? "", localeName: localeName),
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    fontSize: 8,
                    color: TbMsPdfColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
