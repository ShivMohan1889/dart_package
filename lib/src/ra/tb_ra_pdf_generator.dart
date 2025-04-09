import 'dart:typed_data';

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_sign_off_section.dart';
import 'package:dart_pdf_package/src/ra/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/enums/ra_pdf_title_type.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'widgets/assessment_image_section.dart';
import 'widgets/hazard_table_row.dart';
import 'widgets/map_image_row.dart';
import 'widgets/ra_footer_row.dart';
import 'widgets/ra_header_row.dart';
import 'widgets/ra_map_header_row.dart';

/// Class that handles PDF generation for Risk assessment
/// Takes a prepared RaPdfData and generates a PDF document
class TbRaPdfGenerator {
  TbRaPdfGenerator({
    required this.pdfData,
    required this.pdfHelper,
    this.pdfDocumentFromMs,
    required this.showMsFirst,
  });

  /// The PDF model containing all prepared data for PDF generation
  final RaPdfData pdfData;

  Document? pdfDocumentFromMs;
  TbPdfHelper pdfHelper;
  bool showMsFirst;

  /// For tracking page state
  RaPdfData? lastAssessmentForHeader;
  RaPdfData? lastAssessmentForFooter;

  /// PDF generation state variables
  double remainingHeight = TbRaPdfSectionHeights.FIRST_PAGE_HEIGHT;
  List<TbHazardRowModel> hazardRows = [];

  // Store pages' header and footer widgets
  final Map<int, Widget> headerWidgets = {};
  final Map<int, RaFooterRow> footerWidgets = {};

  /* ************************************** */
  // GENERATE PDF
  /* ************************************** */
  Future<Uint8List?> generatePDF() async {
    Document pdf = Document();
    if (pdfDocumentFromMs != null) {
      pdf = pdfDocumentFromMs!;
    }

    // Handle MS assessment if present and if showMsFirst is true
    if (showMsFirst && pdfData.msPdfData != null) {
      // Generate MS PDF first
      TbMsPdfGenerator msPdfGenerator = TbMsPdfGenerator(
        pdfData: pdfData.msPdfData!,
        pdfDocumentFromRa: pdf,
        pdfHelper: pdfHelper,
        showMsFirst: showMsFirst,
      );
      await msPdfGenerator.generatePDF();
    }

    List<RaPdfData> l = [];

    l.add(pdfData);
    l.addAll(pdfData.listChildren ?? []);

    // here we are calling generatePDf method for each entity

    // for (RaPdfData raEntity in l) {
    //   await  preparePDFImages(
    //     raEntity,
    //   );

    //   generatePdfFor(
    //     pdf: pdf,
    //     riskAssessmentModel: raEntity,
    //   );
    // }
    await Future.forEach(l, (raEntity) async {
      RaPdfData raData = raEntity as RaPdfData;

      await preparePDFImages(raData);
      generatePdfFor(
        pdf: pdf,
        riskAssessmentModel: raEntity,
      );
    });

    // headerWidgets.clear();
    // footerWidgets.clear();
    // Handle MS assessment if present and if showMsFirst is false
    if (!showMsFirst && pdfData.msPdfData != null) {
      TbMsPdfGenerator msPdfGenerator = TbMsPdfGenerator(
        pdfData: pdfData.msPdfData!,
        pdfDocumentFromRa: pdf,
        pdfHelper: pdfHelper,
        showMsFirst: showMsFirst,
      );
      await msPdfGenerator.generatePDF();
    }

    // Return the PDF data if not from MS
    if (pdfDocumentFromMs == null) {
      return await pdf.save();
    } else {
      return null;
    }
  }

  /* ************************************** */
  // Generate PDF for a specific risk assessment
  /* ************************************** */
  void generatePdfFor({
    required pw.Document pdf,
    required RaPdfData riskAssessmentModel,
  }) {
    bool isFirstTimeFooter = true;
    bool isFirstTimeHeader = true;

    // Reset for new assessment
    hazardRows.clear();
    remainingHeight = TbRaPdfSectionHeights.FIRST_PAGE_HEIGHT;

    // Prepare hazard rows for PDF rendering
    createHazardRows(riskAssessmentModel);

    // Add the main assessment page
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pdfHelper.returnPageTheme(
          isSubscribed: riskAssessmentModel.isSubscribed ?? 0,
          pageFormat: const PdfPageFormat(
            29.7 * PdfPageFormat.cm,
            21.0 * PdfPageFormat.cm,
            marginAll: 0,
          ),
          themeData: pdfHelper.raTheme,
          pageOrientation: PageOrientation.landscape,
          waterMarkImage: pdfHelper.raWaterMarkImage,
        ),
        build: (Context context) {
          return buildHazardTableRows(
            hazardRows: hazardRows,
            riskAssessmentModel: riskAssessmentModel,
          );
        },
        header: (context) {
          final pageNo = context.pageNumber;

          print(riskAssessmentModel.name);
          print(isFirstTimeHeader);

          // Return cached header if it exists
          if (headerWidgets.containsKey(pageNo)) {
            return headerWidgets[pageNo]!;
          } else {
            var pNO = context.pageNumber;
            if (isFirstTimeHeader == true) {
              isFirstTimeHeader = false;
              pNO = 1;
            }

            Widget h = RaHeaderRow(
              raPdfData: riskAssessmentModel,
              pageNo: pNO,
              pdfHelper: pdfHelper,
            );

            // Cache the header
            headerWidgets[pageNo] = h;
            return h;
          }

          // Create new header
        },
        footer: (context) {
          final pageNo = context.pageNumber;

          // Return cached footer if it exists
          if (footerWidgets.containsKey(pageNo)) {
            RaFooterRow f = footerWidgets[pageNo]!;
            f.pageNoToRender = pageNo;
            return f;
          } else {
            var pNO = context.pageNumber;
            if (isFirstTimeFooter == true) {
              isFirstTimeFooter = false;
              pNO = 1;
            }

            // Create new footer
            RaFooterRow footer = RaFooterRow(
              pageNo: pNO,
              pdfData: riskAssessmentModel,
              isSignOffFooter: false,
            );
            footer.pageNoToRender = pageNo;

            // Cache the footer
            footerWidgets[pageNo] = footer;
            return footer;
          }
        },
      ),
    );

    // Add additional pages for images, maps, sign-offs
    addAssessmentImagePages(
      pdf: pdf,
      riskAssessmentModel: riskAssessmentModel,
    );

    addReferenceImagePages(
      pdf: pdf,
      riskAssessmentModel: riskAssessmentModel,
    );

    addMapInfoPage(
      riskAssessmentModel: riskAssessmentModel,
      pdf: pdf,
    );

    addSignOffPages(
      pdfData: riskAssessmentModel,
      pdf: pdf,
    );
  }

  /* ************************************** */
  // CREATE SIGN OFF ROWS
  ///
  /* ************************************** */
  void addSignOffPages({
    required RaPdfData pdfData,
    required pw.Document pdf,

    // required Context context,
  }) {
    pdf.addPage(
      pw.MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          waterMarkImage: pdfHelper.raWaterMarkImage,
          pageFormat: const PdfPageFormat(
            29.7 * PdfPageFormat.cm,
            21.0 * PdfPageFormat.cm,
            marginAll: 0,
          ),
          isSubscribed: pdfData.isSubscribed,
          pageOrientation: PageOrientation.landscape,
          themeData: pdfHelper.raTheme,
        ),
        build: (context) {
          return returnSignOffWidgetList(
            context: context,
            raPdfData: pdfData,
          );
        },
        header: (context) {
          return RaHeaderRow(
            headerForSignOff: true,
            pdfHelper: TbPdfHelper(),
            raPdfData: pdfData,
            pageNo: context.pageNumber,
          );
        },
        footer: (context) {
          return Container(
            padding: EdgeInsets.only(
              // bottom: 15,
              bottom: 15,

              right: 20,
            ),
            alignment: Alignment.bottomRight,
            child: Text(
              "Page No: ${context.pageNumber}${(pdfData.referenceNumber ?? "").isNotEmpty ? '/${pdfData.referenceNumber}' : ''}",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontItalic,
                color: TbRaPdfColors.black,
                fontSize: 8,
              ),
            ),
          );
          // return RaFooterRow(
          //   pageNoToRender: context.pageNumber,
          //   pageNo: context.pageNumber,
          //   isSignOffFooter: true,
          //   pdfData: pdfData,
          // );
        },
      ),
    );
  }

  List<Widget> returnSignOffWidgetList({
    required RaPdfData raPdfData,
    required Context context,
  }) {
    List<Widget> list = List.empty(growable: true);

    List<Widget> rowChildren = [];

    if ((raPdfData.signOffUsers ?? []).isNotEmpty) {
      list.add(
        signOffPageHeading(
          context: context,
          pdfData: raPdfData,
        ),
      );
    }

    for (ReviewSignOffSignatureData user in raPdfData.signOffUsers ?? []) {
      rowChildren.add(
        Container(
          height: (TbRaPdfSectionHeights.SIGN_OFF_PAGE_HEIGHT - 40) / 2,
          width: (TbRaPdfWidth.pageWidth) / 3,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Container(
                child: MsSignOffSection(
                  user: user,
                ),
              ),
            ),
          ),
        ),
      );
      if (rowChildren.length == 3) {
        list.add(createSignOffRow(rowChildren));
        rowChildren.clear();
      } else if (raPdfData.signOffUsers?.last == user) {
        list.add(createSignOffRow(rowChildren));
        rowChildren.clear();
      }
    }

    return list;
  }

