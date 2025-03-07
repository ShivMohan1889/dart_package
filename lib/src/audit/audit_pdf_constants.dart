import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class AuditPdfDimension {
  static const double pageWidth = 595;
  static const double pageHeight = 842;
  static const double questionWidth = 320;

  static const double projectDetailsTableCellWidth = 210;

  static const double auditCompanyDetailsSectionHeight
      //  = 135;
      = 136.5;

  static const double auditAssessmentImageHeight = 300;
  // 550;

  static const double headerSectionHeight = 76;
}

class AuditPdfColors {
  AuditPdfColors._();
  static PdfColor black = PdfColor.fromHex("#000");
  static PdfColor white = PdfColor.fromHex("#fff");
  static PdfColor greyCompanyDetailsBackground = PdfColor.fromHex("#acacac");

  static PdfColor companyDetailsTextColor = PdfColor.fromHex('#919598');

  static PdfColor projectDetailsBorderColor = PdfColor.fromHex('#d1d1d3');

  static PdfColor questionRowBackgroundLightGreyColor =
      PdfColor.fromHex("#ededee");

  static PdfColor questionRowBackgroundDarkGreyColor =
      PdfColor.fromHex('#e2e2e3');

  // static PdfColor auditBlueLightColor = PdfColor.fromHex("#38b8f0");

  static PdfColor upgradeToUnlockColor = PdfColor.fromHex("#077BB7");

  static PdfColor auditTextStyleColor = PdfColor.fromHex("#939598");

  static PdfColor auditPageNoColor = PdfColor.fromHex("#82817d");
}

class AuditPdfBoxDecorations {
  // box decoration for audit section image item
  static pw.BoxDecoration auditSectionImageItemBoxDecoration = pw.BoxDecoration(
    border: Border.all(
      width: 1,
      color: AuditPdfColors.black,
    ),
  );
}

/// padding for audit pdf
class AuditPdfPaddings {
  static const pw.EdgeInsets pageHorizontalPadding =
      pw.EdgeInsets.symmetric(horizontal: 15);

  //padding for first contanier in companyDetailsRow widget
  static pw.EdgeInsets companyDetialsSectionFirstContainerPadding =
      const pw.EdgeInsets.only(
    left: 20,
    top: 2,
  );

  //padding for project detials section  widget
  static pw.EdgeInsets projectDetailsSectionPadding = const pw.EdgeInsets.only(
    // top: 4,
    // bottom: 0,
    top: 10,
    bottom: 10,

    left: 20,
    right: 30,
  );

  //padding For Second Container in companyDetailsRow Widget
  static pw.EdgeInsets companyDetailsSectionSecondContainerPadding =
      const pw.EdgeInsets.only(
    left: 4,
    top: 5,
  );

  static pw.EdgeInsets questionRowPadding = const pw.EdgeInsets.only(
    top: 6,
    bottom: 6,

    // left: 15,
    left: 10,
    right: 1,
  );

  ///  padding for chainOption row widget
  static pw.EdgeInsets chainOptionRowPaddng = const pw.EdgeInsets.only(
    top: 5,
    bottom: 5,
    // left: 15,
    left: 10,
    right: 15,
  );

  static pw.EdgeInsets sectionImageItemMargin = const pw.EdgeInsets.only(
    // left: 22.09,
    left: 21,

    // right: 5,
  );

  /// padding for section Image items
  static pw.EdgeInsets sectionImageItemPadding = const pw.EdgeInsets.only(
    top: 45,
    bottom: 45,

    // left: 20,
    // right: 5,
  );

  /// padding for audit audit section image row
  static pw.EdgeInsets auditSectionImageRowPadding = const pw.EdgeInsets.only(
    top: 5,
    bottom: 5,
    // left: 20,
    // right: 20,
  );

