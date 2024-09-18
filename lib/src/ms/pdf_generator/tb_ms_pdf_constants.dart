// ignore_for_file: constant_identifier_names

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

/* ************************************** */
//  MS PDF WIDH
/* ************************************** */
class TbMsPdfWidth {
  /// page width in pixel

  static const double pageWidth = 595;
  static const double pageHeight = 842;

  // width for TbMs Statement Row Widget
  static const double statementWidth = 550;


}
/* ************************************** */
//  MS PDF HEIGHTS
/* ************************************** */

class TbMsPdfHeights {
  static double blankSpaceContainerHeight = 77;
  static const double FIRST_PAGE_HEIGHT = 104;
  static const double FIRST_PAGE_FOOTER_HEIGHT = 165;

}
/* ************************************** */
//  MS PDF COLORS
/* ************************************** */

class TbMsPdfColors {
  TbMsPdfColors._();
  static PdfColor black = PdfColor.fromHex("#000000");
  static PdfColor white = PdfColor.fromHex("#fff");
  static PdfColor greyCompanyDetailsBackground = PdfColor.fromHex("#acacac");
  static PdfColor lightgreyKeyStaffBackground = PdfColor.fromHex("#efefef");
  static PdfColor darkGreyFollowUpBackground = PdfColor.fromHex("#353535");

  static PdfColor greyBorder = PdfColor.fromHex("#b6b6b6");

  static PdfColor msBlueThemeColor = PdfColor.fromHex('#34aeef');

  static PdfColor upgradeToUnlockColor = PdfColor.fromHex("#077BB7");

  static PdfColor companyDetailsTextColor = PdfColor.fromHex('#919598');

  static PdfColor projectDetailsBorderColor = PdfColor.fromHex('#acacac');

  static PdfColor msTitleRowBorderColor = PdfColor.fromHex('#1f7ac1');


}

/* ************************************** */
//  MS PDF BOX DECORATIONS
/* ************************************** */
class TbMsPdfBoxDecorations {
  /// box decoration for  project details section
  // static pw.BoxDecoration boxDecorationForProjectDetailsSection = BoxDecoration(
  //   color: PdfColors.white,
  //   border: Border(
  //     top: BorderSide(
  //       color: TbMsPdfColors.projectDetailsBorderColor,
  //       width: 2,
  //     ),
  //     bottom: BorderSide(
  //       color: TbMsPdfColors.projectDetailsBorderColor,
  //       width: 2,
  //     ),
  //   ),
  // );

  /// box decoration for company details row

  static pw.BoxDecoration boxDecorationForCompanyRow = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 2,
        color: TbMsPdfColors.projectDetailsBorderColor,
      ),
    ),
  );

  /// box decoration for ms title row
  static pw.BoxDecoration boxDecorationForTbMsTitleRow = BoxDecoration(
    color: TbMsPdfColors.msBlueThemeColor,
    border: Border(
      top: BorderSide(
        width: 1.5,
        color: TbMsPdfColors.msTitleRowBorderColor,
      ),
      bottom: BorderSide(
        color: TbMsPdfColors.msTitleRowBorderColor,
        width: 1.5,
      ),
    ),
  );
}

/* ************************************** */
//  MS PDF PADDINGS
/* ************************************** */

class TbMsPdfPaddings {
/**************** PADDING **************** */

  /// padding for Review Sign off User Row
  static const pw.EdgeInsets rightAndLeftPadding =
      pw.EdgeInsets.only(left: 20, right: 20);

  /// padding for TbMs Header Entity
  static const pw.EdgeInsets paddingForTbMsheaderEntity = pw.EdgeInsets.only(
    left: 20,
    top: 20,
    right: 20,
  );

  static const pw.EdgeInsets paddingForTbMsHeaderEntityHeaderLevelZero =
      pw.EdgeInsets.only(
    left: 20,
    // top: 18,
    top: 13,
    right: 20,
  );