/* ************************************** */
  // SIGN OFF PAGE HEADING
  /* ************************************** */
  Widget signOffPageHeading({
    required RaPdfData pdfData,
    required Context context,
  }) {
    return Container(
      padding: TbRaPdfPaddings.pageHorizontalPadding,
      width: double.infinity,
      height: 30,
      child: Center(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            pdfData.signOffStatementReport,
            // style: raPdfTextStyles.boldBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              color: PdfColors.black,
              font: Theme.of(context).header0.fontBold,
              fontSize: 9,
            ),
          ),
        ),
      ),
    );
  }

  /* ************************************** */
  // CREATE SIGN OFF ROW
  ///
  /* ************************************** */
  Widget createSignOffRow(List<Widget> children) {
    List<Widget> l = List.empty(growable: true);
    l.addAll(children);
    var row = pw.Padding(
      padding: pw.EdgeInsets.zero,
      child: pw.Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: l,
      ),
    );
    return row;
  }

  /* ************************************** */
  // CREATE HAZARD ROWS
  /* ************************************** */
  void createHazardRows(RaPdfData riskAssessmentModel) {
    // Process each hazard in the model
    for (HazardPdfModel hazard in riskAssessmentModel.hazards) {
      // Create hazard row
      TbHazardRowModel row = TbHazardRowModel(
        name:
            '${hazard.name}${(hazard.harm ?? "").isNotEmpty ? "\n(${hazard.harm})" : ""}',
        gridRef: hazard.cellPosition,
        worstCase: hazard.worstCase,
        likelihood: hazard.likelihoods,
        additionalLikelihood: hazard.additionalLikelihood,
        score: hazard.score.toString(),
        rating: hazard.rating,
        additionalRating: hazard.additionalRating,
        additionalScore: hazard.additionalScore?.toString() ?? "0",
        controlInPlace: (hazard.existingControls ?? []).isNotEmpty
            ? joinControlsText(hazard.existingControls ?? [])
            : "",
        additionalControl: hazard.additionalControls != null
            ? joinControlsText(hazard.additionalControls!)
            : "",
      );

      // Calculate row height
      var tableRow = HazardTableRow(
        row: row,
        isStandard: riskAssessmentModel.assessmentType ?? 0,
      );

      double rowHeight = pdfHelper.calculateHeightOfWidget(
        widget: tableRow,
        width: TbRaPdfWidth.pageWidth,
      );
      row.height = rowHeight;

      // Process for page breaks
      processRowForPages(row, riskAssessmentModel);
    }
  }

  // Helper to join control text strings with proper formatting
  String joinControlsText(List<String> controls) {
    if (controls.isEmpty) return "";

    String result = controls.join("\n...\n...");

    // Remove trailing line breaks if needed
    if (result.endsWith("\n...\n...")) {
      result = result.substring(0, result.length - 8);
    }

    return result;
  }

  /* ************************************** */
  // PROCESS ROWS FOR PAGE BREAKS
  /* ************************************** */
  void processRowForPages(TbHazardRowModel row, RaPdfData riskAssessmentModel) {
    // Check if row fits in current page
    // Check if remaining space is at least 120% of what the row needs
    // if (remainingHeight < (row.height * 1.1)) {
    //   remainingHeight = TbRaPdfSectionHeights.SECOND_PAGE_HEIGHT;
    // }

    if (remainingHeight < 19) {
      // Minimum threshold
      remainingHeight = TbRaPdfSectionHeights.SECOND_PAGE_HEIGHT;
    }

    if (row.height > remainingHeight) {
      // Split the row if it doesn't fit
      var splitRows = splitHazardRow(
          row: row,
          maxHeight: remainingHeight,
          riskAssessmentModel: riskAssessmentModel);

      hazardRows.add(splitRows.first);

      if (splitRows.length == 2) {
        remainingHeight = TbRaPdfSectionHeights.SECOND_PAGE_HEIGHT;
        processRowForPages(splitRows.last, riskAssessmentModel);
      }
    } else {
      // Add row and update remaining height
      hazardRows.add(row);
      remainingHeight -= row.height;
    }
  }

  /* ************************************** */
  // SPLIT HAZARD ROW
  /* ************************************** */
  List<TbHazardRowModel> splitHazardRow({
    required TbHazardRowModel row,
    required double maxHeight,
    required RaPdfData riskAssessmentModel,
  }) {
    // Split text fields to fit maxHeight
    int nameIndex = splitText(
      text: row.name,
      maxHeight: maxHeight,
      height: row.height,
      riskAssessmentModel: riskAssessmentModel,
    );

    int controlIndex = splitText(
        text: row.controlInPlace,
        maxHeight: maxHeight,
        height: row.height,
        riskAssessmentModel: riskAssessmentModel);

    int additionalControlIndex = splitText(
      text: row.additionalControl ?? "",
      maxHeight: maxHeight,
      height: row.height,
      riskAssessmentModel: riskAssessmentModel,
    );

    // Create second row to hold overflow content
    TbHazardRowModel second = TbHazardRowModel(
      rating: row.rating,
      score: row.score,
      additionalRating: row.additionalRating,
      additionalScore: row.additionalScore,
      name: "",
      gridRef: "",
      worstCase: "",
      likelihood: "",
      // gridRef: row.gridRef,
      // worstCase: row.worstCase,
      // likelihood: row.likelihood,
      // additionalLikelihood: row.additionalLikelihood,
      additionalLikelihood: '',

      controlInPlace: "",
      additionalControl: "",
    );

    // Split content between rows
    if (nameIndex > 0) {
      String part1 = row.name.substring(0, nameIndex);
      String part2 = row.name.substring(nameIndex);
      row.name = part1;
      second.name = part2;
      second.splitItemScore = row.score;
    }

    if (controlIndex > 0) {
      String part1 = row.controlInPlace.substring(0, controlIndex).trim();
      String part2 = row.controlInPlace.substring(controlIndex).trim();
      row.controlInPlace = part1;
      second.controlInPlace = part2;
      second.splitItemScore = row.score;
    }

    if (additionalControlIndex > 0) {
      String part1 = (row.additionalControl ?? "")
          .substring(0, additionalControlIndex)
          .trim();
      String part2 = (row.additionalControl ?? "")
          .substring(additionalControlIndex)
          .trim();
      row.additionalControl = part1;
      second.additionalControl = part2;
      second.splitItemAdditionalScore = row.additionalScore;
    }

    // Mark both rows as split
    if (nameIndex > 0 || controlIndex > 0 || additionalControlIndex > 0) {
      row.isSplitHazard = 1;
      second.isSplitHazard = 1;

      // Recalculate row heights
      var firstRowWidget = HazardTableRow(
        row: row,
        isStandard: riskAssessmentModel.assessmentType ?? 0,
      );
      row.height = pdfHelper.calculateHeightOfWidget(
          widget: firstRowWidget, width: TbRaPdfWidth.pageWidth);

      var secondRowWidget = HazardTableRow(
        row: second,
        isStandard: riskAssessmentModel.assessmentType ?? 0,
      );
      second.height = pdfHelper.calculateHeightOfWidget(
          widget: secondRowWidget, width: TbRaPdfWidth.pageWidth);

      return [row, second];
    } else {
      return [row];
    }
  }

  int splitText({
    required RaPdfData riskAssessmentModel,
    required String text,
    required double maxHeight,
    required double height,
  }) {
    if (text.isEmpty) return 0;

    // Split the text into words
    List<String> words = text.split(' ');
    if (words.isEmpty) return 0;

    // Start with an empty string and add words one by one
    String currentText = "";
    int lastGoodIndex = 0;

    for (int i = 0; i < words.length; i++) {
      // Add the next word (with space if not the first word)
      String nextWord = words[i];
      String testText =
          currentText.isEmpty ? nextWord : "$currentText $nextWord";

      // Measure height of current text plus this word
      double testHeight = measureTextHeight(testText, riskAssessmentModel);

      // Check if adding this word exceeds the max height
      if (testHeight > maxHeight) {
        // If this is the first word and it doesn't fit, we need to split within the word
        if (i == 0) {
          return findSplitPositionInWord(
              words[0], maxHeight, riskAssessmentModel);
        }

        // Otherwise return the position after the last good word
        return lastGoodIndex;
      }

      // This word fits, so update state
      currentText = testText;
      lastGoodIndex = text.indexOf(' ', lastGoodIndex + 1);
      if (lastGoodIndex < 0) {
        // We've reached the end of the text
        return text.length;
      }
    }

    // If we get here, all words fit
    return text.length;
  }

