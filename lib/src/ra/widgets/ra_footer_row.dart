import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:dart_pdf_package/src/ra/ra_pdf_data.dart';
import 'package:dart_pdf_package/src/ra/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/enums/review_sign_off_mode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class RaFooterRow extends StatelessWidget {
  final int? pageNo;
  int? pageNoToRender;
  final bool? isSignOffFooter;
  final RaPdfData pdfData;

  RaFooterRow({
    required this.pageNo,
    this.pageNoToRender,
    required this.pdfData,
    required this.isSignOffFooter,
  });

  /// object to fetch pdf styles
  final raPdfTextStyles = TbRaPdfTextStyles();

  /// height of the scorebox
  final double scoreBoxSize = 13;

  /// space between scorebox and text
  final double scoreboxPadding = 7;

  @override
  Widget build(Context context) {
    if (pageNo != 1) {
      return Container(
        height: TbRaPdfSectionHeights.SECOND_PAGE_FOOTER_HEIGHT,
        padding: const EdgeInsets.only(
          // bottom: 6,
          bottom: 10,
        ),
        child: drawPageNoRow(
          isForSignOff: true,
          context: context,
        ),
      );
    } else {
      String followUp =
          "Is a follow up assessment required? ${pdfData.anotherAssessmentRequired == 1 ? "Yes" : "No"}";
      if ((pdfData.anotherAssessmentDate ?? "").isNotEmpty) {
        followUp +=
            "       Further assessment date :${pdfData.anotherAssessmentDate ?? ""}";
      }
      return Container(
        padding: const EdgeInsets.only(top: 5, right: 15),
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
    }
  }

  Widget buildBody({
    required Context context,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGuide(context: context),
        SizedBox(width: 30.0),
        userSignature(context: context),
        SizedBox(width: 15.0),
        pdfData.reviewSignature != null ||
                pdfData.approvalMode == ReviewSignOffMode.manual
            ? reviewSignature(pdfData.reviewSignature, context)
            : Container(),
      ],
    );
  }

  Widget userSignature({required Context context}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Container(
        width: 223,
        height: TbRaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: TbRaPdfBoxDecorations.boxDecorationSignature,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            buildInfoRow(
              label: 'Completed by: ',
              value: pdfData.userSignature.name,
              context: context,
            ),
            SizedBox(height: 4.0),
            // Position row
            buildInfoRow(
              label: 'Position:',
              value: pdfData.userSignature.position,
              context: context,
            ),
            SizedBox(height: 4.0),
            // Signature label
            Text(
              'Signature:',
              style: TbPdfHelper().textStyleGenerator(
                color: TbRaPdfColors.black,
                font: Theme.of(context).header0.fontBold,
                fontSize: 8,
              ),
            ),
            SizedBox(height: 4.0),
            // Signature image
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                color: TbMsPdfColors.lightGreyBackground,
                child: pdfData.userSignature.signatureMemoryImage != null
                    ? Center(
                        child: Image(
                          pdfData.userSignature.signatureMemoryImage!,
                        ),
                      )
                    : Container(),
              ),
            ),
            SizedBox(height: 4.0),
            // Date row
            buildInfoRow(
              label: 'Date of Assessment: ',
              value: pdfData.assessmentDate ?? "",
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewSignature(
    ReviewSignOffSignatureData? user,
    Context context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 8,
      ),
      child: Container(
        width: 223,
        height: TbRaPdfSectionHeights.FIRST_PAGE_FOOTER_HEIGHT - 61,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: TbRaPdfBoxDecorations.boxDecorationSignature,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            buildInfoRow(
              label: 'Reviewed by: ',
              value: user?.name ?? "",
              context: context,
            ),
            SizedBox(height: 4.0),
            // Add empty space to match the layout of user signature
            // SizedBox(height: 20.0),
            // Signature label
            Text(
              'Signature:',
              style: TbPdfHelper().textStyleGenerator(
                color: TbRaPdfColors.black,
                font: Theme.of(context).header0.fontBold,
                fontSize: 8,
              ),
            ),
            SizedBox(height: 4.0),
            // Signature image with consistent styling
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                color: TbMsPdfColors.lightGreyBackground,
                child: user?.signatureMemoryImage != null
                    ? Center(child: Image(user!.signatureMemoryImage!))
                    : Container(),
              ),
            ),
            SizedBox(height: 4.0),
            // Date row
            buildInfoRow(
              label: 'Date of Review: ',
              value: user?.date ?? "",
              context: context,
            ),
          ],
        ),
      ),
    );
  }

// Helper method for consistent label-value rows
  Widget buildInfoRow({
    required String label,
    required String value,
    required Context context,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TbPdfHelper().textStyleGenerator(
            color: TbRaPdfColors.black,
            font: Theme.of(context).header0.fontBold,
            fontSize: 8,
          ),
        ),
        SizedBox(width: 5.0),
        Expanded(
          child: Text(
            value,
            style: TbPdfHelper().textStyleGenerator(
              color: TbRaPdfColors.black,
              font: Theme.of(context).header0.font,
              fontSize: 8,
            ),
          ),
        ),
      ],
    );
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
        decoration: TbRaPdfBoxDecorations.boxDecorationSignature,
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
    if (pdfData.assessmentType == 0) {
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
    if (pdfData.assessmentType == 0) {
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
    if (pdfData.assessmentType == 0) {
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
      padding: const EdgeInsets.only(
        left: 15, top: 3,

        // right: 15,
      ),
      alignment: Alignment.bottomLeft,
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
          padding: isForSignOff
              ? const EdgeInsets.only(
                  top: 0,
                  right: 15,
                )
              : const EdgeInsets.only(),
          child: Text(
            "Page No: $pageNoToRender${getReferenceNumber()}",
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
    if ((pdfData.referenceNumber ?? "").isNotEmpty) {
      return " / ${pdfData.referenceNumber ?? ''}";
    } else {
      return "";
    }
  }
}