  // padding for Question of Statement type
  static pw.EdgeInsets statementQuestionPadding = const pw.EdgeInsets.only(
    left: 50,
    // left: 35,
    top: 3,
    bottom: 3,
  );

  static pw.EdgeInsets statementQuestionTypePadding = const pw.EdgeInsets.only(
    left: 50,
    top: 3,
    bottom: 3,
  );

  ///padding for summery table
  static pw.EdgeInsets summeryTablePadding = const pw.EdgeInsets.only(
    left: 20,
    right: 20,
    top: 20,
  );

  static pw.EdgeInsets sectionNamePadding = const pw.EdgeInsets.only(
    left: 20,
    right: 20,
    top: 10,
    bottom: 10,
  );

  ///padding for audit question text input answer section widget
  static pw.EdgeInsets auditQuestionTextInputAnswerSectionPadding =
      const pw.EdgeInsets.only(left: 40, top: 6, bottom: 6, right: 20);

  ///padding for audit audit section image row
  static pw.EdgeInsets sectionDescriptionPadding = const pw.EdgeInsets.only(
    left: 20,
    right: 20,
    top: 4,
  );

  /// padding for audit title row
  static pw.EdgeInsets auditTitleRowPadding = const pw.EdgeInsets.only(
    left: 20,
    bottom: 15,
    top: 8,
  );

  /// padding for question image and comment
  static pw.EdgeInsets paddingForQuestionImageAndComment =
      const pw.EdgeInsets.only(
    // left: 40,
    left: 50,
    // left: 35,
    top: 3,
    bottom: 3,
  );

  /// padding for audit Assessment image
  static pw.EdgeInsets auditAssessmentImagePadding = const pw.EdgeInsets.only(
    left: 25,
    top: 10,
    right: 25,
    bottom: 100,
  );

  static pw.EdgeInsets pageLeftPadding = const pw.EdgeInsets.only(left: 20);

  static pw.EdgeInsets pageRightPadding = const pw.EdgeInsets.only(right: 20);
  static pw.EdgeInsets righLeftPadding =
      const pw.EdgeInsets.symmetric(horizontal: 20);
}

/* ************************************** */
// RaPdfTextStyles
/* ************************************** */
class AuditPdfTextStyles {
  static Font? arialNormalFont;
  static Font? arialBoldFont;
  static Font? arialItalicFont;

  static Font? museoSansNormalFont;
  static Font? museoSansItalicFont;
  Font? museoSansRounded;
  static Font? museoSansRoundedBold;

  /// this will help us to load fonts only one time.
  static bool loadFontsFlag = true;
  AuditPdfTextStyles._();
  static final AuditPdfTextStyles _singleton = AuditPdfTextStyles._();
  factory AuditPdfTextStyles() {
    // loadFonts();
    return _singleton;
  }
}
// ignore_for_file: constant_identifier_names

/* ************************************** */
//  MS PDF WIDH
/* ************************************** */
class MsPdfWidth {
  /// page width in pixel

  static const double pageWidth = 595;
  static const double pageHeight = 842;

  // width for Ms Statement Row Widget
  static const double statementWidth = 550;
}
/* ************************************** */
//  MS PDF HEIGHTS
/* ************************************** */

class MsPdfHeights {
  static double blankSpaceContainerHeight = 77;
}
/* ************************************** */
//  MS PDF COLORS
/* ************************************** */

class MsPdfColors {
  MsPdfColors._();
  // In your TbMsPdfColors class or wherever your colors are defined

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
class MsPdfBoxDecorations {
  /// box decoration for  project details section
  // static pw.BoxDecoration boxDecorationForProjectDetailsSection = BoxDecoration(
  //   color: PdfColors.white,
  //   border: Border(
  //     top: BorderSide(
  //       color: MsPdfColors.projectDetailsBorderColor,
  //       width: 2,
  //     ),
  //     bottom: BorderSide(
  //       color: MsPdfColors.projectDetailsBorderColor,
  //       width: 2,
  //     ),
  //   ),
  // );

