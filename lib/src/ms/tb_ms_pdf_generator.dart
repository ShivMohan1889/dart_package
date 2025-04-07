import 'dart:typed_data';

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/header_row.dart';

import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_assessment_image_box.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_assessment_image_row.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_border.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_project_details_section.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_sign_off_section.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_site_photo.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_statement_row.dart';
import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';

import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import 'ms_pdf_widget/ms_footer_section.dart';
import 'ms_pdf_widget/ms_header_row.dart';
import 'ms_pdf_widget/ms_review_signature_section.dart';
import 'ms_pdf_widget/ms_statement_hazard_icon_item.dart';
import 'ms_pdf_widget/ms_statement_hazard_icons_row.dart';

class TbMsPdfGenerator {
  /// holds the Ms Assessment Dto
  final MsPdfData pdfData;

  Document? pdfDocumentFromRa;
  late TbPdfHelper pdfHelper;

  bool showMsFirst;

  // this flag is used to show the harm text on the web pdf
  bool harmTextForWeb;
  double pageHeightWithoutHeaderFooter = 0;
  late double remainingMainPdfHeight;

  TbMsPdfGenerator({
    required this.pdfData,
    required this.pdfHelper,
    this.pdfDocumentFromRa,
    required this.showMsFirst,
    this.harmTextForWeb = false,
  });

  final msPdfTextStyle = TbMsPdfTextStyles();

  /// holds all the data related to a header  like header name, statements and hazard icons
  List<Widget> headerWidget = List.empty(growable: true);

  List<MsHeaderRow> listOfHeaderRow = List.empty(growable: true);

  // this list holds the Ms Assessment Image

  // list of widgets that show Details related to ms Assessment in pdf
  List<Widget> msPdfItems = List.empty(growable: true);

  // int currentPageIndex = 0;

  // holds the memory image of company logo
  MemoryImage? companyLogo;

  Future<Uint8List?> generatePDF() async {
    double pageHeight = 842; // A4 height in points
    double headerHeight; // Estimated header height
    double footerHeight; // Estimated footer height

    headerHeight = pdfHelper.calculateHeightOfWidget(
      widget: MsHeaderRow(
        pagesNo: 1,
        companyDetails: pdfData.companyDetails,
        companyPhoneEmail: pdfData.companyPhoneEmail ?? "",
        titleForPdf: "METHOD ASSESSMENT",
        companyLogoMemoryImage: pdfData.companyLogoMemoryImage,
      ),
      width: TbMsPdfWidth.pageWidth,
    );

    footerHeight = pdfHelper.calculateHeightOfWidget(
      widget: MsFooterSection(
        isSubscribed: pdfData.isSubscribed,
        referenceNo: pdfData.referenceNo,
        // pageNumber: context.pageNumber.toString(),
        pageNumber: "1",
      ),
      width: TbMsPdfWidth.pageWidth,
    );

    pageHeightWithoutHeaderFooter = pageHeight - headerHeight - footerHeight;

    remainingMainPdfHeight = pageHeightWithoutHeaderFooter;

    Document pdf = Document();
    if (pdfDocumentFromRa != null) {
      pdf = pdfDocumentFromRa!;
    }

    if (pdfData.raPdfData != null && showMsFirst == false) {
      TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
        pdfData: pdfData.raPdfData!,
        pdfDocumentFromMs: pdf,
        pdfHelper: pdfHelper,
        showMsFirst: showMsFirst,
      );

      await raPdfGenerator.generatePDF();
    }

    await preparePDFImages(pdfData);

    var projectDetailsSection = MsProjectDetailsSection(
      projectDetailsSideLeft: pdfData.projectDetails['leftColumn'] ?? [],
      projectDetailsSideRight: pdfData.projectDetails['rightColumn'] ?? [],
    );

    double projectDetailsHeight = pdfHelper.calculateHeightOfWidget(
      widget: projectDetailsSection,
      width: TbMsPdfWidth.pageWidth,
    );

    headerWidget.add(projectDetailsSection);

    remainingMainPdfHeight -= projectDetailsHeight;

    // Add border
    double borderHeight = 1;
    headerWidget.add(MsBorder());
    remainingMainPdfHeight -= borderHeight;

    if (pdfData.siteMemoryImage != null) {
      var sitePhoto = MsSitePhoto(
        memoryImage: pdfData.siteMemoryImage,
      );

      double sitePhotoHeight = pdfHelper.calculateHeightOfWidget(
        widget: sitePhoto,
        width: TbMsPdfWidth.pageWidth,
      );

      if (sitePhotoHeight <= remainingMainPdfHeight) {
        headerWidget.add(sitePhoto);
        // remainingHeight -= sitePhotoHeight;
        remainingMainPdfHeight -= sitePhotoHeight;
      } else {
        // Start a new page
        headerWidget.add(sitePhoto);

        remainingMainPdfHeight = remainingMainPdfHeight - sitePhotoHeight;
      }

      // Add border after site photo
      headerWidget.add(MsBorder());

      remainingMainPdfHeight -= borderHeight;
    }

