// ignore_for_file: constant_identifier_names

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class TbRaPdfWidth {
  ///Hazard Colum widths
  static final List<double> columnWidthMatrix = [
    183,
    32,
    183,
    132,
    183,
    99,
  ];

  static final List<double> columnWidthStandard = [
    183,
    32,
    183,
    66,
    66,
    183,
    50,
    49
  ];

  /// page width in pixel
  static const double pageWidth = 841;
}

class TbRaPdfColors {
  static PdfColor black = PdfColor.fromHex("#000");
  static PdfColor white = PdfColor.fromHex("#fff");
  static PdfColor greyCompanyDetailsBackground = PdfColor.fromHex("#acacac");
  static PdfColor weatherTextColor = PdfColor.fromHex("#868686");
  static PdfColor lightgreyKeyStaffBackground = PdfColor.fromHex("#efefef");
  static PdfColor darkGreyFollowUpBackground = PdfColor.fromHex("#353535");
  static PdfColor red = PdfColor.fromHex("#f83e43");
  static PdfColor green = PdfColor.fromHex("#00fc50");
  static PdfColor yellow = PdfColor.fromHex("#fbf950");
  static PdfColor greyBorder = PdfColor.fromHex("#b6b6b6");
  static PdfColor blue = PdfColor.fromHex('#3333ff');
  static PdfColor weatherForeCastTitle = PdfColor.fromHex("#107cb5");

  static PdfColor lightGreyPdfColor = PdfColor.fromHex("#e3e3e2");

  static PdfColor msBlueThemeColor = PdfColor.fromHex('#34aeef');
  static PdfColor upgradeToUnlockColor = PdfColor.fromHex("#077BB7");

  static PdfColor lightGreySignatureBgColor = PdfColor.fromHex("#fafcf9");
}

class TbRaPdfBoxDecorations {
  static pw.BoxDecoration borderBoxDecoration = pw.BoxDecoration(
    border: pw.Border.all(
      width: 0.5,
      color: TbRaPdfColors.greyBorder,
    ),
  );

  static pw.BoxDecoration boxDecorationKeyStaff = pw.BoxDecoration(
      border: pw.Border.all(
        width: 0.5,
        color: TbRaPdfColors.greyBorder,
      ),
      color: TbRaPdfColors.lightgreyKeyStaffBackground);
}

class TbRaPdfPaddings {
  static const pw.EdgeInsets pageHorizontalPadding =
      pw.EdgeInsets.symmetric(horizontal: 15);

  static pw.EdgeInsets pageLeftPadding = const pw.EdgeInsets.only(left: 20);

  static pw.EdgeInsets pageRightPadding = const pw.EdgeInsets.only(right: 20);

  static pw.EdgeInsets cellPadding =
      const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3);
}

/* ************************************** */
// TbRaPdfTextStyles
/* ************************************** */
class TbRaPdfTextStyles {
  static Font? arialNormalFont;
  static Font? arialBoldFont;
  static Font? arialItalicFont;

  /// this will help us to load fonts only one time.
  static bool loadFontsFlag = true;
  TbRaPdfTextStyles._();
  static final TbRaPdfTextStyles _singleton = TbRaPdfTextStyles._();
  factory TbRaPdfTextStyles() {
    // loadFonts();
    return _singleton;
  }
}

class TbRaPdfSectionHeights {
  /// logo section in which has RISK ASSESSMENT FORM Heading and the company logo
  /// logo section in which has RISK ASSESSMENT FORM Heading and the company logo
  static const double LOGO_SECTION = 69;

  /// company bar that has the company details, email and phone numbers
  static const double COMPANY_DETAILS_BAR = 18;

  static const double RATING_GUIDE_WIDTH = 305;

  ///
  static const double PROJECT_DETAILS = 177;
  static const double HAZARD_HEADING = 50;

  static const double FIRST_PAGE_HEADER_HEIGHT = 326;
  static const double SECOND_PAGE_HEADER_HEIGHT = 149;

  static const double FIRST_PAGE_FOOTER_HEIGHT = 165;
  static const double SECOND_PAGE_FOOTER_HEIGHT = 25;
  static const double SIGN_OFF_PAGE_FOOTER_HEIGHT = 20;

  static const double FIRST_PAGE_HEIGHT = 104;
  static const double SECOND_PAGE_HEIGHT = 421;
  static const double SIGN_OFF_PAGE_HEIGHT = 297;
}
