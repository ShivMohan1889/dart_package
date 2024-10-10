import 'package:dart_pdf_package/src/ra/dto/review_sign_off_user_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/risk_assessment_dto.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/review_sign_off_mode.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../utils/enums/enum/review_sign_off_user_type.dart';

class RaFooterRow extends StatelessWidget {
  final int? pageNo;
  final MemoryImage? signatureImage;
  final MemoryImage? reviewImage;
  final bool? isSignOffFooter;

  final String localeName;

  /// risk assessment for which we need to create pdf
  final RiskAssessmentDto riskAssessmentEntity;

  RaFooterRow({
    required this.pageNo,
    required this.riskAssessmentEntity,
    this.signatureImage,
    this.reviewImage,
    required this.isSignOffFooter,
    required this.localeName,
  });

  /// object to fetch pdf styles
  final raPdfTextStyles = TbRaPdfTextStyles();

  /// height of the scorebox
  final double scoreBoxSize = 13;

  /// space between scorebox and text
  final double scoreboxPadding = 7;

  @override
  Widget build(Context context) {


    if (isSignOffFooter == true) {
      return Container(
        padding: const EdgeInsets.only(bottom: 6),
        child: drawPageNoRow(
          isForSignOff: true,
          context: context,
        ),
      );
    } else {
      if (pageNo == 1) {
        String followUp =
            "Is a follow up assessment required? ${riskAssessmentEntity.anotherAssessmentRequired == 1 ? "Yes" : "No"}";
        if ((riskAssessmentEntity.anotherAssessmentDate ?? "").isNotEmpty) {
          followUp +=
              "       Further assessment date :${TbPdfHelper.dateStringForLocaleInPdf(date: riskAssessmentEntity.anotherAssessmentDate ?? "", localeName: localeName)}";
        }
        return Container(
          padding: const EdgeInsets.only(top: 5),
          height: TbRaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 23,
                width: double.infinity,
                color: TbRaPdfColors.darkGreyFollowUpBackground,
                child: Center(
                  child: Text(
                    followUp,
                    // style: raPdfTextStyles.boldWhite15(),
                    style: TbPdfHelper().textStyleGenerator(
                      color: TbRaPdfColors.white,
                      font: Theme.of(context).header0.fontBold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                child: buildBody(
                  context: context,
                ),
              ),
              drawPageNoRow(
                context: context,
              )
            ],
          ),
        );
      } else {
        return Container(
          height: TbRaPdfSectionHeights.SECOND_PAGE_FOOTER_HEIGHT,
          child: Column(children: [
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: buildGuide(
                  context: context,
                ),
              ),
            ),
            drawPageNoRow(
              context: context,
            )
          ]),
        );
      }
    }
  }

  Widget buildBody({
    required Context context,
  }) {
    List<ReviewSignOffUserDto> listUser = (riskAssessmentEntity
                .listReviewSignOffUsers ??
            [])
        .where((element) => element.userType == ReviewSignOffUserType.review)
        .toList();
    if (riskAssessmentEntity.approvalMode == ReviewSignOffMode.manual) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildGuide(context: context),
          SizedBox(
            width: 30.0,
          ),
          userSignature(context: context),
          SizedBox(height: 40.0, width: 40.0),
          reviewSignature(
            ReviewSignOffUserDto(),
            context,
          ),
        ],
      );
    } else {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildGuide(
              context: context,
            ),
            SizedBox(
              width: 30.0,
            ),
            userSignature(
              context: context,
            ),
            SizedBox(height: 40.0, width: 40.0),
            listUser.isNotEmpty
                ? reviewSignature(
                    listUser.first,
                    context,
                  )
                : Container(),
          ],
        ),
      );
    }
  }
  

  Widget userSignature({required Context context}) {
    return Container(
      height: TbRaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
      padding: const EdgeInsets.only(top: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Completed by: ',
                // style: raPdfTextStyles.boldBlack9st,
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 8,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                riskAssessmentEntity.userDto?.userName ?? '',
                // style: raPdfTextStyles.normalBlack8(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Position:',
                // style: raPdfTextStyles.boldBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 8,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                riskAssessmentEntity.userDto?.position ?? '',
                // style: raPdfTextStyles.normalBlack8(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            'Signature:',
            // style: raPdfTextStyles.boldBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              color: TbRaPdfColors.black,
              font: Theme.of(context).header0.fontBold,
              fontSize: 8,
            ),
          ),
          Container(
              color: PdfColors.red,
              height: 80,
              width: 80,
              // color: PdfColors.green,
              child: signatureImage != null
                  ? Image(
                      height: 60,
                      width: 80,
                      signatureImage!,
                    )
                  : Container()),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Date of Assessment: ',
                // style: raPdfTextStyles.boldBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 8,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                TbPdfHelper.dateStringForLocaleInPdf(
                    date: riskAssessmentEntity.assessmentDate ?? '',
                    localeName: localeName),
                // style: raPdfTextStyles.normalBlack8(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget reviewSignature(
    ReviewSignOffUserDto user,
    Context context,
  ) {
    return Container(
      height: TbRaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
      padding: const EdgeInsets.only(top: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Reviewed by: ',
                // style: raPdfTextStyles.boldBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 8,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                "${user.firstName ?? ""} ${user.lastName ?? ""}",
                // style: raPdfTextStyles.normalBlack8(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Position:',
                // style: raPdfTextStyles.boldWhite9(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.white,
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 8,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                riskAssessmentEntity.userDto?.position ?? '',
                // style: raPdfTextStyles.boldWhite9(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.white,
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            'Signature:',
            // style: raPdfTextStyles.boldBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              color: TbRaPdfColors.black,
              font: Theme.of(context).header0.fontBold,
              fontSize: 8,
            ),
          ),
          Expanded(
              child: Container(
            // color: PdfColors.green,
            child: reviewImage != null
                ? Image(
                    reviewImage!,
                  )
                : Container(
                    width: 100,
                    height: 40,
                    // color: TbRaPdfColors.lightGreySignatureBgColor,
                    color: PdfColors.white,
                  ),
          )),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Date of Review: ',
                // style: raPdfTextStyles.boldBlack9(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.fontBold,
                  fontSize: 8,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                TbPdfHelper.dateStringForLocaleInPdf(
                  date: user.createdOn ?? '',
                  localeName: localeName,
                ),
                // style: raPdfTextStyles.normalBlack8(),
                style: TbPdfHelper().textStyleGenerator(
                  color: TbRaPdfColors.black,
                  font: Theme.of(context).header0.font,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // return Container(
    //   color: TbRaPdfColors.green,
    //   height: TbRaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
    //   padding: const EdgeInsets.only(top: 9),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         children: [
    //           Text(
    //             'Reviewed by: ',
    //             style: raPdfTextStyles.boldBlack9(),
    //           ),
    //           SizedBox(width: 5.0),
    //           user.firstName != null
    //               ? Text(
    //                   "${user.firstName} ${user.lastName}",
    //                   style: raPdfTextStyles.normalBlack8(),
    //                 )
    //               : Container(),
    //         ],
    //       ),
    //       SizedBox(height: 4.0),
    //       Row(
    //         children: [
    //           Text(
    //             '...',
    //             style: raPdfTextStyles.boldWhite9(),
    //           ),
    //         ],
    //       ),
    //       SizedBox(height: 4.0),
    //       Text(
    //         'Signature:',
    //         style: raPdfTextStyles.boldBlack9(),
    //       ),
    //       SizedBox(height: 4.0),
    //       (reviewImage != null)
    //           ? Row(children: [Image(reviewImage!, height: 35, width: 50)])
    //           : Container(height: 35.0, width: 50.0),
    //       SizedBox(height: 4.0),
    //       Row(
    //         children: [
    //           Text(
    //             'Date of Review: ',
    //             style: raPdfTextStyles.boldBlack9(),
    //           ),
    //           SizedBox(width: 5.0),
    //           Text(
    //             user.createdOn ?? "",
    //             style: raPdfTextStyles.normalBlack8(),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget buildGuide({
    required Context context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 10,
      ),
      child: Container(
        width: TbRaPdfSectionHeights.RATING_GUIDE_WIDTH,
        height: TbRaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 65,
        decoration: TbRaPdfBoxDecorations.boxDecorationKeyStaff,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            worstCase(
              context: context,
            ),
            likeLihood(
              context: context,
            ),
            scoreGuide(
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget worstCase({
    required Context context,
  }) {
    if (riskAssessmentEntity.assessmentType == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Worst Case Outcome',
            // style: raPdfTextStyles.boldBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 9,
            ),
          ),
          Text(
            '1 = No injury',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '2 = Minor injury',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '3 = Lost time injury',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '4 = Severe injury',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '5 = Fatality',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Worst Case Outcome',
            // style: raPdfTextStyles.boldBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '1 = No injury',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '3 = Minor injury',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text('5 = Lost time injury',
              // style: raPdfTextStyles.normalBlack8(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.black,
                fontSize: 8,
              )),
          Text(
            '8 = Severe injury',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '10 = Fatality',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
        ],
      );
    }
  }

  Widget likeLihood({
    required Context context,
  }) {
    if (riskAssessmentEntity.assessmentType == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Likelihood',
            // style: raPdfTextStyles.boldBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 9,
            ),
          ),
          Text(
            '1 = Remote',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '2 = Unlikely',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '3 = Likely',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '4 = Very likely',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '5 = Certain / Imminent',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              fontSize: 8,
              color: TbRaPdfColors.black,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Likelihood',
            // style: raPdfTextStyles.boldBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
          Text(
            '1 = Remote',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              fontSize: 8,
              color: TbRaPdfColors.black,
            ),
          ),
          Text(
            '2 = Unlikely',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              fontSize: 8,
              color: TbRaPdfColors.black,
            ),
          ),
          Text(
            '5 = Likely',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              fontSize: 8,
              color: TbRaPdfColors.black,
            ),
          ),
          Text(
            '8 = Very likely',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              fontSize: 8,
              color: TbRaPdfColors.black,
            ),
          ),
          Text(
            '10 = Certain / Imminent',
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              fontSize: 8,
              color: TbRaPdfColors.black,
            ),
          ),
        ],
      );
    }
  }

  Widget scoreGuide({
    required Context context,
  }) {
    if (riskAssessmentEntity.assessmentType == 0) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Score Guide',
              // style: raPdfTextStyles.boldBlack9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 8,
              ),
            ),
            scoreRisk(
              text: '16 - 25 = High Risk',
              color: TbRaPdfColors.red,
              context: context,
            ),
            scoreRisk(
              text: '9 - 15 =  Medium Risk',
              color: TbRaPdfColors.yellow,
              context: context,
            ),
            scoreRisk(
              text: '1 - 8 = Low Risk',
              color: TbRaPdfColors.green,
              context: context,
            ),
            SizedBox(height: 30, width: 10),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Score Guide',
              // style: raPdfTextStyles.boldBlack9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 9,
              ),
            ),
            Text(
              '50 - 100 = High Risk',
              // style: raPdfTextStyles.normalBlack8(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.black,
                fontSize: 8,
              ),
            ),
            Text(
              '20 - 49 =  Medium Risk',
              // style: raPdfTextStyles.normalBlack8(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.black,
                fontSize: 8,
              ),
            ),
            Text(
              '1 - 19 = Low Risk',
              // style: raPdfTextStyles.normalBlack8(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.black,
                fontSize: 8,
              ),
            ),
            SizedBox(height: 30, width: 10),
          ],
        ),
      );
    }
  }

  Widget drawPageNoRow({
    bool isForSignOff = false,
    required Context context,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 3, right: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
              "It's important you understand this report. If you don't you should seek\nproper Risk Assessment Training.",
              style: isForSignOff
                  // ? raPdfTextStyles.normalWhite8()
                  ? TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.white,
                      fontSize: 8,
                    )
                  // : raPdfTextStyles.normalBlack8(),
                  : TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.black,
                      fontSize: 8,
                    )),
        ),
        Container(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            "Page No: $pageNo${getReferenceNumber()}",
            // style: raPdfTextStyles.italicBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontItalic,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.only(top: 0, left: 30),
        //   child: Row(children: [
        //     Text(
        //       'Created using the Risk Assessor - ',
        //       style: isForSignOff
        //           // ? raPdfTextStyles.normalWhite8()
        //           ? TbPdfHelper().textStyleGenerator(
        //               font: Theme.of(context).header0.font,
        //               fontSize: 8,
        //               color: TbRaPdfColors.white,
        //             )
        //           :
        //           // raPdfTextStyles.normalBlack8(),
        //           TbPdfHelper().textStyleGenerator(
        //               font: Theme.of(context).header0.font,
        //               fontSize: 8,
        //               color: TbRaPdfColors.black,
        //             ),
        //     ),
        //     RichText(
        //       text: TextSpan(
        //           text: "www.riskassessor.net",
        //           style: isForSignOff
        //               ?
        //               // ? raPdfTextStyles.normalWhite8()
        //               TbPdfHelper().textStyleGenerator(
        //                   font: Theme.of(context).header0.font,
        //                   fontSize: 8,
        //                   color: TbRaPdfColors.white,
        //                 )
        //               // : raPdfTextStyles.linkBlue8(),
        //               : TbPdfHelper().textStyleGenerator(
        //                   fontSize: 8,
        //                   color: TbRaPdfColors.blue,
        //                   font: Theme.of(context).header0.font,
        //                   textDecoration: TextDecoration.underline,
        //                 )),
        //     ),
        //   ]),
        // )
      ]),
    );
  }

  Widget scoreRisk({
    required String text,
    required PdfColor? color,
    required Context context,
  }) {
    return Container(
      // color: PdfColors.purple,
      child: Row(
        children: [
          Container(
            height: scoreBoxSize,
            width: scoreBoxSize,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                width: 1.0,
                color: TbRaPdfColors.greyBorder,
              ),
            ),
          ),
          Container(
            // color: PdfColors.red,
            height: scoreboxPadding,
            width: scoreboxPadding,
          ),
          Text(
            text,
            // style: raPdfTextStyles.normalBlack8(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  String getReferenceNumber() {
    if ((riskAssessmentEntity.referenceNumber ?? "").isNotEmpty) {
      return " / ${riskAssessmentEntity.referenceNumber ?? ''}";
    } else {
      return "";
    }
  }
}