    pdf.addPage(
      MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          isSubscribed: pdfData.isSubscribed ?? 0,
          waterMarkImage: pdfHelper.msWaterMarkImage,
          themeData: pdfHelper.msTheme,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
        ),
        build: (context) {
          iterateHeadersForPdfWidgets(
            pdfData: pdfData,
            context: context,
          );
          return headerWidget;
        },
        header: (context) {
          return MsHeaderRow(
            pagesNo: context.pageNumber,
            companyDetails: pdfData.companyDetails,
            companyPhoneEmail: pdfData.companyPhoneEmail ?? "",
            titleForPdf: "METHOD ASSESSMENT",
            companyLogoMemoryImage: pdfData.companyLogoMemoryImage,
          );
        },
        footer: (context) {
          return MsFooterSection(
            isSubscribed: pdfData.isSubscribed,
            referenceNo: pdfData.referenceNo,
            pageNumber: context.pageNumber.toString(),
          );
        },
      ),
    );

    if (pdfData.raPdfData != null && showMsFirst) {
      TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
        pdfData: pdfData.raPdfData!,
        pdfDocumentFromMs: pdf,
        pdfHelper: pdfHelper,
        showMsFirst: showMsFirst,
      );

      await raPdfGenerator.generatePDF();
    }

    if (pdfDocumentFromRa == null) {
      var data = await pdf.save();

      return data;
    }

    return null;
  }

  /* ********************************** */
  // SHOW USER DETAILS AND REVIEW USER ON PDF
  /// in this method passed [msAssessmentDto]and
  /// update the widget of Ms Review Signature Section and
  /// added into the audit pdf item list
  /* ************************************ */

  void showUserDetailsAndReviewUserOnPdf({
    required MsPdfData pdfData,
    required Context context,
  }) {
    Widget widget = MsReviewSignatureSection(
      reviewDate: pdfData.reviewSignature?.date ?? "",
      reviewUserName: pdfData.reviewSignature?.name,
      approvalMode: pdfData.approvalMode,
      reviewSignatureImage: pdfData.reviewSignature?.signatureMemoryImage,
      userName: pdfData.userSignature.name,
      userAssessmentDate: pdfData.userSignature.date,
      userSignature: pdfData.userSignature.signatureMemoryImage,
      userPosition: pdfData.userSignature.position,
    );
    msPdfItems.add(widget);
  }

/* *************** */
// CREATE HEADER ROW
  /// responsible to iterate all the headers of a templates
  /// and create widgets for header, subHeaders and statements/ hazard icons