  static const pw.EdgeInsets paddingForTbMsHeaderEntityHeaderLevelNotZero =
      pw.EdgeInsets.only(
    left: 20,
    top: 5,
    right: 20,
  );

  /// padding for Company details Row First Container

  static const pw.EdgeInsets paddingForCompanyDetailsRowFirstContainer =
      pw.EdgeInsets.only(
    left: 20,
    top: 8,
  );

  /// padding for company details Row Second Container

  static const pw.EdgeInsets paddingForCompanyDetailsRowSecondContainer =
      pw.EdgeInsets.only(
    top: 7,
    left: 5,
    right: 20,
  );

  /// padding for Review Sign Signature Section  Widget
  static const pw.EdgeInsets paddingForTbMsTitleRow = pw.EdgeInsets.only(
    left: 20,
    bottom: 22,
    top: 15,
  );

  /// padding for Company Details Section
  static const pw.EdgeInsets paddingForCompanyDetailsSection =
      pw.EdgeInsets.only(
    left: 20,
    top: 8,
  );

  /// padding for TbMs Assessment Image Row
  static const pw.EdgeInsets paddingForTbMsAssessmentImageColumn =
      pw.EdgeInsets.only(
    left: 20,
    top: 20,
    bottom: 20,
  );

  /// padding for Project Details Section
  static const pw.EdgeInsets paddingForProjectDetailsSection =
      pw.EdgeInsets.only(
    top: 12,
    bottom: 15,
  );

  static const pw.EdgeInsets paddingForCustomText = pw.EdgeInsets.only(
    top: 20,
    left: 20,
  );

  /// padding for TbMs Statement Row Widget
  static const pw.EdgeInsets paddingTbMsStatementRow = pw.EdgeInsets.only(
    left: 20,
    top: 5,
    right: 20,
  );

  /// padding for Review Sign Signature Section  Widget
  static const pw.EdgeInsets paddingForReviewSignSignatureSection =
      pw.EdgeInsets.only(
    left: 20,
  );

  /// padding for Review Sign off User Row
  static const pw.EdgeInsets paddingForReviewSignOffUserRow =
      pw.EdgeInsets.only(
    left: 20,
    top: 10,
  );

  /// padding for TbMs Sign Off Section Widget
  static const pw.EdgeInsets paddingForTbMsSignOffSection = pw.EdgeInsets.only(
    top: 18,
    left: 20,
  );

/* ***************--MARGIN--***************** */

  /// margin for  TbMs Statement Icon Row Widget
  static const pw.EdgeInsets marginTbMsStatementHazardIconRow =
      pw.EdgeInsets.only(
    top: 5,
    left: 20,
    right: 20,
    bottom: 15,
  );

  /// margin for  TbMs Statement Icon Row Widget
  static const pw.EdgeInsets marginForProjectNameAndDateInTbMsTitleRow =
      pw.EdgeInsets.only(
    right: 20,
    left: 20,
    top: 10,
  );

  /// margin for  TbMs Statement Icon Row Widget
  static const pw.EdgeInsets marginForFooterSection = pw.EdgeInsets.only(
    bottom: 20,
  );

  // margin for for ms title row
  static const pw.EdgeInsets marginForTbMsTitleRow = pw.EdgeInsets.only(
    bottom: 2,
  );

  // margin for for TbMs Review Signature section Widget
  static const pw.EdgeInsets marginForTbMsReviewSignatureSection =
      pw.EdgeInsets.only(
    top: 20,
  );
}

/* ************************************** */
// MS PDF TEXT STYLES
/* ************************************** */
class TbMsPdfTextStyles {
  static Font? arialNormalFont;
  static Font? arialBoldFont;
  static Font? arialItalicFont;

  /// this will help us to load fonts only one time.
  static bool loadFontsFlag = true;
  TbMsPdfTextStyles._();
  static final TbMsPdfTextStyles _singleton = TbMsPdfTextStyles._();
  factory TbMsPdfTextStyles() {
    return _singleton;
  }
}
