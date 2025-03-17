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

import '../download_manager/tb_download_manager.dart';

class TbPdfHelper {
  TbPdfHelper._();
  static final TbPdfHelper singleton = TbPdfHelper._();

  final pdf = pw.Document();

  static PdfDocument? pdfDocument;
  static PdfPage? pdfPage;

  // Memory images for various assets
  late MemoryImage checkImage;
  late MemoryImage uncheckImage;
  late MemoryImage raWaterMarkImage;
  late MemoryImage msWaterMarkImage;
  late MemoryImage auditCheckImage;
  late MemoryImage auditUncheckImage;
  late MemoryImage irLogoImage;

  // Theme data for different document types
  late ThemeData raTheme;
  late ThemeData msTheme;
  late ThemeData auditTheme;
  late ThemeData irTheme;

  /* ************************************** */
  // PDF HELPER INITIALIZATION
  /* ************************************** */
  factory TbPdfHelper() {
    if (pdfDocument == null) {
      pdfDocument = PdfDocument();
      pdfPage = PdfPage(
        pdfDocument!,
        pageFormat: const PdfPageFormat(
          29.7 * PdfPageFormat.cm,
          21.0 * PdfPageFormat.cm,
          marginAll: 0,
        ),
      );
    }
    return singleton;
  }

  /* ************************************** */
  // LOAD PDF MEMORY IMAGES AND FONTS
  /* ************************************** */
  Future<void> loadPdfMemoryImages() async {
    try {
      // Load images from base64 strings
      checkImage = loadImageFromBase64(checkBoxString);
      uncheckImage = loadImageFromBase64(unCheckBox);
      raWaterMarkImage = loadImageFromBase64(raWaterMarkString);
      irLogoImage = loadImageFromBase64(irLogoImageString);
      msWaterMarkImage = loadImageFromBase64(raFadeWarkImageString);
      auditCheckImage = loadImageFromBase64(rightCheckBoxString);
      auditUncheckImage = loadImageFromBase64(blankCheckBoxString);

      // Initialize themes with appropriate fonts
      raTheme = ThemeData.withFont(
        base: loadFont(arial_1),
        bold: loadFont(arialBd),
        italic: loadFont(arialItalic),
        fontFallback: [loadFont(hurmeGeometricSans4LightString)],
      );

      msTheme = ThemeData.withFont(
        base: loadFont(arial_1),
        bold: loadFont(arialBd),
        italic: loadFont(arialItalic),
        fontFallback: [loadFont(hurmeGeometricSans4LightString)],
      );

      auditTheme = ThemeData.withFont(
        base: loadFont(museoSansRounded300String),
        bold: loadFont(museoSansRounded900String),
        italic: loadFont(museoSansRoundedItalic300String),
        boldItalic: loadFont(museoSansRounded700String),
        icons: loadFont(hurmeGeometricSans4String),
        fontFallback: [loadFont(hurmeGeometricSans4LightString)],
      );

      irTheme = ThemeData.withFont(
        base: loadFont(museoSansRounded300String),
        bold: loadFont(museoSansRounded700String),
        italic: loadFont(museoSansRounded100),
      );
    } catch (e) {
      print("Error loading PDF assets: $e");
      throw Exception("Failed to load PDF assets");
    }
  }

  /* ************************************** */
  // GET TEXT FOR INCIDENT REPORT TYPE
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

  /* ************************************** */
  // CALCULATE HEIGHT OF WIDGET
  /* ************************************** */
  double calculateHeightOfWidget({
    required Widget widget,
    required double width,
  }) {
    if (pdfPage == null || pdfDocument == null) return 0;

    final canvas = pdfPage!.getGraphics();
    canvas.reset();

    final calculatedTheme = pw.ThemeData.base();
    final context = Context(
      document: pdfDocument!,
      page: pdfPage,
      canvas: canvas,
    ).inheritFromAll(<Inherited>[
      calculatedTheme,
      const InheritedDirectionality(TextDirection.ltr),
    ]);

    widget.layout(context, pw.BoxConstraints(minWidth: width, maxWidth: width));

    PdfRect? rect = widget.box;
    return rect?.height ?? 0;
  }

  /* ************************************** */
  // TEXT STYLE GENERATOR
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
      decoration: textDecoration,
    );
  }

  /* ************************************** */
  // PAGE THEME GENERATOR
  /* ************************************** */
  pw.PageTheme returnPageTheme({
    required MemoryImage waterMarkImage,
    PageOrientation? pageOrientation,
    PdfPageFormat? pageFormat,
    ThemeData? themeData,
    required int isSubscribed,
  }) {
    return pw.PageTheme(
      theme: themeData,
      clip: true,
      orientation: pageOrientation,
      pageFormat: pageFormat,
      buildForeground: (context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: isSubscribed == 1
              ? Container()
              : pw.Watermark(
                  fit: BoxFit.fill,
                  child: Image(waterMarkImage),
                ),
        );
      },
      buildBackground: (context) => Container(),
    );
  }

  /* ************************************** */
  // GENERATE MEMORY IMAGE
  /* ************************************** */
  Future<pw.MemoryImage?> generateMemoryImageForPath(String path) async {
    if (path.isEmpty) {
      return null;
    }

    try {
      if (path.startsWith("http")) {
        return await TbDownloadManager.downloadMemoryImage(urlPath: path);
      } else {
        final file = File(path);
        final imageBytes = await file.readAsBytes();
        return pw.MemoryImage(imageBytes);
      }
    } catch (e) {
      print("Error generating memory image for path $path: $e");
      return null;
    }
  }

  /* ************************************** */
  // FONT AND IMAGE UTILITIES
  /* ************************************** */
  Uint8List decodeFont(String fontBase64) {
    return base64Decode(fontBase64);
  }

  pw.Font loadFont(String fontBase64) {
    final fontData = decodeFont(fontBase64);
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  MemoryImage loadImageFromBase64(String imageString) {
    Uint8List bytes = base64Decode(imageString);
    return MemoryImage(bytes);
  }
}
