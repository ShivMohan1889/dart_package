import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_border.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../utils/pdf/tb_pdf_helper.dart';
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

  final int? approvalMode;

  MsReviewSignatureSection({
    this.userAssessmentDate,
    this.userName,
    this.userSignature,
    this.reviewDate,
    this.reviewUserName,
    this.userPosition,
    this.reviewSignatureImage,
    this.approvalMode,
  });

  @override
  Widget build(Context context) {
    String heading = "CREATED BY:";
    String subHeading = "Person who created the assessment";

    if ((reviewUserName ?? "").isNotEmpty || approvalMode == 2) {
      heading = "CREATED & REVIEWED BY:";
      subHeading = "Person created & reviewed the assessment";
    }

    return Wrap(
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
      children: [
        Container(
          width: TbMsPdfWidth.pageWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: 15),
              // MsBorder(),
              Container(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Title in bold
                    Text(
                      heading,
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.fontBold,
                        color: TbMsPdfColors.black,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Sign-off statement

                    Text(
                      subHeading,
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.fontNormal,
                        color: TbMsPdfColors.black,
                        fontSize: 9,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding:
                    TbMsPdfPaddings.rightAndLeftPadding.copyWith(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User signature section with grey background
                    Container(
                      width: TbMsPdfWidth.pageWidth / 2 - 25,
                      decoration: BoxDecoration(
                        color: TbMsPdfColors.lightGreyBackground,
                        border:
                            Border.all(width: 0.5, color: PdfColors.grey300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: drawUserSignature(context),
                    ),

                    // // Spacing between signature sections
                    // SizedBox(width: 40),

                    // Review signature section with grey background
                    if ((reviewUserName ?? "").isNotEmpty || approvalMode == 2)
                      Container(
                        width: TbMsPdfWidth.pageWidth / 2 - 25,
                        decoration: BoxDecoration(
                          color: TbMsPdfColors.lightGreyBackground,
                          border:
                              Border.all(width: 0.5, color: PdfColors.grey300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: reviewSignature(context),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget drawUserSignature(Context context) {
    return Container(
      height: 130,
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

          // Signature image or empty container with white background
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 5),
          //   height: 60,
          //   width: 80,
          //   // decoration: BoxDecoration(
          //   //   color: PdfColors.white,
          //   //   border: Border.all(
          //   //     width: 0.5,
          //   //     color: PdfColors.grey200,
          //   //   ),
          //   // ),
          //   child: userSignature != null
          //       ? Image(
          //           userSignature!,
          //           height: 60,
          //           width: 80,
          //         )
          //       : null,
          // ),

          Expanded(
            child: Container(
              // padding: EdgeInsets.all(5),
              padding: EdgeInsets.only(
                top: 10,
                right: 20,
              ),
              color: TbMsPdfColors.lightGreyBackground,
              alignment: Alignment.centerLeft,
              child: userSignature != null
                  ? Image(
                      userSignature!,
                      fit: BoxFit.contain,
                    )
                  : Container(),
            ),
          ),

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
                userAssessmentDate ?? "",
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
    return Container(
      height: 130,
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
          // Hidden spacer with white text
          Text(
            'Position placeholder',
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              fontSize: 9,
              color:
                  TbMsPdfColors.lightGreyBackground, // Match background to hide
            ),
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
          // Signature image or empty container with white background
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 5),
          //   height: 60,
          //   width: 80,
          //   // decoration: BoxDecoration(
          //   //   color: PdfColors.white,
          //   //   border: Border.all(width: 0.5, color: PdfColors.grey200,

          //   //   ),
          //   // ),
          //   child: reviewSignatureImage != null
          //       ? Image(
          //           reviewSignatureImage!,
          //           height: 60,
          //           width: 80,
          //         )
          //       : null,
          // ),

          Expanded(
            child: Container(
              color: TbMsPdfColors.lightGreyBackground,
              padding: EdgeInsets.only(
                top: 10,
                right: 20,
              ),
              alignment: Alignment.centerLeft,
              child: reviewSignatureImage != null
                  ? Image(
                      reviewSignatureImage!,
                      fit: BoxFit.contain,
                    )
                  : Container(),
            ),
          ),
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
                reviewDate ?? "",
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
}


// class MsReviewSignatureSection extends StatelessWidget {
//   // holds the user name
//   final String? userName;

//   /// holds the user position
//   final String? userPosition;

//   /// holds the user signature;
//   final MemoryImage? userSignature;

//   /// holds the review user name;
//   final String? reviewUserName;

//   /// holds the review user signatureImage;
//   final MemoryImage? reviewSignatureImage;

//   final String? reviewDate;

//   final String? userAssessmentDate;

//   final int? approvalMode;

//   MsReviewSignatureSection({
//     this.userAssessmentDate,
//     this.userName,
//     this.userSignature,
//     this.reviewDate,
//     this.reviewUserName,
//     this.userPosition,
//     this.reviewSignatureImage,
//     this.approvalMode,
//   });

//   @override
//   Widget build(Context context) {
//     return Container(
//       // margin: MsPdfPaddings.marginForMsReviewSignatureSection,
//       padding: TbMsPdfPaddings.rightAndLeftPadding,
//       width: TbMsPdfWidth.pageWidth,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           drawUserSignature(context),
//           SizedBox(width: 100, height: 20),
//           reviewSignature(context),
//         ],
//       ),
//     );
//   }

//   // Widget displaySignatureImage({
//   //   required MemoryImage? signatureImage,
//   // }) {
//   //   if (signatureImage != null) {
//   //     return Container(
//   //       height: 65,
//   //       width: 70,
//   //       alignment: Alignment.topCenter,
//   //       child: Image(
//   //         signatureImage,
//   //         height: 65,
//   //         width: 65,
//   //       ),
//   //     );
//   //   } else {
//   //     return Container(
//   //       height: 65,
//   //       width: 70,
//   //     );
//   //   }
//   // }

//   Widget drawUserSignature(Context context) {
//     return Container(
//       height: 130,
//       // height: RaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
//       padding: const EdgeInsets.only(top: 9),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Completed by: ',
//                 style: TbPdfHelper().textStyleGenerator(
//                   font: Theme.of(context).header0.fontBold,
//                   fontSize: 9,
//                   color: TbMsPdfColors.black,
//                 ),
//               ),
//               SizedBox(width: 5.0),
//               Text(
//                 userName ?? '',
//                 style: TbPdfHelper().textStyleGenerator(
//                   font: Theme.of(context).header0.font,
//                   fontSize: 9,
//                   color: TbMsPdfColors.black,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 4.0),
//           Row(
//             children: [
//               Text(
//                 'Position:',
//                 style: TbPdfHelper().textStyleGenerator(
//                   font: Theme.of(context).header0.fontBold,
//                   fontSize: 9,
//                   color: TbMsPdfColors.black,
//                 ),
//               ),
//               SizedBox(width: 5.0),
//               Text(
//                 userPosition ?? "",
//                 style: TbPdfHelper().textStyleGenerator(
//                   font: Theme.of(context).header0.font,
//                   fontSize: 8,
//                   color: TbMsPdfColors.black,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 4.0),
//           Text(
//             'Signature:',
//             style: TbPdfHelper().textStyleGenerator(
//               font: Theme.of(context).header0.fontBold,
//               fontSize: 9,
//               color: TbMsPdfColors.black,
//             ),
//           ),
//           userSignature != null
//               ? Container(
//                   margin: const EdgeInsets.only(
//                     top: 5,
//                   ),
//                   height: 80,
//                   width: 80,
//                   child: Image(
//                     userSignature!,
//                     height: 60,
//                     width: 80,
//                   ))
//               : Container(),
//           SizedBox(height: 4.0),
//           Row(
//             children: [
//               Text(
//                 'Date of Assessment: ',
//                 style: TbPdfHelper().textStyleGenerator(
//                   font: Theme.of(context).header0.fontBold,
//                   fontSize: 9,
//                   color: TbMsPdfColors.black,
//                 ),
//               ),
//               SizedBox(width: 5.0),
//               Text(
//                 userAssessmentDate ?? "",
//                 style: TbPdfHelper().textStyleGenerator(
//                   font: Theme.of(context).header0.font,
//                   fontSize: 8,
//                   color: TbMsPdfColors.black,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget reviewSignature(Context context) {
//     if (((reviewUserName ?? "").isNotEmpty || approvalMode == 2)) {
//       return Container(
//         height: TbMsPdfHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
//         padding: const EdgeInsets.only(top: 9),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Reviewed by: ',
//                   style: TbPdfHelper().textStyleGenerator(
//                     font: Theme.of(context).header0.fontBold,
//                     fontSize: 9,
//                     color: TbMsPdfColors.black,
//                   ),
//                 ),
//                 SizedBox(width: 5.0),
//                 Text(
//                   reviewUserName ?? "",
//                   style: TbPdfHelper().textStyleGenerator(
//                     font: Theme.of(context).header0.font,
//                     fontSize: 8,
//                     color: TbMsPdfColors.black,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 4.0),
//             Row(
//               children: [
//                 Text(
//                   ':',
//                   style: TbPdfHelper().textStyleGenerator(
//                     font: Theme.of(context).header0.fontBold,
//                     fontSize: 9,
//                     color: TbMsPdfColors.white,
//                   ),
//                 ),
//                 SizedBox(width: 5.0),
//                 Text(
//                   ':',
//                   style: TbPdfHelper().textStyleGenerator(
//                     font: Theme.of(context).header0.fontBold,
//                     fontSize: 9,
//                     color: TbMsPdfColors.white,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 4.0),
//             Text(
//               'Signature:',
//               style: TbPdfHelper().textStyleGenerator(
//                 font: Theme.of(context).header0.fontBold,
//                 fontSize: 9,
//                 color: TbMsPdfColors.black,
//               ),
//             ),
//             Expanded(
//                 child: Container(
//                     // color: PdfColors.green,
//                     child: reviewSignatureImage != null
//                         ? Image(
//                             reviewSignatureImage!,
//                           )
//                         : null)),
//             SizedBox(height: 4.0),
//             Row(
//               children: [
//                 Text(
//                   'Date of Approval: ',
//                   style: TbPdfHelper().textStyleGenerator(
//                     font: Theme.of(context).header0.fontBold,
//                     fontSize: 9,
//                     color: TbMsPdfColors.black,
//                   ),
//                 ),
//                 SizedBox(width: 5.0),
//                 Text(
//                   reviewDate ?? "",
//                   style: TbPdfHelper().textStyleGenerator(
//                     font: Theme.of(context).header0.font,
//                     fontSize: 8,
//                     color: TbMsPdfColors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }
