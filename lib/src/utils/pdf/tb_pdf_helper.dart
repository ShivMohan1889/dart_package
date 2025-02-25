import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_pdf_package/src/ir/dto/incident_report_dto.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/incident_report_enum.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/arial.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/arial_1.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/arial_italic.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/hurme_geomatric_sans4.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/hurme_geomatric_sans4_light.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/museo_sans_rounded_100.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/museo_sans_rounded_300.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/museo_sans_rounded_700.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/museo_sans_rounded_900.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/fonts/museo_sans_rounded_italic_900.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/images/blank_checkbox.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/images/check_box.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/images/ir_logo.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/images/ra_fade_water_image.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/images/ra_watermark.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/images/right_checkbox.dart';
import 'package:dart_pdf_package/src/utils/pdf/assets/images/uncheck_box.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

import '../date/tb_date_time.dart';
import '../download_manager/tb_download_manager.dart';
import '../enums/enum/locale_type.dart';

class TbPdfHelper {
  TbPdfHelper._();
  static final TbPdfHelper singleton = TbPdfHelper._();

  final pdf = pw.Document();

  static PdfDocument? pdfDocument;

  static final directoryPath = '/';

  /// page that will help us to calculate height and other stuff
  static PdfPage? pdfPage;

  late MemoryImage checkImage;
  late MemoryImage uncheckImage;
  late MemoryImage raWaterMarkImage;
  late MemoryImage msWaterMarkImage;
  late MemoryImage auditCheckImage;
  late MemoryImage aduitUncheckImage;
  late ThemeData raTheme;
  late ThemeData msTheme;
  late ThemeData auditTheme;
  late MemoryImage irLogoImage;

  late ThemeData irTheme;

  /* ************************************** */
  // PDF HELPER

  /// creates only one instance of the PdfDocument and a pdf page
  /// call this to create instance
  /* ************************************** */
  factory TbPdfHelper() {
    if (pdfDocument == null) {
      var aPdfDocument = PdfDocument();
      pdfDocument = aPdfDocument;

      pdfPage = PdfPage(
        aPdfDocument,
        pageFormat: const PdfPageFormat(
          29.7 * PdfPageFormat.cm,
          21.0 * PdfPageFormat.cm,
          marginAll: 0,
        ),
      );
    }

    return singleton;
  }

  Future<void> loadPdfMemoryImages() async {
    checkImage = loadImageFromBase64(checkBoxString);
    uncheckImage = loadImageFromBase64(unCheckBox);
    raWaterMarkImage = loadImageFromBase64(raWaterMarkString);

    irLogoImage = loadImageFromBase64(irLogoImageString);

    raTheme = ThemeData.withFont(
      base: loadFont(arial_1),
      bold: loadFont(arialBd),
      italic: loadFont(arialItalic),
      fontFallback: [
        loadFont(hurmeGeometricSans4LightString),
      ],
    );

    msWaterMarkImage = loadImageFromBase64(raFadeWarkImageString);

    msTheme = ThemeData.withFont(
      base: loadFont(arial_1),
      bold: loadFont(arialBd),
      italic: loadFont(arialItalic),
      fontFallback: [
        loadFont(hurmeGeometricSans4LightString),
      ],
    );

    auditCheckImage = loadImageFromBase64(rightCheckBoxString);

    aduitUncheckImage = loadImageFromBase64(blankCheckBoxString);

    // here we are creating a theme for fonts
    auditTheme = ThemeData.withFont(
      base: loadFont(museoSansRounded300String),
      bold: loadFont(museoSansRounded900String),
      italic: loadFont(museoSansRoundedItalic300String),
      boldItalic: loadFont(museoSansRounded700String),
      icons: loadFont(hurmeGeometricSans4String),
      fontFallback: [
        loadFont(hurmeGeometricSans4LightString),
      ],
    );

    // here we are creating a theme for fonts
    irTheme = ThemeData.withFont(
      base: loadFont(museoSansRounded300String),
      bold: loadFont(museoSansRounded700String),
      italic: loadFont(museoSansRounded100),
    );
  }

  static Future<void> saveImageToFile(
      MemoryImage image, String fileName) async {
    // Get the directory for storing files
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = "/Users/shivmohansingh/Desktop";

    // Create a file in the directory
    File file = File('$appDocPath/$fileName');

    // Write the raw byte data to the file
    await file.writeAsBytes(image.bytes);

    print("Image saved at: ${file.path}");
  }

  /* ************************************** */
  // RETURN TEXT FOR INCIDENT REPORT TYPE
  /// this method is responsible for returning the text for
  /// the given [incidentReportEntity.reportingType]
  /* ************************************** */
  String returnTextForIncidentReportType({
    required IncidentReportDto? incidentReportEntity,
    required String injuryTypeText,
    required String illHealthTypeText,
    required String nearMissType,
  }) {
    var reportType = incidentReportEntity?.reportingType ?? 0;
    switch (reportType) {
      case IncidentReport.injuryType:
        return injuryTypeText;

      case IncidentReport.illHealthType:
        return illHealthTypeText;

      case IncidentReport.nearMissType:
        return nearMissType;

      default:
        return "";
    }
  }