  /// box decoration for company details row

  static pw.BoxDecoration boxDecorationForCompanyRow = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 2,
        color: MsPdfColors.projectDetailsBorderColor,
      ),
    ),
  );

  /// box decoration for ms title row
  static pw.BoxDecoration boxDecorationForMsTitleRow = BoxDecoration(
    color: MsPdfColors.msBlueThemeColor,
    border: Border(
      top: BorderSide(
        width: 1.5,
        color: MsPdfColors.msTitleRowBorderColor,
      ),
      bottom: BorderSide(
        color: MsPdfColors.msTitleRowBorderColor,
        width: 1.5,
      ),
    ),
  );
}

/* ************************************** */
//  MS PDF PADDINGS
/* ************************************** */

class MsPdfPaddings {
/**************** PADDING **************** */

  static const pw.EdgeInsets pageHorizontalPadding =
      pw.EdgeInsets.symmetric(horizontal: 15);

  /// padding for Review Sign off User Row
  static const pw.EdgeInsets rightAndLeftPadding =
      pw.EdgeInsets.only(left: 20, right: 20);

  static const pw.EdgeInsets rightPadding = pw.EdgeInsets.only(right: 20);

  /// padding for Ms Header Entity
  static const pw.EdgeInsets paddingForMsheaderEntity = pw.EdgeInsets.only(
    left: 20,
    top: 20,
    right: 20,
  );

  static const pw.EdgeInsets paddingForMsHeaderEntityHeaderLevelZero =
      pw.EdgeInsets.only(
    left: 20,
    // top: 18,
    top: 13,
    right: 20,
  );

  static const pw.EdgeInsets paddingForMsHeaderEntityHeaderLevelNotZero =
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
  static const pw.EdgeInsets paddingForMsTitleRow = pw.EdgeInsets.only(
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

  /// padding for Ms Assessment Image Row
  static const pw.EdgeInsets paddingForMsAssessmentImageColumn =
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

  /// padding for Ms Statement Row Widget
  static const pw.EdgeInsets paddingMsStatementRow = pw.EdgeInsets.only(
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

  /// padding for Ms Sign Off Section Widget
  static const pw.EdgeInsets paddingForMsSignOffSection = pw.EdgeInsets.only(
    top: 18,
    left: 20,
  );

/* ***************--MARGIN--***************** */

  /// margin for  Ms Statement Icon Row Widget
  static const pw.EdgeInsets marginMsStatementHazardIconRow =
      pw.EdgeInsets.only(
    top: 5,
    left: 20,
    right: 20,
    bottom: 15,
  );

  /// margin for  Ms Statement Icon Row Widget
  static const pw.EdgeInsets marginForProjectNameAndDateInMsTitleRow =
      pw.EdgeInsets.only(
    right: 20,
    left: 20,
    top: 10,
  );

  /// margin for  Ms Statement Icon Row Widget
  static const pw.EdgeInsets marginForFooterSection = pw.EdgeInsets.only(
    bottom: 20,
  );

  // margin for for ms title row
  static const pw.EdgeInsets marginForMsTitleRow = pw.EdgeInsets.only(
    bottom: 2,
  );

  // margin for for Ms Review Signature section Widget
  static const pw.EdgeInsets marginForMsReviewSignatureSection =
      pw.EdgeInsets.only(
    top: 20,
  );
}

/* ************************************** */
// MS PDF TEXT STYLES
/* ************************************** */
class MsPdfTextStyles {
  static Font? arialNormalFont;
  static Font? arialBoldFont;
  static Font? arialItalicFont;

  /// this will help us to load fonts only one time.
  static bool loadFontsFlag = true;
  MsPdfTextStyles._();
  static final MsPdfTextStyles _singleton = MsPdfTextStyles._();
  factory MsPdfTextStyles() {
    return _singleton;
  }
}
