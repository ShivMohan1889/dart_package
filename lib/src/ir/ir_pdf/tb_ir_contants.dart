import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

class TbIrPdfDimension {
  // Height
  static const double footerHeight = 40;

  // header height
  static const double headerHeight = 119;
  // height of  the  image box Widget
  static const double incidentReportImageBoxHeight = 201;
  // 195;

  static const double irTextQuestionHeight = 25;

  static const double imageTitleBoxHeight = 19;

  static const double sketchImageHeight =
      // 450;
      380;

  // height of ir logo image
  static const double irLogoImageHeight = 78.99;

  /// height of the option title widget
  static const double irInjuryOptionTitleHeight = 50;

  /// height of the image title widget
  static const double irImageTitleHeight = 20;

  /// height of the  company logo image height
  static const double companyLogoImageHeight = 80;

  /// height of the ir Location Heading Widget
  static const double irLocationMapTitleBoxHeight = 30;

  /// height of the option box Widget
  static const double injuryOptionBoxHeight = 41;

  static const double injuryTypeContainerHeight = 22;

  static const double irMapImageHeight = 290;

  //  Width

  static const double pageWidth = 595;
  // static const double pageWidth = 843.0;
  static const double pageHeight = 842;

  static const double connectionRowWidth = 393;
  // static const double connectionRowWidth = 373;

  // user name Heading the Width
  static const double irUserNameHeadingWidth = 300;
  // user name value with
  static const double irUserNameValueWidth = 180;
  // width of irJobTitle Section inside the UserDetails Widget
  static const double irJobTitleWidth = 180;
  // width of irJobTitle Section inside the UserDetails Widget

  static const double irAddress1Width = 300;

  static const double irPostCodeWidth = 180;
  static const double irAddress2Width = 80;

  static const double irPostCodeValueWidth = 220;

  static const double irTelePhoneWidth = 300;

  static const double irEmailWidth = 180;
  static const double irEmailValueWidth = 180;

  static const double spaceUsedForPadding = 40;

  // width of Container inside the Ir Type Widget
  static const double irTypeContainerWidth = 171.75;

  /// width of the ir logo widget
  static const double irLogoWidth = 79;

  /// width of the  company logo image
  static const double companyLogoImageWidth = 80;

  /// width next Course of action widget
  static const double nextCourseOfActionWidgetWidth = 210;

  static const double timeTakenOffWidgetSectionWidth = 210;

  static const double injurySeriousNessQuestionWidth = 210;
  static const double irAreaLineManagerBoxWidth =
      // 200;
      198;
}

class TbIncidentReportPdfColor {
  TbIncidentReportPdfColor._();
  static PdfColor black = PdfColor.fromHex("#000");
  static PdfColor white = PdfColor.fromHex("#fff");

  // static PdfColor incidentReportThemeColor = PdfColor.fromHex("#23a070");

  static PdfColor incidentReportThemeColor = PdfColor.fromHex("#acacac");

  static PdfColor incidentReportGreyColor = PdfColor.fromHex("#cccccc");

  static PdfColor incidentReportTypeTextColor = PdfColor.fromHex("#7f7f7f");
  static PdfColor incidentReportTextlightGreyColor =
      // PdfColor.fromHex("#555555");
      PdfColor.fromHex("#A1A1A1");

  static PdfColor incidentReportImageBackGroundColor =
      PdfColor.fromHex("#c0c0c0");

  static PdfColor incidentReportTextdarkGreyColor =
      // PdfColor.fromHex("#555555");
      PdfColor.fromHex("#666666");
}

/// padding for audit pdf
class TbIrPadding {
  static EdgeInsets defaultPadding = const EdgeInsets.symmetric(horizontal: 20);

  static EdgeInsets paddingLeftRight_20 = const EdgeInsets.only(
    left: 20,
    right: 20,
  );

  // padding for IrDateTime Widget
  static EdgeInsets paddingForIrDateTime = const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 7,
  );

  //padding for user detials widget
  static EdgeInsets paddingForUserDetails = const EdgeInsets.only(
    left: 20,
    right: 25,
    top: 11,
    bottom: 0,
  );

  //padding for location Map Image
  static EdgeInsets paddingForLocationMapImage = const EdgeInsets.only(
    left: 2,
    top: 2,
    right: 2,
    bottom: 4,
  );

  static EdgeInsets paddingForLocationImage = const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 10,
  );

  static EdgeInsets paddingForIrPdfImageRow = const EdgeInsets.only(
    left: 15,
    right: 15,
    top: 10,
    bottom: 10,
  );
  static EdgeInsets headerPadding = const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 25,
  );

  static EdgeInsets irOptionTitleBoxPadding = const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 11.5,
  );

  static EdgeInsets irImageTitlePadding = const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 10,
  );

  /// padding for  ir Option Title Widget
  static EdgeInsets irOptionTitlePadding = const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 8,
  );

  static EdgeInsets irALMBoxPadding = const EdgeInsets.only(
    left: 7,
    top: 10,
    bottom: 10,
  );
}

/* ************************************** */
// INCIDENT REPORT PDF TEXT STYLE
/* ************************************** */
class TbIncidentReportPdfTextStyle {
  // static Font? hurmeNormalFont;
  // static Font? hurmeBoldFont;
  // static Font? arialItalicFont;

