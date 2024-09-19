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

  static void loadFonts() async {
    // don't remove this condition
    // its important
    // if (loadFontsFlag == true) {
    //   arialNormalFont =
    //       pw.Font.ttf(await rootBundle.load('assets/fonts/arial_1.ttf'));
    //   arialBoldFont =
    //       pw.Font.ttf(await rootBundle.load('assets/fonts/arialbd.ttf'));

    //   arialItalicFont =
    //       pw.Font.ttf(await rootBundle.load('assets/fonts/Arial_Italic.ttf'));
    //   loadFontsFlag = false;
    // }
  }

  // // pw.TextStyle msTitleTextStyle() {}

  // /// style for header title text that says RISK ASSESSMENT REPORT
  // pw.TextStyle headerTextStyle() {
  //   return pw.TextStyle(
  //     fontSize: 14,
  //     fontWeight: FontWeight.bold,
  //     color: TbRaPdfColors.black,
  //     font: arialBoldFont,
  //   );
  // }

  // /// style for header title text that says RISK ASSESSMENT REPORT

  // pw.TextStyle italicBlack7() {
  //   return pw.TextStyle(
  //     fontSize: 7,
  //     color: TbRaPdfColors.black,
  //     font: arialItalicFont,
  //     fontStyle: FontStyle.italic,
  //   );
  // }

  // pw.TextStyle italicBlack8() {
  //   return pw.TextStyle(
  //     fontSize: 8,
  //     color: TbRaPdfColors.black,
  //     font: arialItalicFont,
  //     fontStyle: FontStyle.italic,
  //   );
  // }

  // pw.TextStyle normalWhite8() {
  //   return pw.TextStyle(
  //     fontSize: 8,
  //     color: TbRaPdfColors.white,
  //   );
  // }

  // pw.TextStyle normalWhite10() {
  //   return pw.TextStyle(
  //     fontSize: 10,
  //     color: TbRaPdfColors.white,
  //   );
  // }

  // pw.TextStyle normalBlack8() {
  //   return pw.TextStyle(
  //     fontSize: 8,
  //     color: TbRaPdfColors.black,
  //   );
  // }

  // pw.TextStyle linkBlue8() {
  //   return pw.TextStyle(
  //     fontSize: 8,
  //     color: TbRaPdfColors.blue,
  //     decoration: TextDecoration.underline,
  //   );
  // }

  // pw.TextStyle hazardTableSubHeading() {
  //   return pw.TextStyle(
  //     fontSize: 8,
  //     color: TbRaPdfColors.black,
  //     font: arialBoldFont,
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // pw.TextStyle normalBlack9() {
  //   return pw.TextStyle(
  //     fontSize: 9,
  //     color: TbRaPdfColors.black,
  //     //font: arialItalicFont,
  //   );
  // }

  // pw.TextStyle italicBlack9() {
  //   return pw.TextStyle(
  //     fontSize: 9,
  //     color: TbRaPdfColors.black,
  //     font: arialItalicFont,
  //     fontStyle: FontStyle.italic,
  //   );
  // }

  // pw.TextStyle linkBlue9() {
  //   return pw.TextStyle(
  //     fontSize: 9,
  //     color: TbRaPdfColors.blue,
  //     decoration: TextDecoration.underline,
  //   );
  // }

  // pw.TextStyle boldBlack9() {
  //   return pw.TextStyle(
  //     fontSize: 9,
  //     color: TbRaPdfColors.black,
  //     font: arialBoldFont,
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // /// Style for company details in the header
  // pw.TextStyle boldWhite9() {
  //   return pw.TextStyle(
  //     fontSize: 9,
  //     color: TbRaPdfColors.white,
  //     font: arialNormalFont,
  //   );
  // }

  // /// Style for company details in the header
  // pw.TextStyle boldWhite13() {
  //   return pw.TextStyle(
  //     fontSize: 13,
  //     color: TbRaPdfColors.white,
  //     font: arialBoldFont,
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // pw.TextStyle boldWhite11() {
  //   return pw.TextStyle(
  //     fontSize: 11,
  //     color: TbRaPdfColors.white,
  //     font: arialBoldFont,
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // pw.TextStyle weatherCell13() {
  //   return pw.TextStyle(
  //     fontSize: 10,
  //     color: TbRaPdfColors.black,
  //     font: arialNormalFont,
  //   );
  // }

  // /// Style for company details in the header
  // pw.TextStyle boldWhite15() {
  //   return pw.TextStyle(
  //     fontSize: 15,
  //     color: TbRaPdfColors.white,
  //     font: arialBoldFont,
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // pw.TextStyle hazardTableHeading() {
  //   return pw.TextStyle(
  //     fontSize: 10,
  //     color: TbRaPdfColors.black,
  //     font: arialBoldFont,
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // pw.TextStyle notUpgradeTextStyle() {
  //   return pw.TextStyle(
  //     fontSize: 9,
  //     color: TbRaPdfColors.upgradeToUnlockColor,
  //     font: arialNormalFont,
  //     fontWeight: FontWeight.normal,
  //   );
  // }
}

class TbRaPdfSectionHeights {
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
  static const double SECOND_PAGE_FOOTER_HEIGHT = 138;
  static const double SIGN_OFF_PAGE_FOOTER_HEIGHT = 20;

  static const double FIRST_PAGE_HEIGHT = 104;
  static const double SECOND_PAGE_HEIGHT = 313;
  static const double SIGN_OFF_PAGE_HEIGHT = 297;
}