  // /* ************************************** */
  // CALCULATE HEIGHT OF THE TEXT

  /// return height of the given[text] for given [width]
  /// for the specified [textStyle]
  /* ************************************** */
  double calculateHeight({
    required String text,
    required double width,
    required pw.TextStyle textStyle,
  }) {
    // gets the canvas from the pdfPage we have created earlier while initiating class
    final canvas = pdfPage?.getGraphics();
    canvas?.reset();

    final calculatedTheme = pw.ThemeData.base();

    // create a Context taht will be used to calculate height
    final context = Context(
      document: pdfDocument!,
      page: pdfPage,
      canvas: canvas,
    ).inheritFromAll(<Inherited>[
      calculatedTheme,
      const InheritedDirectionality(TextDirection.ltr),
    ]);

    // create a text widget that will have the text you want to draw and layout it
    // its imoprtant to call layout method as without this height and width will
    // not be calcualted

    pw.Text textWidget = pw.Text(text, style: textStyle)
      ..layout(context, pw.BoxConstraints(minWidth: width, maxWidth: width));

    // rect of the drawn text
    PdfRect? rect = textWidget.box;
    if (rect != null) {
      return rect.height;
    } else {
      return 0;
    }
  }

  double calculateHeightOfWidget({
    required Widget widget,
    required double width,
  }) {
    // gets the canvas from the pdfPage we have created earlier while initiating class
    final canvas = pdfPage?.getGraphics();
    canvas?.reset();

    final calculatedTheme = pw.ThemeData.base();

    // create a Context taht will be used to calculate height
    final context = Context(
      document: pdfDocument!,
      page: pdfPage,
      canvas: canvas,
    ).inheritFromAll(<Inherited>[
      calculatedTheme,
      const InheritedDirectionality(TextDirection.ltr),
    ]);

    // create a text widget that will have the text you want to draw and layout it
    // its imoprtant to call layout method as without this height and width will
    // not be calcualted

    widget.layout(context, pw.BoxConstraints(minWidth: width, maxWidth: width));

    // rect of the drawn text
    PdfRect? rect = widget.box;
    if (rect != null) {
      return rect.height;
    } else {
      return 0;
    }
  }

  /* ************************************** */
  // FIND PREVIOUS SPACE

  ///finds the first index for given string[str] at or before given [index]
  // we don't want words to split, so we find first space before the given
  // index and split it from that index
  /* ************************************** */
  int findPreviousSpace(String str, int index) {
    for (var i = --index; i > 0; i--) {
      if (" " == str[i]) {
        return i;
      }
    }
    return index;
  }

  /* ************************************** */
  // FIND NEXT SPACE

  ///finds the first index for given string[str] at or before given [index]
  // we don't want words to split, so we find first space before the given
  // index and split it from that index
  /* ************************************** */
  int findNextSpace(String str, int index) {
    for (var i = index + 1; i < str.length; i++) {
      var char = str[i];
      if (" " == char || "\n" == char) {
        return i;
      }
    }
    return str.length;
  }

  /* ************************************** */
  // DIVIDER

  /// draw a divider for given [height] and [width]
  /* ************************************** */
  pw.Widget divider({double? height, double? width, PdfColor? color}) {
    return pw.LayoutBuilder(
      builder: ((context, constraints) => pw.Container(
            color: color ?? PdfColors.black,
            height: height ??
                (constraints?.hasInfiniteHeight == true
                    ? constraints?.maxHeight
                    : 0),
            width: width ??
                (constraints?.hasInfiniteWidth == true
                    ? constraints?.maxHeight
                    : 0),
          )),
    );
  }

  /* ************************************** */
  // ASSETS IMAGE
  /// generate image for the given [imageName] takes
  /// as assets path generate image by passing it to rootbundle.load method
  /* ************************************** */
  Future<pw.MemoryImage> image({required String imagePath}) async {
    final file = File(imagePath);
    final imageBytes = await file.readAsBytes();

    // Create a MemoryImage using the bytes
    pw.MemoryImage provider = pw.MemoryImage(imageBytes);
    return provider;
  }

  /* ************************************** */
  //  IMAGE
  /// generate image for the given [imageName] in this we
  /// encode the image path
  /* ************************************** */