// Helper method to split within a word if the first word is too long
  int findSplitPositionInWord(
      String word, double maxHeight, RaPdfData riskAssessmentModel) {
    // Binary search to find how many characters of this word will fit
    int low = 1; // At least one character
    int high = word.length;
    int best = 0;

    while (low <= high) {
      int mid = (low + high) ~/ 2;
      String subWord = word.substring(0, mid);

      double height = measureTextHeight(subWord, riskAssessmentModel);

      if (height <= maxHeight) {
        // This fits, try to fit more
        best = mid;
        low = mid + 1;
      } else {
        // Too big, try less
        high = mid - 1;
      }
    }

    return best;
  }

  /* ************************************** */
  // FIND PREVIOUS SPACE
  /* ************************************** */
  int findPreviousSpace(String text, int index) {
    if (index >= text.length) index = text.length - 1;
    if (index <= 0) return 0;

    while (index > 0 && text[index] != ' ') {
      index--;
    }

    return index;
  }

  /* ************************************** */
  // MEASURE TEXT HEIGHT
  /* ************************************** */
  double measureTextHeight(String text, RaPdfData model) {
    TbHazardRowModel tempRow = TbHazardRowModel(
      name: "",
      gridRef: "",
      worstCase: "",
      likelihood: "",
      additionalLikelihood: "",
      score: "",
      rating: "",
      additionalRating: "",
      additionalScore: "",
      controlInPlace: text,
      additionalControl: "",
    );

    var tableRow = HazardTableRow(
      row: tempRow,
      isStandard: model.assessmentType ?? 0,
    );

    return pdfHelper.calculateHeightOfWidget(
        widget: tableRow, width: TbRaPdfWidth.pageWidth);
  }

  /* ************************************** */
  // BUILD HAZARD TABLE ROWS
  /* ************************************** */
  List<pw.Widget> buildHazardTableRows({
    required List<TbHazardRowModel> hazardRows,
    required RaPdfData riskAssessmentModel,
  }) {
    List<pw.Widget> tableWidgets = [];

    for (var row in hazardRows) {
      tableWidgets.add(
        HazardTableRow(
          row: row,
          isStandard: riskAssessmentModel.assessmentType ?? 0,
        ),
      );
    }

    return tableWidgets;
  }

  /* ************************************** */
  // ADD ASSESSMENT IMAGE PAGES
  /* ************************************** */
  void addAssessmentImagePages({
    required RaPdfData riskAssessmentModel,
    required Document pdf,
  }) {
    List<Widget> imageWidgets = [];
    List<AssessmentImagePdfModel> images =
        riskAssessmentModel.assessmentImages ?? [];

    if (images.isEmpty) return;

    // Process selected images first
    var selectedImages = images.where((img) => img.isSelected == 1);

    var count = 1;
    for (var image in selectedImages) {
      if (image.memoryImage != null) {
        imageWidgets.add(
          AssessmentImageSection(
            // pdfData: pdfData,
            pdfData: riskAssessmentModel,
            logoImage: riskAssessmentModel.companyLogoMemoryImage,
            isSelected: image.isSelected,
            image: image.memoryImage!,
            opacity: riskAssessmentModel.hazardIconOpacity,
            index: count++,
            raPdfPageTitleType: RaPdfPageTitleType.assessmentImage,
          ),
        );
      }
    }

    // Process unselected images
    var unselectedImages = images.where((img) => img.isSelected == 0);

    for (var image in unselectedImages) {
      if (image.memoryImage != null) {
        imageWidgets.add(
          AssessmentImageSection(
            // pdfData: pdfData,
            pdfData: riskAssessmentModel,
            logoImage: riskAssessmentModel.companyLogoMemoryImage,
            isSelected: image.isSelected,
            image: image.memoryImage!,
            opacity: riskAssessmentModel.hazardIconOpacity,
            index: count++,
            raPdfPageTitleType: RaPdfPageTitleType.assessmentImage,
          ),
        );
      }
    }

    // Add page with image sections
    if (imageWidgets.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageTheme: pdfHelper.returnPageTheme(
            waterMarkImage: pdfHelper.raWaterMarkImage,
            pageFormat: const PdfPageFormat(
              29.7 * PdfPageFormat.cm,
              21.0 * PdfPageFormat.cm,
              marginAll: 0,
            ),
            isSubscribed: riskAssessmentModel.isSubscribed ?? 0,
            pageOrientation: PageOrientation.landscape,
            themeData: pdfHelper.raTheme,
          ),
          build: (context) => imageWidgets,
          footer: (context) => Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(
              // bottom: 15 ,
              bottom: 15,
              right: 20,
            ),
            child: Text(
              "Page No: ${context.pageNumber}${(riskAssessmentModel.referenceNumber ?? "").isNotEmpty ? '/${riskAssessmentModel.referenceNumber}' : ''}",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontItalic,
                color: TbRaPdfColors.black,
                fontSize: 8,
              ),
            ),
          ),
        ),
      );
    }
  }

  /* ************************************** */
  // ADD REFERENCE IMAGE PAGES
  /* ************************************** */
  void addReferenceImagePages({
    required RaPdfData riskAssessmentModel,
    required Document pdf,
  }) {
    List<Widget> imageWidgets = [];
    List<ReferenceImagePdfModel> images =
        riskAssessmentModel.referenceImages ?? [];

    if (images.isEmpty) return;

    var count = 1;
    for (var image in images) {
      if (image.memoryImage != null) {
        imageWidgets.add(
          AssessmentImageSection(
            logoImage: riskAssessmentModel.companyLogoMemoryImage,
            image: image.memoryImage!,
            opacity: riskAssessmentModel.hazardIconOpacity,
            pdfData: riskAssessmentModel,
            index: count++ ?? 1,
            raPdfPageTitleType: RaPdfPageTitleType.referenceImage,
          ),
        );
      }
    }

    // Add page with reference images
    if (imageWidgets.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageTheme: pdfHelper.returnPageTheme(
            waterMarkImage: pdfHelper.raWaterMarkImage,
            pageFormat: const PdfPageFormat(
              29.7 * PdfPageFormat.cm,
              21.0 * PdfPageFormat.cm,
              marginAll: 0,
            ),
            isSubscribed: riskAssessmentModel.isSubscribed,
            pageOrientation: PageOrientation.landscape,
            themeData: pdfHelper.raTheme,
          ),
          build: (context) => imageWidgets,
          footer: (context) => Container(
            padding: EdgeInsets.only(
              // bottom: 15,
              bottom: 15,
              right: 20,
            ),
            alignment: Alignment.bottomRight,
            child: Text(
              "Page No: ${context.pageNumber}${(riskAssessmentModel.referenceNumber ?? "").isNotEmpty ? '/${riskAssessmentModel.referenceNumber}' : ''}",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontItalic,
                color: TbRaPdfColors.black,
                fontSize: 8,
              ),
            ),
          ),
        ),
      );
    }
  }

  /* ************************************** */
  // ADD MAP INFO PAGE
  /* ************************************** */
  void addMapInfoPage({
    required RaPdfData riskAssessmentModel,
    required Document pdf,
  }) {
    MemoryImage? mapImage = riskAssessmentModel.mapMemoryImage;

    if (mapImage == null) return;

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pdfHelper.returnPageTheme(
          waterMarkImage: pdfHelper.raWaterMarkImage,
          pageFormat: const PdfPageFormat(
            29.7 * PdfPageFormat.cm,
            21.0 * PdfPageFormat.cm,
            marginAll: 0,
          ),
          isSubscribed: riskAssessmentModel.isSubscribed ?? 0,
          pageOrientation: PageOrientation.landscape,
          themeData: pdfHelper.raTheme,
        ),
        build: (context) {
          return buildMapWidgets(
            context: context,
            riskAssessmentModel: riskAssessmentModel,
            image: mapImage,
          );
        },
        header: (context) {
          return RaMapHeaderRow(
            logoImage: riskAssessmentModel.companyLogoMemoryImage,
            pdfData: riskAssessmentModel,

            // pdfData: pdfData,
            // logoImage: pdfData.companyLogoMemoryImage,
          );
        },
        footer: (context) {
          return Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(bottom: 15, right: 20),
            child: Text(
              "Page No: ${context.pageNumber}${(riskAssessmentModel.referenceNumber ?? "").isNotEmpty ? '/${riskAssessmentModel.referenceNumber}' : ''}",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontItalic,
                color: TbRaPdfColors.black,
                fontSize: 8,
              ),
            ),
          );
        },
      ),
    );
  }

  /* ************************************** */
  // BUILD MAP WIDGETS
  /* ************************************** */
  List<Widget> buildMapWidgets({
    required MemoryImage image,
    required RaPdfData riskAssessmentModel,
    required Context context,
  }) {
    List<Widget> widgets = [];

    // Add map image
    widgets.add(MapImageRow(
      pdfData: riskAssessmentModel,
      image: image,
    ));

    // Add weather information if available
    if ((riskAssessmentModel.weatherItems ?? []).isNotEmpty) {
      widgets.add(
          buildWeatherDisclaimer(context: context, model: riskAssessmentModel));

      widgets.add(buildWeatherHeadingRow(context: context));

      // Add weather data rows
      for (int i = 0;
          i < (riskAssessmentModel.weatherItems ?? []).length;
          i++) {
        if (i == 3) {
          // Add new disclaimer and heading for every 3 items
          widgets.add(buildWeatherDisclaimer(
              context: context, model: riskAssessmentModel));

          widgets.add(buildWeatherHeadingRow(context: context));
        }

        // Add weather row
        widgets.add(buildWeatherDataRow(
            weather: (riskAssessmentModel.weatherItems ?? [])[i],
            context: context));

        if (i == 2) {
          widgets.add(mapDisclaimerWidget(context: context));
        }
      }

      // Add license info at the end
      // widgets.add(buildWeatherLicenseInfo(context: context));

      widgets.add(mapDisclaimerWidget(context: context));
    }

    return widgets;
  }