/* ***************** */

  void iterateHeadersForPdfWidgets({
    required MsPdfData pdfData,
    required Context context,
  }) {
    for (HeaderRows headerRow in pdfData.headers) {
      processHeaderWithPageBreaks(
        headerRow: headerRow,
        context: context,
      );
    }
    print(headerWidget);
  }

  void processHeaderWithPageBreaks({
    required HeaderRows headerRow,
    required Context context,
  }) {
    processMsHeader(
      headerRow: headerRow,
      context: context,
    );

    // Process nested headers if they exist
    if ((headerRow.headerRows ?? []).isNotEmpty) {
      for (HeaderRows nestedHeader in headerRow.headerRows!) {
        processHeaderWithPageBreaks(
          headerRow: nestedHeader,
          context: context,
        );
      }
    }
    // Process hazard icons if they exist
    else if ((headerRow.hazardIcons ?? []).isNotEmpty) {
      processHazardIcons(
        hazardIcons: headerRow.hazardIcons!,
      );
    }
    // Process statements if they exist
    else if ((headerRow.statements ?? []).isNotEmpty) {
      for (HeaderStatementData statement in headerRow.statements!) {
        processStatement(
          statement: statement,
          context: context,
        );
      }
    }

    // Process header images if they exist
    if ((headerRow.images ?? []).isNotEmpty) {
      List<MemoryImage> images = [];

      for (HeaderReferenceImageData image in headerRow.images!) {
        if (image.memoryImage != null) {
          images.add(image.memoryImage!);
        }
      }

      if (images.isNotEmpty) {
        processImages(
          images: images,
        );
      }
    }
  }

  void processMsHeader({
    required HeaderRows headerRow,
    required Context context,
  }) {
    TbHeaderRowModel tbHeaderRowModel = TbHeaderRowModel(
      headerName: headerRow.name,
      headerLevel: headerRow.level,
    );

    HeaderRow headerRowWidget = HeaderRow(
      tbHeaderRowModel: tbHeaderRowModel,
      rowType: 1,
    );

    double headerRowWidgetHeight = pdfHelper.calculateHeightOfWidget(
      widget: headerRowWidget,
      width: MsPdfWidth.pageWidth,
    );

    tbHeaderRowModel.height = headerRowWidgetHeight;

    processMsHeaderForPages(
      msHeaderRow: headerRowWidget,
      tbHeaderRowModel: tbHeaderRowModel,
      pdfData: pdfData,
    );
  }

  void processStatement({
    required HeaderStatementData statement,
    required Context context,
  }) {
    if (statement.text.contains("No land")) {
      print("a");
    }
    TbStatementRowModel statementRowModel = TbStatementRowModel(
      statementName: statement.text,
    );

    MsStatementRow msStatementWidget = MsStatementRow(
      statementRowModel: statementRowModel,
      statmentTextStyle: TbPdfHelper().textStyleGenerator(
        font: Theme.of(context).header0.font,
        color: MsPdfColors.black,
        fontSize: 11,
      ),
    );

    double statementWidgetHeight = pdfHelper.calculateHeightOfWidget(
      widget: msStatementWidget,
      width: MsPdfWidth.pageWidth,
    );

    statementRowModel.height = statementWidgetHeight;

    if (remainingMainPdfHeight < 19.0) {
      var listHeader = addHeaderToTheNextPage();

      if (listHeader.isNotEmpty) {
        headerWidget.addAll(listHeader);

        remainingMainPdfHeight = pageHeightWithoutHeaderFooter;
      }
    }

    processMsStatementForPages(
      statementRowModel: statementRowModel,
      pdfData: pdfData,
      statementRow: msStatementWidget,
    );

    // Process statement images if they exist
    if ((statement.memoryImages ?? []).isNotEmpty) {
      processImages(
        images: statement.memoryImages!,
      );
    }
  }

  List<Widget> addHeaderToTheNextPage() {
    List<Widget> listHeaderRow = [];

    for (int i = headerWidget.length - 1; i >= 0; i--) {
      Widget page = headerWidget[i]; // Get the widget

      if (page is MsStatementHazardIconsRow ||
          page is MsStatementRow ||
          page is MsAssessmentImageRow) {
        return listHeaderRow; // Skip these widgets
      } else {
        listHeaderRow.add(page);
        headerWidget.removeAt(i); // Remove the element safely
      }
    }

    return listHeaderRow;
  }

  void processImages({
    required List<MemoryImage> images,
  }) {
    // Add padding before images
    Widget paddingWidget = Container(height: 8);
    double paddingHeight = pdfHelper.calculateHeightOfWidget(
      widget: paddingWidget,
      width: TbMsPdfWidth.pageWidth,
    );

    if (paddingHeight > remainingMainPdfHeight) {
      remainingMainPdfHeight = pageHeightWithoutHeaderFooter;
    }

    headerWidget.add(paddingWidget);
    remainingMainPdfHeight -= paddingHeight;

    // Process images in pairs (two per row)
    List<Widget> rowChildren = [];

    for (int i = 0; i < images.length; i++) {
      // Create image box widget
      MemoryImage memoryImage = images[i];
      Widget imageBox = MsAssessmentImageBox(
        image: memoryImage,
        index: i + 1,
      );

      rowChildren.add(imageBox);
      rowChildren.add(Container(width: 10)); // Add spacing between images

      // Create a row when we have 2 images or at the last image
      if (rowChildren.length == 4 || i == images.length - 1) {
        Widget imageRow = MsAssessmentImageRow(
          listChildren: List.from(rowChildren),
        );

        double imageRowHeight = pdfHelper.calculateHeightOfWidget(
          widget: imageRow,
          width: TbMsPdfWidth.pageWidth,
        );

        // Check if row fits on current page
        if (imageRowHeight > remainingMainPdfHeight) {
          remainingMainPdfHeight = pageHeightWithoutHeaderFooter;
        }

        // Add image row to current page
        headerWidget.add(imageRow);
        remainingMainPdfHeight -= imageRowHeight;

        // Add vertical spacing after row
        Widget spacingWidget = Container(height: 10);
        double spacingHeight = pdfHelper.calculateHeightOfWidget(
          widget: spacingWidget,
          width: TbMsPdfWidth.pageWidth,
        );

        headerWidget.add(spacingWidget);
        remainingMainPdfHeight -= spacingHeight;

        // Reset row children for next row
        rowChildren = [];
      }
    }
  }

  int splitText({
    required MsPdfData msPdfData,
    required String text,
    required double maxHeight,
    required double height,
    dynamic msModel,
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
      double testHeight = measureTextHeight(
        // text: ,
        // testText,
        // msPdfData,
        msModel: msModel,
        text: testText,
        model: msPdfData,
      );

      // Check if adding this word exceeds the max height
      if (testHeight > maxHeight) {
        // If this is the first word and it doesn't fit, we need to split within the word
        if (i == 0) {
          // return findSplitPositionInWord(words[0], maxHeight, msPdfData);
          return findSplitPositionInWord(
              word: words[0],
              maxHeight: maxHeight,
              msPdfData: msPdfData,
              msModel: msModel);
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
      // String word, double maxHeight, MsPdfData msPdfData,
      {
    required String word,
    required double maxHeight,
    required MsPdfData msPdfData,
    required dynamic msModel,
  }) {
    // Binary search to find how many characters of this word will fit
    int low = 1; // At least one character
    int high = word.length;
    int best = 0;

    while (low <= high) {
      int mid = (low + high) ~/ 2;
      String subWord = word.substring(0, mid);

      // double height = measureTextHeight(subWord, msPdfData);
      double height = measureTextHeight(
        text: subWord,
        model: msPdfData,
        msModel: msModel,
      );

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

  double measureTextHeight({
    required String text,
    required MsPdfData model,
    required dynamic msModel,
  }) {
    if (msModel is TbStatementRowModel) {
      TbStatementRowModel tbStatementRowModel = TbStatementRowModel(
        statementName: text,
      );

      MsStatementRow tempRow = MsStatementRow(
        statementRowModel: tbStatementRowModel,
      );

      return pdfHelper.calculateHeightOfWidget(
        widget: tempRow,
        width: MsPdfWidth.pageWidth,
      );
    } else {
      TbHeaderRowModel tbHeaderRowModel = msModel as TbHeaderRowModel;

      TbHeaderRowModel headerRowModel = TbHeaderRowModel(
        headerName: text,
        headerLevel: tbHeaderRowModel.headerLevel,
      );

      HeaderRow headerRow = HeaderRow(
        tbHeaderRowModel: headerRowModel,
      );
      return pdfHelper.calculateHeightOfWidget(
          widget: headerRow, width: MsPdfWidth.pageWidth);
    }
  }

  void processHazardIcons({
    required List<HazardIconData> hazardIcons,
  }) {
    // We'll group hazard icons in rows of up to 6 icons per row
    List<Widget> currentRowIcons = [];

    for (int i = 0; i < hazardIcons.length; i++) {
      HazardIconData iconData = hazardIcons[i];

      if (iconData.iconMemoryImage != null) {
        Widget iconWidget = MsStatementHazardIconItem(
          iconImage: iconData.iconMemoryImage!,
        );

        currentRowIcons.add(iconWidget);

        // Create a row when we have 6 icons or we're at the last icon
        if (currentRowIcons.length == 6 || i == hazardIcons.length - 1) {
          Widget iconRow = MsStatementHazardIconsRow(
            iconsImageList: List.from(currentRowIcons),
          );

          double iconRowHeight = pdfHelper.calculateHeightOfWidget(
            widget: iconRow,
            width: TbMsPdfWidth.pageWidth,
          );

          // Check if row fits on current page
          if (iconRowHeight > remainingMainPdfHeight) {
            // Need to start a new page
            var listHeader = addHeaderToTheNextPage();

            // Move to a new page with the header
            if (listHeader.isNotEmpty) {
              // Add spacing and the header to the new page
              headerWidget.add(Container(height: 10));
              headerWidget.addAll(listHeader);

              // Reset remaining height for the new page
              remainingMainPdfHeight -= 10;

              // Calculate header total height
              double headerHeight = 0;
              for (var item in listHeader) {
                headerHeight += pdfHelper.calculateHeightOfWidget(
                    widget: item, width: TbMsPdfWidth.pageWidth);
              }

              // Subtract header height from remaining height
              remainingMainPdfHeight -= headerHeight;
            } else {
              remainingMainPdfHeight = pageHeightWithoutHeaderFooter;
            }
          }

          // Add the row to the current page
          headerWidget.add(iconRow);
          remainingMainPdfHeight -= iconRowHeight;

          // Clear for the next row
          currentRowIcons = [];
        }
      }
    }
  }

  // void processHazardIcons({
  //   required List<HazardIconData> hazardIcons,
  // }) {
  //   // We'll group hazard icons in rows of up to 6 icons per row
  //   List<Widget> iconRows = [];
  //   List<Widget> currentRowIcons = [];

  //   for (int i = 0; i < hazardIcons.length; i++) {
  //     HazardIconData iconData = hazardIcons[i];

  //     if (iconData.iconMemoryImage != null) {
  //       Widget iconWidget = MsStatementHazardIconItem(
  //         iconImage: iconData.iconMemoryImage!,
  //       );

  //       currentRowIcons.add(iconWidget);

  //       // Create a row when we have 6 icons or we're at the last icon
  //       if (currentRowIcons.length == 6 || i == hazardIcons.length - 1) {
  //         Widget iconRow = MsStatementHazardIconsRow(
  //           iconsImageList: List.from(currentRowIcons),
  //         );

  //         double iconRowHeight = pdfHelper.calculateHeightOfWidget(
  //           widget: iconRow,
  //           width: TbMsPdfWidth.pageWidth,
  //         );
  //         // Check if row fits on current page
  //         if (iconRowHeight > remainingMainPdfHeight) {
  //           // Add the rows we have so far to the current page

  //           if (iconRows.isNotEmpty) {
  //             headerWidget.addAll(iconRows);
  //           }

  //           var listHeader = addHeaderToTheNextPage();

  //           if (listHeader.isNotEmpty) {
  //             double calculateHeightHeader = pdfHelper.calculateHeightOfWidget(
  //                 widget: listHeader.first, width: TbMsPdfWidth.pageWidth);

  //             // Start a new page
  //             headerWidget.add(
  //               Container(
  //                 height: iconRowHeight + calculateHeightHeader,
  //               ),
  //             );

  //             headerWidget.addAll(listHeader);

  //             remainingMainPdfHeight =
  //                 remainingMainPdfHeight - calculateHeightHeader;
  //             iconRows.add(iconRow);
  //             iconRows = [];
  //             remainingMainPdfHeight = pageHeightWithoutHeaderFooter;
  //           } else {
  //             iconRows.add(iconRow);
  //             iconRows = [];
  //             remainingMainPdfHeight -= iconRowHeight;
  //           }
  //         }

  //         currentRowIcons = [];
  //       }
  //     }
  //   }

  //   // Add any remaining icon rows to the current page
  //   if (iconRows.isNotEmpty) {
  //     headerWidget.addAll(iconRows);
  //   }
  // }

  List<Widget> showStatementImagesOnPdf({
    List<MemoryImage>? images,
    bool isHeaderImage = false,
  }) {
    List<Widget> imageRowWidgets = [];
    List<Widget> rowChildren = [];
    final imagesList = images ?? [];

    // this if for top padding
    imageRowWidgets.add(Container(height: 8));

    // Process images in pairs to create rows
    for (int i = 0; i < imagesList.length; i++) {
      // Add the current image to row children
      MemoryImage memoryImage = imagesList[i];
      rowChildren.add(
        MsAssessmentImageBox(
          image: memoryImage,
          index: i + 1,
        ),
      );

      // Add spacing between images
      rowChildren.add(Container(width: 10));

      // When we have 2 images or we're at the last image, create a row
      if (rowChildren.length == 4 || i == imagesList.length - 1) {
        imageRowWidgets.add(
          MsAssessmentImageRow(
            listChildren: List.from(rowChildren),
          ),
        );

        // Add vertical spacing after each row
        imageRowWidgets.add(Container(height: 10));

        // Clear row children for the next row
        rowChildren = [];
      }
    }

    return imageRowWidgets;
  }

/* ****************************/
//  SHOW MS STATEMENT ICON ON PDF
  /// in this method we passed the [msStatementIconDtoList] to get the selected icons image and
  /// implement the logic of show only 6 icons image in a single row and
  /// image which came after the 6th one is show on next row
/*  ************************* */

  void showMsStatementIconsOnPdf({
    required List<HazardIconData> hazardIconData,
  }) {
    /// this list holds the memory image widget of ms Statement Icons
    List<Widget> listIconImageItems = [];
    // this holds the row widget which contain children widget as listIconImageItems
    List<Widget> listIconRow = [];
    // this loop for iterating the element of list of StatementIcon
    // in this loop we have implement the logic to show only 6 image in a single row and image which came after the 6th one
    // is show on next row
    // Future.forEach(msStatementHazadIconDtoList, (iconDto) {
    for (HazardIconData iconData in hazardIconData) {
      int index = (hazardIconData).indexOf(iconData);

      MemoryImage? iconImage = iconData.iconMemoryImage;

      ///logic behind the code is we get the remainder of index of iconImage image by
      /// taking the modulus of index by 6
      /// when remainder equals to zero we create new Widget MsStatementHazardIconRow which contains
      /// the list of listIconImageItems as children and add it this new widget to the list of listIconImageRow
      /// to show the on pdf page
      if (index % 6 == 0) {
        if (index == 0) {
          if (iconImage != null) {
            Widget iconWidget = MsStatementHazardIconItem(
              iconImage: iconImage,
            );
            listIconImageItems.add(iconWidget);
          }
        } else {
          var row = MsStatementHazardIconsRow(
            iconsImageList: listIconImageItems,
          );
          listIconRow.add(row);
          listIconImageItems = [];
          if (iconImage != null) {
            Widget iconWidget = MsStatementHazardIconItem(
              iconImage: iconImage,
            );
            listIconImageItems.add(iconWidget);
          }
        }
      } else {
        if (iconImage != null) {
          Widget iconWidget = MsStatementHazardIconItem(
            iconImage: iconImage,
          );
          listIconImageItems.add(iconWidget);
        }
      }
    }

    var row = MsStatementHazardIconsRow(
      iconsImageList: listIconImageItems,
    );
    listIconRow.add(row);

    headerWidget.addAll(listIconRow);

    listIconRow = [];

    listIconImageItems = [];
  }

  void showSignOffUserWithData({
    required Context context,
    required List<ReviewSignOffSignatureData> signOffUsers,
    required TbPdfHelper pdfHelper,
    required String? signOffStatement,
  }) {
    if (signOffUsers.isEmpty) return;
    // Add section divider
    MsBorder();

    // Process sign-off users in pairs
    for (int i = 0; i < signOffUsers.length; i += 2) {
      List<Widget> rowChildren = [];

      // Add first user in the pair
      rowChildren.add(Container(
        width: TbMsPdfWidth.pageWidth / 2 - 25, // Half width with padding
        decoration: BoxDecoration(
          color: TbMsPdfColors.lightGreyBackground, // Light grey background
          border: Border.all(width: 0.5, color: PdfColors.grey300),
          borderRadius: BorderRadius.circular(4), // Rounded corners
        ),
        margin: const EdgeInsets.only(right: 10),
        child: MsSignOffSection(
          user: signOffUsers[i],
        ),
      ));

      // Add second user if available
      if (i + 1 < signOffUsers.length) {
        rowChildren.add(
          MsSignOffSection(
            user: signOffUsers[i + 1],
          ),
        );
      } else {
        // Add empty container for even spacing
        rowChildren.add(Container(
          width: MsPdfWidth.pageWidth / 2 - 25, // Half width with padding
        ));
      }

      if (i == 0) {
        msPdfItems.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title in bold
                          Text(
                            "SIGN OFF USERS",
                            style: TbPdfHelper().textStyleGenerator(
                              font: Theme.of(context).header0.fontBold,
                              color: TbMsPdfColors.black,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Sign-off statement
                          if (signOffStatement != null)
                            Text(
                              signOffStatement,
                              style: TbPdfHelper().textStyleGenerator(
                                font: Theme.of(context).header0.fontNormal,
                                color: TbMsPdfColors.black,
                                fontSize: 9,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: rowChildren,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      } else {
        msPdfItems.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowChildren,
          ),
        ));
      }

      // Add row to PDF
    }
  }

  Future<void> preparePDFImages(MsPdfData pdfData) async {
    if (pdfData.siteImage != null) {
      pdfData.siteMemoryImage =
          await TbPdfHelper().generateMemoryImageForPath(pdfData.siteImage!);
    }

    if (pdfData.userSignature.signature != null) {
      pdfData.userSignature.signatureMemoryImage =
          await TbPdfHelper().generateMemoryImageForPath(
        pdfData.userSignature.signature ?? "",
      );
    }

    if (pdfData.reviewSignature?.signature != null) {
      pdfData.reviewSignature?.signatureMemoryImage =
          await TbPdfHelper().generateMemoryImageForPath(
        pdfData.reviewSignature?.signature ?? "",
      );
    }

    if (pdfData.companyLogo != null) {
      pdfData.companyLogoMemoryImage =
          await TbPdfHelper().generateMemoryImageForPath(pdfData.companyLogo!);
    }
    await _processReviewSignOff(
        signOffSignatures: pdfData.signOffSignatures ?? []);

    await _processHeadersMemoryImagesRecursively(pdfData.headers);
  }

  Future<void> _processHeadersMemoryImagesRecursively(
      List<HeaderRows> headers) async {
    for (var header in headers) {
      // Process immediate content of this header
      await Future.wait([
        _processStatements(header.statements ?? []),
        _processHazardIcons(header.hazardIcons ?? []),
        _processReferenceImages(header.images ?? []),
      ]);

      // Process any nested headers recursively
      if (header.headerRows != null && header.headerRows!.isNotEmpty) {
        await _processHeadersMemoryImagesRecursively(header.headerRows!);
      }
    }
  }

  /// Process images in statements
  Future<void> _processStatements(List<HeaderStatementData> statements) async {
    // for (var statement in statements) {

    await Future.forEach(statements, (statement) async {
      List<MemoryImage> memoryImage = [];
      await Future.forEach((statement.images ?? []), (image) async {
        if ((statement.images ?? []).isNotEmpty) {
          StatementImageData statementImageData = image as StatementImageData;
          var i = await TbPdfHelper()
              .generateMemoryImageForPath(statementImageData.image ?? "");
          if (i != null) {
            memoryImage.add(i);
          }
        }
      });
      if (memoryImage.isNotEmpty) {
        statement.memoryImages = memoryImage;
      }
    });
  }

  /// Process hazard icons
  Future<void> _processHazardIcons(List<HazardIconData> hazardIcons) async {
    for (var hazardIcon in hazardIcons) {
      if (hazardIcon.icon != null) {
        hazardIcon.iconMemoryImage =
            await TbPdfHelper().generateMemoryImageForPath(hazardIcon.icon!);
      }
    }
  }

  Future<void> _processReviewSignOff(
      {required List<ReviewSignOffSignatureData> signOffSignatures}) async {
    for (ReviewSignOffSignatureData signOff in signOffSignatures) {
      if ((signOff.signature ?? "").isNotEmpty) {
        signOff.signatureMemoryImage =
            await TbPdfHelper().generateMemoryImageForPath(signOff.signature!);
      }
    }
  }

  /// Process reference images
  Future<void> _processReferenceImages(
      List<HeaderReferenceImageData> images) async {
    for (var image in images) {
      if (image.image != null) {
        image.memoryImage =
            await TbPdfHelper().generateMemoryImageForPath(image.image!);
      }
    }
  }

  String joinStatementText(List<String> statementList) {
    if (statementList.isEmpty) return "";

    String result = statementList.join("\n...\n...");

    // Remove trailing line breaks if needed
    if (result.endsWith("\n...\n...")) {
      result = result.substring(0, result.length - 8);
    }

    return result;
  }

  /* *********************************** / 
   // PROCESS MS HEADER FOR PAGES 
   
   /// 
  / ************************************ */
  void processMsHeaderForPages({
    required HeaderRow msHeaderRow,
    required TbHeaderRowModel tbHeaderRowModel,
    required MsPdfData pdfData,
  }) {
    // Check if the statement fits in the remaining height of the current page
    if (remainingMainPdfHeight < 19) {
      // Minimum threshold
      remainingMainPdfHeight = pageHeightWithoutHeaderFooter;
    }

    if ((tbHeaderRowModel.height ?? 0.0) > remainingMainPdfHeight) {
      // Split the statement if it doesn't fit
      var splitStatements = splitHeaderRow(
        headerRowModel: tbHeaderRowModel,
        maxHeight: remainingMainPdfHeight,
        pdfData: pdfData,
      );

      headerWidget.add(HeaderRow(
        tbHeaderRowModel: splitStatements.first,
      ));

      if (splitStatements.length == 2) {
        remainingMainPdfHeight = pageHeightWithoutHeaderFooter;

        // Recursively process the remaining part
        processMsHeaderForPages(
          tbHeaderRowModel: splitStatements.last,
          pdfData: pdfData,
          msHeaderRow: msHeaderRow,
        );
      }
      // Start a new page for the remaining part
    } else {
      // Add the statement to the current page
      headerWidget.add(
        HeaderRow(
          // statementRowModel: statementRowModel,
          tbHeaderRowModel: tbHeaderRowModel,
        ),
      );
      remainingMainPdfHeight -= tbHeaderRowModel.height ?? 0.0;
    }
  }

  void processMsStatementForPages({
    required MsStatementRow statementRow,
    required TbStatementRowModel statementRowModel,
    required MsPdfData pdfData,
  }) {
    // Check if the statement fits in the remaining height of the current page
    if (remainingMainPdfHeight < 19.0) {
      // Minimum threshold
      remainingMainPdfHeight = pageHeightWithoutHeaderFooter;
    }

    if ((statementRowModel.height ?? 0.0) > remainingMainPdfHeight) {
      // Split the statement if it doesn't fit
      var splitStatements = splitMsStatementRow(
        statementRow: statementRowModel,
        maxHeight: remainingMainPdfHeight,
        pdfData: pdfData,
      );

      // Add the first part of the split statement to the current page
      // pages[currentPageIndex].add(splitStatements.first);
      headerWidget.add(
        MsStatementRow(
          statementRowModel: splitStatements.first,
        ),
      );

      if (splitStatements.length == 2) {
        remainingMainPdfHeight = pageHeightWithoutHeaderFooter;

        // Recursively process the remaining part
        processMsStatementForPages(
          statementRowModel: splitStatements.last,
          pdfData: pdfData,
          statementRow: statementRow,
        );
      }
      // Start a new page for the remaining part
    } else {
      // Add the statement to the current page
      headerWidget.add(
        MsStatementRow(
          statementRowModel: statementRowModel,
        ),
      );
      remainingMainPdfHeight -= statementRowModel.height ?? 0.0;
    }
  }

  /// ***********************************
  ///   SPLIT MS HEADER ROW
  ///
  ///
  /// ***********************************
  List<TbHeaderRowModel> splitHeaderRow({
    required TbHeaderRowModel headerRowModel,
    required double maxHeight,
    required MsPdfData pdfData,
  }) {
    // Split the statement text to fit within the maxHeight
    int splitIndex = splitText(
      text: headerRowModel.headerName,
      maxHeight: maxHeight,
      msPdfData: pdfData,
      height: headerRowModel.height ?? 0.0,
      msModel: headerRowModel,
    );

    print(headerRowModel.headerName.length);

    if (splitIndex > 0) {}

    // Create two parts of the statement
    String firstPart =
        (headerRowModel.headerName ?? "").substring(0, splitIndex).trim();
    String secondPart =
        (headerRowModel.headerName ?? "").substring(splitIndex).trim();

    TbHeaderRowModel firstHeaderRowModel = TbHeaderRowModel(
      headerName: firstPart,
      headerLevel: headerRowModel.headerLevel,
    );
    TbHeaderRowModel secondHeaderRowModel = TbHeaderRowModel(
      headerName: secondPart,
      headerLevel: headerRowModel.headerLevel,
      // statementName: secondPart,
    );

    // Create the first part of the statement row
    HeaderRow firstRow = HeaderRow(
        // statementRowModel: firstTbStatementRowModel,
        tbHeaderRowModel: firstHeaderRowModel
        // statmentTextStyle: statementRow.statmentTextStyle,
        );

    // Create the second part of the statement row
    HeaderRow secondRow = HeaderRow(
      tbHeaderRowModel: secondHeaderRowModel,
    );

    // Calculate the heights of the split rows
    firstHeaderRowModel.height = pdfHelper.calculateHeightOfWidget(
      widget: firstRow,
      width: TbMsPdfWidth.pageWidth,
    );

    secondHeaderRowModel.height = pdfHelper.calculateHeightOfWidget(
      widget: secondRow,
      width: TbMsPdfWidth.pageWidth,
    );
    if (splitIndex > 0) {
      return [firstHeaderRowModel, secondHeaderRowModel];
    } else {
      return [firstHeaderRowModel];
    }
  }

  List<TbStatementRowModel> splitMsStatementRow({
    required TbStatementRowModel statementRow,
    required double maxHeight,
    required MsPdfData pdfData,
  }) {
    // Split the statement text to fit within the maxHeight
    int splitIndex = splitText(
      text: statementRow.statementName ?? "",
      maxHeight: maxHeight,
      msPdfData: pdfData,
      height: statementRow.height ?? 0.0,
      msModel: statementRow,
    );

    print(statementRow.statementName.length);

    if (splitIndex > 0) {}

    // Create two parts of the statement
    String firstPart =
        (statementRow.statementName ?? "").substring(0, splitIndex).trim();
    String secondPart =
        (statementRow.statementName ?? "").substring(splitIndex).trim();

    TbStatementRowModel firstTbStatementRowModel = TbStatementRowModel(
      statementName: firstPart,
    );
    TbStatementRowModel secondTbStatementRowModel = TbStatementRowModel(
      statementName: secondPart,
    );

    // Create the first part of the statement row
    MsStatementRow firstRow = MsStatementRow(
      statementRowModel: firstTbStatementRowModel,
      // statmentTextStyle: statementRow.statmentTextStyle,
    );

    // Create the second part of the statement row
    MsStatementRow secondRow = MsStatementRow(
      statementRowModel: secondTbStatementRowModel,
    );

    // Calculate the heights of the split rows
    firstTbStatementRowModel.height = pdfHelper.calculateHeightOfWidget(
      widget: firstRow,
      width: TbMsPdfWidth.pageWidth,
    );

    secondRow.height = pdfHelper.calculateHeightOfWidget(
      widget: secondRow,
      width: TbMsPdfWidth.pageWidth,
    );

    secondTbStatementRowModel.height = pdfHelper.calculateHeightOfWidget(
      widget: secondRow,
      width: TbMsPdfWidth.pageWidth,
    );
    if (splitIndex > 0) {
      return [firstTbStatementRowModel, secondTbStatementRowModel];
    } else {
      return [firstTbStatementRowModel];
    }
  }
}

class TbStatementRowModel {
  String statementName;
  double? height;

  TbStatementRowModel({
    required this.statementName,
    this.height,
  });
}

class TbHeaderRowModel {
  String headerName;
  double? height;
  int? headerLevel;

  TbHeaderRowModel({
    required this.headerName,
    this.height,
    this.headerLevel,
  });
}