  // Future<pw.MemoryImage?> image(String imageName) async {
  //   try {
  //     if (TbFileManager.fileExists(imageName)) {
  //       MemoryImage provider = pw.MemoryImage(
  //         await TbFileManager.fileBytes(imageName),
  //       );
  //       return provider;
  //     } else {
  //       return null;
  //     }
  //   } catch (e, stacktrace) {
  //     LogManager.error(
  //       className: "pdf_helper",
  //       message: e.toString() + stacktrace.toString(),
  //       methodName: "image",
  //       obj: e,
  //       stacktrace: stacktrace,
  //     );
  //     return null;
  //   }
  // }

  /* ****************************/
  //   USER SIGNATURE PATH
  /// generate user signature path for the given[userEntity]
  /// and return memory image of it
  /*  ************************* */

  // Future<pw.MemoryImage?> userSignaturePath({
  //   required UserDto? userEntity,
  // }) async {
  //   MemoryImage? signatureImage;

  //   if ((userEntity?.signature ?? "").isNotEmpty) {
  //     String signatureImagePath =
  //         (userEntity?.signature ?? "").replaceAll(".png", "");

  //     String userSignaturePath =
  //         TbFileManager.userSignaturePath(uniqueKey: signatureImagePath);

  //     if (TbFileManager.fileExists(userSignaturePath)) {
  //       signatureImage = await image(userSignaturePath);
  //     }
  //   }
  //   return signatureImage;
  // }

  // /* ************************************** */
  // //   RETURN  COMPANY LOGO IMAGE
  // /// generat the company logo image path and return memory image of it
  // /* ************************************** */

  // Future<pw.MemoryImage?> returnCompanyLogoImage({
  //   required CompanyDto companyDto,
  // }) async {
  //   MemoryImage? companyLogoImage;

  //   if ((companyDto?.companyLogo ?? "").isNotEmpty) {
  //     String companyLogoPath = TbFileManager.companyLogoPath(
  //       name: companyDto?.companyLogoImageName ?? "",
  //     );

  //     companyLogoImage = await TbPdfHelper().image(companyLogoPath);
  //   }
  //   return companyLogoImage;
  // }

  /* ************************************** */
  // TextStyleGenerator method

  ///
  /* ************************************** */
  pw.TextStyle textStyleGenerator({
    Font? font,
    double? fontSize,
    PdfColor? color,
    TextDecoration? textDecoration,
  }) {
    return pw.TextStyle(
      fontSize: fontSize ?? 10,
      color: color ?? PdfColors.black,
      font: font,
      // decoration: textDecoration ?? TextDecoration.none,

      decoration: textDecoration,
    );
  }

  /* ************************************* / 
  // RETURN PAGE THEME 
  ///this method is responsible for showing the given [memoryImage] 
  ///as watermark on pdf 
  / ************************************* */
  pw.PageTheme returnPageTheme({
    required MemoryImage waterMarkImage,
    PageOrientation? pageOrientation,
    PdfPageFormat? pageFormat,
    ThemeData? themeData,

    /// if this isSubcribed is equal to 1 then we not should the watermark on the pdf
    required int isSubcribed,
  }) {
    ThemeData.withFont();

    return pw.PageTheme(
      theme: themeData,
      clip: true,
      orientation: pageOrientation,
      pageFormat: pageFormat,
      buildForeground: (context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: isSubcribed == 1
              ? Container()
              : pw.Watermark(
                  fit: BoxFit.fill,
                  child: Image(
                    waterMarkImage,
                  ),
                ),
        );
      },
      buildBackground: (context) {
        return Container();
      },
    );
  }

  /// ***********************************
  ///   GENERATE MEMORY IMAGE FOR PATH
  ///
  ///
  /// ***********************************
  Future<pw.MemoryImage?> generateMemoryImageForPath(String path) async {
    if (path.isEmpty) {
      return null;
    }
    if (path.contains("http")) {
      return await TbDownloadManager.downloadFile(urlPath: path);
    } else {
      return await image(imagePath: path);
    }
  }

  /* ************************************* / 
  // DATE STRING FOR LOCALE  IN PDF
  
  ///this method is responsible returns string on based of locale in pdf
 / ************************************* */
  static String dateStringForLocaleInPdf({
    required String date,
    required String localeName,
  }) {
    if (date.isNotEmpty) {
      if (localeName == RaLocaleType.enUS) {
        DateTime dateTime = TbDateTime.inputFormat.parse(date);

        String enINDate = TbDateTime.inputFormatForEnUs.format(dateTime);

        return enINDate;
      } else {
        return date;
      }
    } else {
      return date;
    }
  }

  Uint8List decodeFont(String fontBase64) {
    return base64Decode(fontBase64);
  }

  pw.Font loadFont(String fontBase64) {
    final fontData = decodeFont(fontBase64);
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  MemoryImage loadImageFromBase64(String imageString) {
    // Decode the Base64 string to bytes
    Uint8List bytes = base64Decode(imageString);

    // Create and return a MemoryImage from the bytes
    return MemoryImage(bytes);
  }
}
