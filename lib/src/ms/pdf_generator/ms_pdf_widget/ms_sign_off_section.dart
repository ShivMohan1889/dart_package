import 'package:dart_pdf_package/src/ms/dto/review_sign_off_dto.dart';
import 'package:pdf/widgets.dart';

import '../../../utils/pdf/tb_pdf_helper.dart';
import '../../dto/ms_assessment_dto.dart';
import '../tb_ms_pdf_constants.dart';

class MsSignOffSection extends StatelessWidget {
  final ReviewSignOffUserDto? user;
  final MemoryImage? signatureImage;
  final String? signOffDate;
  final String localeName;

  MsSignOffSection({
    this.user,
    this.signatureImage,
    this.signOffDate,
    required this.localeName,
  });

  @override
  Widget build(Context context) {
    return Container(
      width: TbMsPdfWidth.pageWidth / 2,
      height: TbMsPdfHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
      padding: TbMsPdfPaddings.paddingForTbMsSignOffSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              child: signatureImage != null
                  ? Image(
                      signatureImage!,
                    )
                  : null,
            ),
          ),
          Row(
            children: [
              Text(
                'Print Name: ',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 9,
                  color: TbMsPdfColors.black,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                "${user?.firstName ?? ""} ${user?.lastName ?? ""}",
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  color: TbMsPdfColors.black,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Date: ',
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 9,
                  color: TbMsPdfColors.black,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                // signOffDate ?? '',
                TbPdfHelper.dateStringForLocaleInPdf(
                    date: signOffDate ?? "", localeName: localeName),

                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  color: TbMsPdfColors.black,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // return Container(
    //   width: MsPdfWidth.pageWidth / 2,
    //   padding: MsPdfPaddings.paddingForMsSignOffSection,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               'Signature:',
    //               // style: msPdfTextStyles.boldBlack10(),
    //               style: TbPdfHelper().textStyleGenerator(
    //                 font: Theme.of(context).header0.fontBold,
    //                 fontSize: 9,
    //                 color: TbMsPdfColors.black,
    //               ),
    //             ),
    //             Container(
    //               width: 60,
    //               height: 10,
    //             ),
    //             checkSignatureImage(signatureImage: signatureImage)
    //           ],
    //         ),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             'Print Name: ',
    //             style: TbPdfHelper().textStyleGenerator(
    //               font: Theme.of(context).header0.fontBold,
    //               fontSize: 9,
    //               color: TbMsPdfColors.black,
    //             ),
    //           ),
    //           SizedBox(width: 10),
    //           Container(
    //             width: 200,
    //             child: Text(
    //               "${user?.firstName ?? ""} ${user?.lastName ?? ""}",
    //               // style: msPdfTextStyles.normalBlack10(),
    //               style: TbPdfHelper().textStyleGenerator(
    //                 font: Theme.of(context).header0.font,
    //                 color: TbMsPdfColors.black,
    //                 fontSize: 9,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(height: 8.0),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             'Date: ',
    //             style: TbPdfHelper().textStyleGenerator(
    //               font: Theme.of(context).header0.fontBold,
    //               fontSize: 9,
    //               color: TbMsPdfColors.black,
    //             ),
    //           ),
    //           SizedBox(width: 10),
    //           Text(
    //             signOffDate ?? '',
    //             style: TbPdfHelper().textStyleGenerator(
    //               font: Theme.of(context).header0.font,
    //               color: TbMsPdfColors.black,
    //               fontSize: 9,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }

  /* ****************** */
  // CHECK SIGNATURE IMAGE
  /// check the given[signatureImage] if it equal to null then return blankContainer
  /* ******************* */
  Widget checkSignatureImage({
    required MemoryImage? signatureImage,
  }) {
    if (signatureImage != null) {
      return Container(
        height: 65,
        width: 70,
        alignment: Alignment.topCenter,
        child: Image(
          signatureImage,
          height: 65,
          width: 65,
        ),
      );
    } else {
      return Container(
        height: 65,
        width: 70,
      );
    }
  }
}