/* ************************************** */
// BUILD WEATHER HEADING ROW
/* ************************************** */
  Widget buildWeatherHeadingRow({required Context context}) {
    return Container(
      height: 25,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.5),
      child: Container(
        child: Row(
          children: [
            weatherCell(
              title: "Date",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: PdfColors.white,
            ),
            weatherCell(
              title: "Sunrise",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.lightGreyPdfColor,
            ),
            weatherCell(
              title: "Sunset",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.greyBorder,
            ),
            weatherCell(
              title: "Condition",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.lightGreyPdfColor,
            ),
            weatherCell(
              title: "Humidity",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.greyBorder,
            ),
            weatherCell(
              title: "Wind Speed",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.lightGreyPdfColor,
            ),
            weatherCell(
              title: "Pressure",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.greyBorder,
            ),
            weatherCell(
              title: "Visibility",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.lightGreyPdfColor,
            ),
            weatherCell(
              title: "UV Index",
              style: pdfHelper.textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.greyBorder,
            ),
          ],
        ),
      ),
    );
  }

  /* ************************************** */
  // BUILD WEATHER DATA ROW
  /* ************************************** */
  Widget buildWeatherDataRow({
    required WeatherPdfModel weather,
    required Context context,
  }) {
    return Container(
      height: 25,
      width: double.infinity,
      padding: TbRaPdfPaddings.pageHorizontalPadding,
      child: Row(
        children: [
          weatherCell(
            title: weather.date ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 10,
            ),
            color: TbRaPdfColors.greyBorder,
          ),
          weatherCell(
            title: weather.sunrise ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.weatherTextColor,
              fontSize: 10,
            ),
            color: PdfColors.white,
          ),
          weatherCell(
            title: weather.sunset ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.weatherTextColor,
              fontSize: 10,
            ),
            color: TbRaPdfColors.lightgreyKeyStaffBackground,
          ),
          weatherCell(
            title: weather.chancesOfRain ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.weatherTextColor,
              fontSize: 10,
            ),
            color: PdfColors.white,
          ),
          weatherCell(
            title: weather.humidity ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.weatherTextColor,
              fontSize: 10,
            ),
            color: TbRaPdfColors.lightgreyKeyStaffBackground,
          ),
          weatherCell(
            title: weather.windSpeed ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.weatherTextColor,
              fontSize: 10,
            ),
            color: PdfColors.white,
          ),
          weatherCell(
            title: weather.pressure ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.weatherTextColor,
              fontSize: 10,
            ),
            color: TbRaPdfColors.lightgreyKeyStaffBackground,
          ),
          weatherCell(
            title: weather.visibility ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.weatherTextColor,
              fontSize: 10,
            ),
            color: PdfColors.white,
          ),
          weatherCell(
            title: weather.uvIndex ?? "",
            style: pdfHelper.textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.weatherTextColor,
              fontSize: 10,
            ),
            color: TbRaPdfColors.lightgreyKeyStaffBackground,
          ),
        ],
      ),
    );
  }

  /* ************************************** */
  // WEATHER CELL
  /* ************************************** */
  Widget weatherCell({
    required String title,
    required TextStyle style,
    required PdfColor color,
  }) {
    double width = (TbRaPdfWidth.pageWidth - (15 * 2.0)) / 9.0;
    return Container(
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: 0.5,
            color: PdfColors.grey,
          )),
      child: Center(
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }

  /* ************************************** */
  // BUILD WEATHER DISCLAIMER
  /* ************************************** */
  Widget buildWeatherDisclaimer(
      {required Context context, required RaPdfData model}) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: EdgeInsets.only(
          left: TbRaPdfPaddings.pageHorizontalPadding.left,
          right: TbRaPdfPaddings.pageHorizontalPadding.right,
          top: 10),
      child: Container(
        color: TbRaPdfColors.weatherForeCastTitle,
        padding: const EdgeInsets.all(4),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Weather Forecast - ',
                  style: pdfHelper.textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    color: TbRaPdfColors.white,
                    fontSize: 11,
                  ),
                ),
                TextSpan(
                  text:
                      'This forecast is an estimate only, created ${model.assessmentDate}, and may not reflect actual weather conditions. You should check those conditions on the relevant day. The forecast is provided by Open-Meteo.com. and we accept no liability for any loss arising out of reliance upon the forecast.',
                  style: pdfHelper.textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    color: TbRaPdfColors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mapDisclaimerWidget({
    required Context context,
  }) {
    String disclaimerText =
        """The forecast data is licensed under the Attribution 4.0 International (CC BY 4.0), available at https://creativecommons.org/licenses/by/4.0/""";
    return Container(
      padding: EdgeInsets.only(
          left: TbRaPdfPaddings.pageHorizontalPadding.left, top: 7),
      child: Text(
        disclaimerText,
        // style: raPdfTextStyles.italicBlack9(),
        style: TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.fontBoldItalic,
          fontSize: 9,
          color: TbRaPdfColors.black,
        ),
      ),
    );
  }

  Future<void> preparePDFImages(RaPdfData raPdfData) async {
    if ((raPdfData.companyLogo ?? "").isNotEmpty) {
      raPdfData.companyLogoMemoryImage =
          await TbPdfHelper().generateMemoryImageForPath(pdfData.companyLogo!);
    }

    if ((raPdfData.userSignature.signature ?? "").isNotEmpty) {
      raPdfData.userSignature.signatureMemoryImage =
          await TbPdfHelper().generateMemoryImageForPath(
        raPdfData.userSignature.signature ?? "",
      );
    }
    if ((raPdfData.mapImagePath ?? "").isNotEmpty) {
      raPdfData.mapMemoryImage = await TbPdfHelper().generateMemoryImageForPath(
        raPdfData.mapImagePath ?? "",
      );
    }

    if (raPdfData.reviewSignature?.signature != null) {
      raPdfData.reviewSignature?.signatureMemoryImage =
          await TbPdfHelper().generateMemoryImageForPath(
        raPdfData.reviewSignature?.signature ?? "",
      );
    }

    if ((raPdfData.signOffUsers ?? []).isNotEmpty) {
      await Future.forEach(raPdfData.signOffUsers ?? [], (element) async {
        ReviewSignOffSignatureData imagePdfModel =
            element as ReviewSignOffSignatureData;

        if ((imagePdfModel.signature ?? "").isNotEmpty) {
          imagePdfModel.signatureMemoryImage = await TbPdfHelper()
              .generateMemoryImageForPath(imagePdfModel.signature ?? "");
        }
      });
    }

    if ((raPdfData.referenceImages ?? []).isNotEmpty) {
      await Future.forEach(raPdfData.referenceImages ?? [], (element) async {
        ReferenceImagePdfModel imagePdfModel =
            element as ReferenceImagePdfModel;

        if ((imagePdfModel.image ?? "").isNotEmpty) {
          imagePdfModel.memoryImage = await TbPdfHelper()
              .generateMemoryImageForPath(imagePdfModel.image ?? "");
        }
      });
    }

    if ((raPdfData.assessmentImages ?? []).isNotEmpty) {
      await Future.forEach(raPdfData.assessmentImages ?? [], (element) async {
        AssessmentImagePdfModel imagePdfModel =
            element as AssessmentImagePdfModel;

        if ((imagePdfModel.image ?? "").isNotEmpty) {
          imagePdfModel.memoryImage = await TbPdfHelper()
              .generateMemoryImageForPath(imagePdfModel.image ?? "");
        }
      });
    }

    if ((raPdfData.hazards).isNotEmpty) {
      await Future.forEach(raPdfData.hazards, (element) async {
        HazardPdfModel imagePdfModel = element;

        if ((imagePdfModel.imageURL ?? "").isNotEmpty) {
          imagePdfModel.memoryImage = await TbPdfHelper()
              .generateMemoryImageForPath(imagePdfModel.imageURL ?? "");
        }
      });
    }
  }
}

/// Creates models for hazards so while creating rows
/// of the hazard table in the pdf we don't need to go through
/// actual hazard entity

class TbHazardRowModel {
  String name;
  String? gridRef;
  String controlInPlace;
  String worstCase;
  String likelihood;
  String score;
  String rating;
  String? additionalControl;
  String? additionalLikelihood;
  String? additionalScore;
  String? additionalRating;

  /// this is used to show the color when hazard  table is get split
  String? splitItemScore;

  /// this is used to show the color on addition score section when hazard table is get split

  String? splitItemAdditionalScore;

  /// will hold height of the model when it will be placed on the pdf
  double height = 0;

  /// this propety is used to if the hazard was splitted
  /// if yes we need to deduct its height from the page height, when page is changed.
  int isSplitHazard = 0;

  TbHazardRowModel({
    required this.name,
    this.gridRef,
    required this.controlInPlace,
    required this.worstCase,
    required this.likelihood,
    required this.score,
    required this.rating,
    this.additionalControl,
    this.additionalLikelihood,
    this.additionalScore,
    this.additionalRating,
    this.splitItemScore,
    this.splitItemAdditionalScore,
  });
}