  // static Font? hurmeNormalFont;
  // static Font? museoSansItalicFont;
  // static Font? hurmeNormalFont;
  // static Font? hurmeNormalFontBold;
  static Font? hurmeNormalFont;
  static Font? hurmeBoldFont;
  static Font? hurmeLightNormalFont;

  /// this will help us to load fonts only one time.
  static bool loadFontsFlag = true;
  TbIncidentReportPdfTextStyle._();
  static final TbIncidentReportPdfTextStyle _singleton =
      TbIncidentReportPdfTextStyle._();
  factory TbIncidentReportPdfTextStyle() {
    // loadFonts();
    return _singleton;
  }

  static Future<void> loadFonts() async {
    // don't remove this condition
    // its important
    // if (loadFontsFlag == true) {
    //   hurmeNormalFont = Font.ttf(
    //     await rootBundle.load("assets/fonts/HurmeGeometricSans4.ttf"),
    //   );

    //   hurmeBoldFont = Font.ttf(
    //       await rootBundle.load("assets/fonts/HurmeGeometricSans4 Bold.ttf"));

    //   hurmeLightNormalFont = Font.ttf(
    //       await rootBundle.load("assets/fonts/HurmeGeometricSans4 Light.ttf"));

    //   loadFontsFlag = false;
    // }
  }

  ///  style for audit template name
  TextStyle incidentReportTypeTitleStyle() {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: PdfColors.black,
      font: hurmeBoldFont,
    );
  }

  /// style for audit summery table text style
  TextStyle pdfTextStyle_9() {
    return TextStyle(
      fontSize: 9.5,
      fontWeight: FontWeight.bold,
      color: PdfColors.black,
    );
  }

  /// style for audit summery table text style
  TextStyle incidentReportTypeTextStyle() {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: TbIncidentReportPdfColor.incidentReportTypeTextColor,
      font: hurmeBoldFont,
    );
  }

  /// style for incident report
  TextStyle incidentReportTypeTextStyleWhite() {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: PdfColors.white,
      font: hurmeBoldFont,
    );
  }

  TextStyle incidentReportYesNoOptionTextStyle() {
    return TextStyle(
      fontSize: 9.7,
      font: hurmeBoldFont,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle incientReportQuestionTextStyle() {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }

  TextStyle incidentReportForTextInYesAndNoOption() {
    return TextStyle(
      // fontSize: 9.6,
      fontSize: 9.8,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }

  /// textStyle  for project details  related to ms Assessmentde
  TextStyle incidentReportTextStyleWhiteNormal() {
    return TextStyle(
      // fontSize: 9.5,
      fontSize: 10,
      color: PdfColors.white,
      fontWeight: FontWeight.bold,
      font: hurmeNormalFont,
    );
  }

  /// textStyle  for project details  related to ms Assessmentde
  TextStyle incidentReportTextStyleWhiteNormal_9() {
    return TextStyle(
      // fontSize: 9.5,
      fontSize: 9,
      color: PdfColors.white,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }

  TextStyle incidentReportTextStyleWhiteNormal_10() {
    return TextStyle(
      fontSize: 10,
      color: PdfColors.white,
      fontWeight: FontWeight.bold,
      font: hurmeNormalFont,
    );
  }

  TextStyle incidentReportTextStyleNormal_9() {
    return TextStyle(
      fontSize: 9.5,
      color: PdfColors.black,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }

  TextStyle textStyleForIncidentReportPdfFooter() {
    return TextStyle(
        fontSize: 9,
        color: PdfColors.black,
        fontWeight: FontWeight.normal,
        font: hurmeNormalFont);
  }

  TextStyle textStyleIncidentReportUser() {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: TbIncidentReportPdfColor.incidentReportTextlightGreyColor,
      font: hurmeNormalFont,
    );
  }

  TextStyle textStyleIncidentReportUserBold() {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      // color: IncidentReportPdfColor.incidentReportTextlightGreyColor,
      // color: PdfColors.black,
      color: TbIncidentReportPdfColor.incidentReportTextlightGreyColor,
      font: hurmeBoldFont,
    );
  }

  /// textStyle  for company details related to ms Assessment
  TextStyle textStyleForSecondTextInIncidentUser() {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }

  /// textStyle  for company details related to ms Assessment
  TextStyle textStyleForSecondTextInIncidentUserBold() {
    return TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.bold,
      font: hurmeNormalFont,
    );
  }

  /// textStyle  for company details related to ms Assessment
  TextStyle incidentReportCompanyNameTextStyle() {
    return TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }

  /// text style for section name
  TextStyle incidentReportTextStyleBold_12() {
    return TextStyle(
      font: hurmeBoldFont,
      color: PdfColors.black,
      fontSize: 12,
    );
  }

  /// text style for section name
  TextStyle incidentReportTextStyleBold_11() {
    return TextStyle(
      font: hurmeBoldFont,
      color: PdfColors.black,
      fontSize: 11.55,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle pageNumberTextStyle() {
    return TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      font: hurmeNormalFont,
    );
  }

  TextStyle textStyleForInjuredBodyPart() {
    return TextStyle(
      fontSize: 10,
      color: PdfColors.black,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }

  /// textStyle for main Header Entity in ms
  TextStyle textStyleForOptionName() {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }

  /// textStyle for main Header Entity in ms
  TextStyle irTextStyleNormalMuseoFont_9() {
    return TextStyle(
      fontSize: 9.5,
      fontWeight: FontWeight.normal,
      font: hurmeNormalFont,
    );
  }
}
