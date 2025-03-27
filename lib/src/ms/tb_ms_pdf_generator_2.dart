// import 'dart:typed_data';

// import 'package:dart_pdf_package/dart_pdf_package.dart';
// import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';

// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_assessment_image_box.dart';
// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_assessment_image_row.dart';
// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_border.dart';
// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_pdf_custom_text.dart';
// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_project_details_section.dart';
// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_sign_off_section.dart';
// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_site_photo.dart';
// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_statement_row.dart';
// import 'package:dart_pdf_package/src/ms/ms_pdf_widget/non_splitting_widget.dart';
// import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';

// import 'package:pdf/pdf.dart';

// import 'package:pdf/widgets.dart';

// import 'ms_pdf_widget/ms_footer_section.dart';
// import 'ms_pdf_widget/ms_header_row.dart';
// import 'ms_pdf_widget/ms_review_signature_section.dart';
// import 'ms_pdf_widget/ms_statement_hazard_icon_item.dart';
// import 'ms_pdf_widget/ms_statement_hazard_icons_row.dart';

// class TbMsPdfGenerator {
//   /// holds the Ms Assessment Dto
//   final MsPdfData pdfData;

//   Document? pdfDocumentFromRa;
//   late TbPdfHelper pdfHelper;

//   bool showMsFirst;

//   // this flag is used to show the harm text on the web pdf
//   bool harmTextForWeb;

//   TbMsPdfGenerator({
//     required this.pdfData,
//     required this.pdfHelper,
//     this.pdfDocumentFromRa,
//     required this.showMsFirst,
//     this.harmTextForWeb = false,
//   });

//   final msPdfTextStyle = TbMsPdfTextStyles();

//   /// holds all the data related to a header  like header name, statements and hazard icons
//   List<Widget> headerWidget = List.empty(growable: true);

//   // this list holds the Ms Assessment Image

//   // list of widgets that show Detials related to ms Assessment in pdf
//   List<Widget> msPdfItems = List.empty(growable: true);

//   // holds the memory image of company logo
//   MemoryImage? companyLogo;

//   Future<Uint8List?> generatePDF() async {
//     Document pdf = Document();
//     if (pdfDocumentFromRa != null) {
//       pdf = pdfDocumentFromRa!;
//     }

//     // Handle Risk Assessment if present
//     if (pdfData.raPdfData != null && showMsFirst) {
//       TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
//         pdfData: pdfData.raPdfData!,
//         pdfDocumentFromMs: pdf,
//         pdfHelper: pdfHelper,
//         showMsFirst: showMsFirst,
//       );

//       await raPdfGenerator.generatePDF();
//     }

//     await preparePDFImages(pdfData);

//     // Define constants for page layout
//     final double pageHeight = 842; // A4 height in points
//     final double headerHeight = 95; // Estimated header height
//     final double footerHeight = 30; // Estimated footer height
//     final double contentHeight = pageHeight - headerHeight - footerHeight;

//     // We'll maintain a list of pages, each with their own content
//     List<List<Widget>> pages = [[]];
//     int currentPageIndex = 0;
//     double remainingHeight = contentHeight;

//     // Calculate and add project details
//     var projectDetailsSection = MsProjectDetailsSection(
//       projectDetailsSideLeft: pdfData.projectDetails['leftColumn'] ?? [],
//       projectDetailsSideRight: pdfData.projectDetails['rightColumn'] ?? [],
//     );

//     double projectDetailsHeight = pdfHelper.calculateHeightOfWidget(
//       widget: projectDetailsSection,
//       width: TbMsPdfWidth.pageWidth,
//     );

//     if (projectDetailsHeight <= remainingHeight) {
//       pages[currentPageIndex].add(projectDetailsSection);
//       remainingHeight -= projectDetailsHeight;
//     } else {
//       // Start a new page
//       pages.add([projectDetailsSection]);
//       currentPageIndex++;
//       remainingHeight = contentHeight - projectDetailsHeight;
//     }

//     // Add border
//     double borderHeight = 1;
//     pages[currentPageIndex].add(MsBorder());
//     remainingHeight -= borderHeight;

//     // Add site photo if exists
//     if (pdfData.siteMemoryImage != null) {
//       var sitePhoto = MsSitePhoto(
//         memoryImage: pdfData.siteMemoryImage,
//       );

//       double sitePhotoHeight = pdfHelper.calculateHeightOfWidget(
//         widget: sitePhoto,
//         width: TbMsPdfWidth.pageWidth,
//       );

//       if (sitePhotoHeight <= remainingHeight) {
//         pages[currentPageIndex].add(sitePhoto);
//         remainingHeight -= sitePhotoHeight;
//       } else {
//         // Start a new page
//         pages.add([sitePhoto]);
//         currentPageIndex++;
//         remainingHeight = contentHeight - sitePhotoHeight;
//       }

//       // Add border after site photo
//       pages[currentPageIndex].add(MsBorder());
//       remainingHeight -= borderHeight;
//     }

//     // Process all headers and their content
//     for (HeaderRows headerRow in pdfData.headers) {
//       processHeaderWithPageBreaks(
//         headerRow: headerRow,
//         pages: pages,
//         currentPageIndex: currentPageIndex,
//         remainingHeight: remainingHeight,
//         contentHeight: contentHeight,
//         context: context,
//       );
//     }

//     // Add signature section
//     Widget signatureSection = MsReviewSignatureSection(
//       reviewDate: pdfData.reviewSignature?.date ?? "",
//       reviewUserName: pdfData.reviewSignature?.name,
//       approvalMode: pdfData.approvalMode,
//       reviewSignatureImage: pdfData.reviewSignature?.signatureMemoryImage,
//       userName: pdfData.userSignature.name,
//       userAssessmentDate: pdfData.userSignature.date,
//       userSignature: pdfData.userSignature.signatureMemoryImage,
//       userPosition: pdfData.userSignature.position,
//     );

//     double signatureSectionHeight = pdfHelper.calculateHeightOfWidget(
//       widget: signatureSection,
//       width: TbMsPdfWidth.pageWidth,
//     );

//     if (signatureSectionHeight <= remainingHeight) {
//       pages[currentPageIndex].add(signatureSection);
//       remainingHeight -= signatureSectionHeight;
//     } else {
//       // Start a new page
//       pages.add([signatureSection]);
//       currentPageIndex++;
//       remainingHeight = contentHeight - signatureSectionHeight;
//     }

//     // Add sign-off users if present
//     if ((pdfData.signOffSignatures ?? []).isNotEmpty) {
//       showSignOffUserWithData(
//           signOffUsers: pdfData.signOffSignatures ?? [],
//           pdfHelper: pdfHelper,
//           signOffStatement: pdfData.signOffStatement,
//           pages: pages,
//           currentPageIndex: currentPageIndex,
//           remainingHeight: remainingHeight,
//           contentHeight: contentHeight);
//     }

//     // Add the pages to the PDF
//     pdf.addPage(
//       MultiPage(
//         pageTheme: TbPdfHelper().returnPageTheme(
//           isSubscribed: pdfData.isSubscribed ?? 0,
//           waterMarkImage: pdfHelper.msWaterMarkImage,
//           themeData: pdfHelper.msTheme,
//           pageFormat: const PdfPageFormat(
//             21.0 * PdfPageFormat.cm,
//             29.7 * PdfPageFormat.cm,
//           ),
//         ),
//         build: (context) {
//           // Flatten all pages into a single list
//           List<Widget> allContent = [];
//           for (var page in pages) {
//             allContent.addAll(page);
//           }
//           return allContent;
//         },
//         header: (context) {
//           return MsHeaderRow(
//             pagesNo: context.pageNumber,
//             companyDetails: pdfData.companyDetails,
//             companyPhoneEmail: pdfData.companyPhoneEmail ?? "",
//             titleForPdf: "METHOD ASSESSMENT",
//             companyLogoMemoryImage: pdfData.companyLogoMemoryImage,
//           );
//         },
//         footer: (context) {
//           return MsFooterSection(
//             isSubscribed: pdfData.isSubscribed,
//             referenceNo: pdfData.referenceNo,
//             pageNumber: context.pageNumber.toString(),
//           );
//         },
//       ),
//     );

//     // Continue with RA PDF generation if needed
//     if (pdfData.raPdfData != null && !showMsFirst) {
//       TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
//         pdfData: pdfData.raPdfData!,
//         pdfDocumentFromMs: pdf,
//         pdfHelper: pdfHelper,
//         showMsFirst: showMsFirst,
//       );

//       await raPdfGenerator.generatePDF();
//     }

//     // Return the PDF data
//     if (pdfDocumentFromRa == null) {
//       return await pdf.save();
//     } else {
//       return null;
//     }
//   }

//   Future<Uint8List?> generateaPDF() async {
//     Document pdf = Document();
//     if (pdfDocumentFromRa != null) {
//       pdf = pdfDocumentFromRa!;
//     }

//     // Handle Risk Assessment if present
//     if (pdfData.raPdfData != null && showMsFirst) {
//       TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
//         pdfData: pdfData.raPdfData!,
//         pdfDocumentFromMs: pdf,
//         pdfHelper: pdfHelper,
//         showMsFirst: showMsFirst,
//       );

//       await raPdfGenerator.generatePDF();
//     }

//     await preparePDFImages(pdfData);

//     // Define constants for page layout
//     final double pageHeight = 842; // A4 height in points
//     final double headerHeight = 95; // Estimated header height
//     final double footerHeight = 30; // Estimated footer height
//     final double contentHeight = pageHeight - headerHeight - footerHeight;

//     // We'll maintain a list of pages, each with their own content
//     List<List<Widget>> pages = [[]];
//     int currentPageIndex = 0;
//     double remainingHeight = contentHeight;

//     // Calculate and add project details
//     var projectDetailsSection = MsProjectDetailsSection(
//       projectDetailsSideLeft: pdfData.projectDetails['leftColumn'] ?? [],
//       projectDetailsSideRight: pdfData.projectDetails['rightColumn'] ?? [],
//     );

//     double projectDetailsHeight = pdfHelper.calculateHeightOfWidget(
//       widget: projectDetailsSection,
//       width: TbMsPdfWidth.pageWidth,
//     );

//     if (projectDetailsHeight <= remainingHeight) {
//       pages[currentPageIndex].add(projectDetailsSection);
//       remainingHeight -= projectDetailsHeight;
//     } else {
//       // Start a new page
//       pages.add([projectDetailsSection]);
//       currentPageIndex++;
//       remainingHeight = contentHeight - projectDetailsHeight;
//     }

//     // Add border
//     double borderHeight = 1;
//     pages[currentPageIndex].add(MsBorder());
//     remainingHeight -= borderHeight;

//     // Add site photo if exists
//     if (pdfData.siteMemoryImage != null) {
//       var sitePhoto = MsSitePhoto(
//         memoryImage: pdfData.siteMemoryImage,
//       );

//       double sitePhotoHeight = pdfHelper.calculateHeightOfWidget(
//         widget: sitePhoto,
//         width: TbMsPdfWidth.pageWidth,
//       );

//       if (sitePhotoHeight <= remainingHeight) {
//         pages[currentPageIndex].add(sitePhoto);
//         remainingHeight -= sitePhotoHeight;
//       } else {
//         // Start a new page
//         pages.add([sitePhoto]);
//         currentPageIndex++;
//         remainingHeight = contentHeight - sitePhotoHeight;
//       }

//       // Add border after site photo
//       pages[currentPageIndex].add(MsBorder());
//       remainingHeight -= borderHeight;
//     }

//     // Process all headers and their content
//     for (HeaderRows headerRow in pdfData.headers) {
//       processHeaderWithPageBreaks(
//           headerRow: headerRow,
//           pages: pages,
//           currentPageIndex: currentPageIndex,
//           remainingHeight: remainingHeight,
//           contentHeight: contentHeight,
          
//           );
//     }

//     // Add signature section
//     Widget signatureSection = MsReviewSignatureSection(
//       reviewDate: pdfData.reviewSignature?.date ?? "",
//       reviewUserName: pdfData.reviewSignature?.name,
//       approvalMode: pdfData.approvalMode,
//       reviewSignatureImage: pdfData.reviewSignature?.signatureMemoryImage,
//       userName: pdfData.userSignature.name,
//       userAssessmentDate: pdfData.userSignature.date,
//       userSignature: pdfData.userSignature.signatureMemoryImage,
//       userPosition: pdfData.userSignature.position,
//     );

//     double signatureSectionHeight = pdfHelper.calculateHeightOfWidget(
//       widget: signatureSection,
//       width: TbMsPdfWidth.pageWidth,
//     );

//     if (signatureSectionHeight <= remainingHeight) {
//       pages[currentPageIndex].add(signatureSection);
//       remainingHeight -= signatureSectionHeight;
//     } else {
//       // Start a new page
//       pages.add([signatureSection]);
//       currentPageIndex++;
//       remainingHeight = contentHeight - signatureSectionHeight;
//     }

//     // Add sign-off users if present
//     if ((pdfData.signOffSignatures ?? []).isNotEmpty) {
//       showSignOffUserWithData(
//           signOffUsers: pdfData.signOffSignatures ?? [],
//           pdfHelper: pdfHelper,
//           signOffStatement: pdfData.signOffStatement,
//           pages: pages,
//           currentPageIndex: currentPageIndex,
//           remainingHeight: remainingHeight,
//           contentHeight: contentHeight);
//     }

//     // Add the pages to the PDF
//     pdf.addPage(
//       MultiPage(
//         pageTheme: TbPdfHelper().returnPageTheme(
//           isSubscribed: pdfData.isSubscribed ?? 0,
//           waterMarkImage: pdfHelper.msWaterMarkImage,
//           themeData: pdfHelper.msTheme,
//           pageFormat: const PdfPageFormat(
//             21.0 * PdfPageFormat.cm,
//             29.7 * PdfPageFormat.cm,
//           ),
//         ),
//         build: (context) {
//           // Flatten all pages into a single list
//           List<Widget> allContent = [];
//           for (var page in pages) {
//             allContent.addAll(page);
//           }
//           return allContent;
//         },
//         header: (context) {
//           return MsHeaderRow(
//             pagesNo: context.pageNumber,
//             companyDetails: pdfData.companyDetails,
//             companyPhoneEmail: pdfData.companyPhoneEmail ?? "",
//             titleForPdf: "METHOD ASSESSMENT",
//             companyLogoMemoryImage: pdfData.companyLogoMemoryImage,
//           );
//         },
//         footer: (context) {
//           return MsFooterSection(
//             isSubscribed: pdfData.isSubscribed,
//             referenceNo: pdfData.referenceNo,
//             pageNumber: context.pageNumber.toString(),
//           );
//         },
//       ),
//     );

//     // Continue with RA PDF generation if needed
//     if (pdfData.raPdfData != null && !showMsFirst) {
//       TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
//         pdfData: pdfData.raPdfData!,
//         pdfDocumentFromMs: pdf,
//         pdfHelper: pdfHelper,
//         showMsFirst: showMsFirst,
//       );

//       await raPdfGenerator.generatePDF();
//     }

//     // Return the PDF data
//     if (pdfDocumentFromRa == null) {
//       return await pdf.save();
//     } else {
//       return null;
//     }
//   }

//   void processHeaderWithPageBreaks(
//       {required HeaderRows headerRow,
//       required List<List<Widget>> pages,
//       required int currentPageIndex,
//       required double remainingHeight,
//       required double contentHeight,
//       required Context context // Add context parameter
//       }) {
//     // Create header title widget
//     Widget headerTitleWidget = MsPdfCustomText(
//       text: headerRow.name,
//       padding: headerRow.level == 0
//           ? TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelZero
//           : TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelNotZero,
//       textStyle: headerRow.level == 0
//           ? TbPdfHelper().textStyleGenerator(
//               font: Theme.of(context).header0.fontBold,
//               color: TbMsPdfColors.black,
//               fontSize: 12,
//             )
//           : TbPdfHelper().textStyleGenerator(
//               font: Theme.of(context).header0.fontBold,
//               color: TbMsPdfColors.black,
//               fontSize: 11,
//             ),
//       rowType: 1,
//     );

//     // Calculate header title height
//     double headerTitleHeight = pdfHelper.calculateHeightOfWidget(
//       widget: headerTitleWidget,
//       width: TbMsPdfWidth.pageWidth,
//     );

//     // Check if header title fits on current page
//     if (headerTitleHeight > remainingHeight) {
//       // Start a new page
//       pages.add([]);
//       currentPageIndex++;
//       remainingHeight = contentHeight;
//     }

//     // Add header title to current page
//     pages[currentPageIndex].add(headerTitleWidget);
//     remainingHeight -= headerTitleHeight;

//     // Process nested headers if they exist
//     if ((headerRow.headerRows ?? []).isNotEmpty) {
//       for (HeaderRows nestedHeader in headerRow.headerRows!) {
//         processHeaderWithPageBreaks(
//           headerRow: nestedHeader,
//           pages: pages,
//           currentPageIndex: currentPageIndex,
//           remainingHeight: remainingHeight,
//           contentHeight: contentHeight,
//         );
//       }
//     }
//     // Process hazard icons if they exist
//     else if ((headerRow.hazardIcons ?? []).isNotEmpty) {
//       processHazardIcons(
//           hazardIcons: headerRow.hazardIcons!,
//           pages: pages,
//           currentPageIndex: currentPageIndex,
//           remainingHeight: remainingHeight,
//           contentHeight: contentHeight);
//     }
//     // Process statements if they exist
//     else if ((headerRow.statements ?? []).isNotEmpty) {
//       for (HeaderStatementData statement in headerRow.statements!) {
//         processStatement(
//             statement: statement,
//             pages: pages,
//             currentPageIndex: currentPageIndex,
//             remainingHeight: remainingHeight,
//             contentHeight: contentHeight);
//       }
//     }

//     // Process header images if they exist
//     if ((headerRow.images ?? []).isNotEmpty) {
//       List<MemoryImage> images = [];

//       for (HeaderReferenceImageData image in headerRow.images!) {
//         if (image.memoryImage != null) {
//           images.add(image.memoryImage!);
//         }
//       }

//       if (images.isNotEmpty) {
//         processImages(
//             images: images,
//             pages: pages,
//             currentPageIndex: currentPageIndex,
//             remainingHeight: remainingHeight,
//             contentHeight: contentHeight);
//       }
//     }
//   }

//   void processHazardIcons(
//       {required List<HazardIconData> hazardIcons,
//       required List<List<Widget>> pages,
//       required int currentPageIndex,
//       required double remainingHeight,
//       required double contentHeight}) {
//     // We'll group hazard icons in rows of up to 6 icons per row
//     List<Widget> iconRows = [];
//     List<Widget> currentRowIcons = [];

//     for (int i = 0; i < hazardIcons.length; i++) {
//       HazardIconData iconData = hazardIcons[i];

//       if (iconData.iconMemoryImage != null) {
//         Widget iconWidget = MsStatementHazardIconItem(
//           iconImage: iconData.iconMemoryImage!,
//         );

//         currentRowIcons.add(iconWidget);

//         // Create a row when we have 6 icons or we're at the last icon
//         if (currentRowIcons.length == 6 || i == hazardIcons.length - 1) {
//           Widget iconRow = MsStatementHazardIconsRow(
//             iconsImageList: List.from(currentRowIcons),
//           );

//           double iconRowHeight = pdfHelper.calculateHeightOfWidget(
//             widget: iconRow,
//             width: TbMsPdfWidth.pageWidth,
//           );

//           // Check if row fits on current page
//           if (iconRowHeight > remainingHeight) {
//             // Add the rows we have so far to the current page
//             if (iconRows.isNotEmpty) {
//               pages[currentPageIndex].addAll(iconRows);
//             }

//             // Start a new page
//             pages.add([]);
//             currentPageIndex++;
//             remainingHeight = contentHeight;
//             iconRows = [];
//           }

//           iconRows.add(iconRow);
//           remainingHeight -= iconRowHeight;
//           currentRowIcons = [];
//         }
//       }
//     }

//     // Add any remaining icon rows to the current page
//     if (iconRows.isNotEmpty) {
//       pages[currentPageIndex].addAll(iconRows);
//     }
//   }

//   void processStatement(
//       {required HeaderStatementData statement,
//       required List<List<Widget>> pages,
//       required int currentPageIndex,
//       required double remainingHeight,
//       required double contentHeight}) {
//     // Create statement widget
//     Widget statementWidget = MsStatementRow(
//       statementName: statement.text,
//       statmentTextStyle: TbPdfHelper().textStyleGenerator(
//         font: Theme.of(context).header0.font,
//         color: MsPdfColors.black,
//         fontSize: 11,
//       ),
//     );

//     // Calculate statement height
//     double statementHeight = pdfHelper.calculateHeightOfWidget(
//       widget: statementWidget,
//       width: TbMsPdfWidth.pageWidth,
//     );

//     // Check if statement fits on current page
//     if (statementHeight > remainingHeight) {
//       // Start a new page
//       pages.add([]);
//       currentPageIndex++;
//       remainingHeight = contentHeight;
//     }

//     // Add statement to current page
//     pages[currentPageIndex].add(statementWidget);
//     remainingHeight -= statementHeight;

//     // Process statement images if they exist
//     if ((statement.memoryImages ?? []).isNotEmpty) {
//       processImages(
//           images: statement.memoryImages!,
//           pages: pages,
//           currentPageIndex: currentPageIndex,
//           remainingHeight: remainingHeight,
//           contentHeight: contentHeight);
//     }
//   }

//   void processImages(
//       {required List<MemoryImage> images,
//       required List<List<Widget>> pages,
//       required int currentPageIndex,
//       required double remainingHeight,
//       required double contentHeight}) {
//     // Add padding before images
//     Widget paddingWidget = Container(height: 8);
//     double paddingHeight = pdfHelper.calculateHeightOfWidget(
//       widget: paddingWidget,
//       width: TbMsPdfWidth.pageWidth,
//     );

//     if (paddingHeight > remainingHeight) {
//       // Start a new page
//       pages.add([]);
//       currentPageIndex++;
//       remainingHeight = contentHeight;
//     }

//     pages[currentPageIndex].add(paddingWidget);
//     remainingHeight -= paddingHeight;

//     // Process images in pairs (two per row)
//     List<Widget> rowChildren = [];

//     for (int i = 0; i < images.length; i++) {
//       // Create image box widget
//       MemoryImage memoryImage = images[i];
//       Widget imageBox = MsAssessmentImageBox(
//         image: memoryImage,
//         index: i + 1,
//       );

//       rowChildren.add(imageBox);
//       rowChildren.add(Container(width: 10)); // Add spacing between images

//       // Create a row when we have 2 images or at the last image
//       if (rowChildren.length == 4 || i == images.length - 1) {
//         Widget imageRow = MsAssessmentImageRow(
//           listChildren: List.from(rowChildren),
//         );

//         double imageRowHeight = pdfHelper.calculateHeightOfWidget(
//           widget: imageRow,
//           width: TbMsPdfWidth.pageWidth,
//         );

//         // Check if row fits on current page
//         if (imageRowHeight > remainingHeight) {
//           // Start a new page
//           pages.add([]);
//           currentPageIndex++;
//           remainingHeight = contentHeight;
//         }

//         // Add image row to current page
//         pages[currentPageIndex].add(imageRow);
//         remainingHeight -= imageRowHeight;

//         // Add vertical spacing after row
//         Widget spacingWidget = Container(height: 10);
//         double spacingHeight = pdfHelper.calculateHeightOfWidget(
//           widget: spacingWidget,
//           width: TbMsPdfWidth.pageWidth,
//         );

//         pages[currentPageIndex].add(spacingWidget);
//         remainingHeight -= spacingHeight;

//         // Reset row children for next row
//         rowChildren = [];
//       }
//     }
//   }

//   void showSignOffUserWithData(
//       {required List<ReviewSignOffSignatureData> signOffUsers,
//       required TbPdfHelper pdfHelper,
//       required String? signOffStatement,
//       required List<List<Widget>> pages,
//       required int currentPageIndex,
//       required double remainingHeight,
//       required double contentHeight}) {
//     if (signOffUsers.isEmpty) return;

//     // Add section header with title and statement
//     Widget headerWidget = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "SIGN OFF USERS",
//             style: TbPdfHelper().textStyleGenerator(
//               font: Theme.of(context).header0.fontBold,
//               color: TbMsPdfColors.black,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           if (signOffStatement != null)
//             Text(
//               signOffStatement,
//               style: TbPdfHelper().textStyleGenerator(
//                 font: Theme.of(context).header0.fontNormal,
//                 color: TbMsPdfColors.black,
//                 fontSize: 9,
//               ),
//             ),
//         ],
//       ),
//     );

//     double headerHeight = pdfHelper.calculateHeightOfWidget(
//       widget: headerWidget,
//       width: TbMsPdfWidth.pageWidth,
//     );

//     if (headerHeight > remainingHeight) {
//       // Start a new page
//       pages.add([]);
//       currentPageIndex++;
//       remainingHeight = contentHeight;
//     }

//     pages[currentPageIndex].add(headerWidget);
//     remainingHeight -= headerHeight;

//     // Process sign-off users in pairs
//     for (int i = 0; i < signOffUsers.length; i += 2) {
//       List<Widget> rowChildren = [];

//       // Add first user in the pair
//       rowChildren.add(Container(
//         width: TbMsPdfWidth.pageWidth / 2 - 25, // Half width with padding
//         decoration: BoxDecoration(
//           color: TbMsPdfColors.lightGreyBackground,
//           border: Border.all(width: 0.5, color: PdfColors.grey300),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         margin: const EdgeInsets.only(right: 10),
//         child: MsSignOffSection(
//           user: signOffUsers[i],
//         ),
//       ));

//       // Add second user if available
//       if (i + 1 < signOffUsers.length) {
//         rowChildren.add(
//           MsSignOffSection(
//             user: signOffUsers[i + 1],
//           ),
//         );
//       } else {
//         // Add empty container for even spacing
//         rowChildren.add(Container(
//           width: MsPdfWidth.pageWidth / 2 - 25,
//         ));
//       }

//       // Create a row with these users
//       Widget userRow = Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: rowChildren,
//         ),
//       );

//       double userRowHeight = pdfHelper.calculateHeightOfWidget(
//         widget: userRow,
//         width: TbMsPdfWidth.pageWidth,
//       );

//       if (userRowHeight > remainingHeight) {
//         // Start a new page
//         pages.add([]);
//         currentPageIndex++;
//         remainingHeight = contentHeight;
//       }

//       pages[currentPageIndex].add(userRow);
//       remainingHeight -= userRowHeight;
//     }
//   }

//   Future<Uint8List?> generatePDFold() async {
//     Document pdf = Document();
//     if (pdfDocumentFromRa != null) {
//       pdf = pdfDocumentFromRa!;
//     }

//     if (pdfData.raPdfData != null && showMsFirst) {
//       // RiskAssessmentEntity riskAssessmentEntity =
//       //     msAssessmentEntity!.riskAssessmentEntity!;

//       // RaPdfGenerator raPdfGenerator = RaPdfGenerator(
//       //   platFormLocaleName: platFormLocaleName,
//       //   theRiskAssessmentEntity: riskAssessmentEntity,
//       //   documentsDirPath: documentsDirPath,
//       //   pdfDocumentFromMs: pdf,
//       //   pdfHelper: pdfHelper,
//       //   showMsFirst: showMsFirst,
//       // );
//       TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
//         pdfData: pdfData.raPdfData!,
//         pdfDocumentFromMs: pdf,
//         pdfHelper: pdfHelper,
//         showMsFirst: showMsFirst,
//       );

//       await raPdfGenerator.generatePDF();
//     }

//     await preparePDFImages(pdfData);

//     var projectDetailsSection = MsProjectDetailsSection(
//       projectDetailsSideLeft: pdfData.projectDetails['leftColumn'] ?? [],
//       projectDetailsSideRight: pdfData.projectDetails['rightColumn'] ?? [],
//     );

//     msPdfItems.add(projectDetailsSection);

//     msPdfItems.add(MsBorder());

//     if (pdfData.siteMemoryImage != null) {
//       msPdfItems.add(
//         MsSitePhoto(
//           memoryImage: pdfData.siteMemoryImage,
//         ),
//       );
//     }
//     msPdfItems.add(MsBorder());

//     pdf.addPage(
//       MultiPage(
//         pageTheme: TbPdfHelper().returnPageTheme(
//           isSubscribed: pdfData.isSubscribed ?? 0,
//           waterMarkImage: pdfHelper.msWaterMarkImage,
//           themeData: pdfHelper.msTheme,
//           pageFormat: const PdfPageFormat(
//             21.0 * PdfPageFormat.cm,
//             29.7 * PdfPageFormat.cm,
//           ),
//         ),
//         build: (context) {
//           iterateHeadersForPdfWidets(
//             pdfData: pdfData,
//             context: context,
//           );

//           msPdfItems.addAll(headerWidget);

//           showUserDetailsAndReviewUserOnPdf(
//             pdfData: pdfData,
//             context: context,
//           );

//           showSignOffUserWithData(
//             signOffUsers: pdfData.signOffSignatures ?? [],
//             pdfHelper: pdfHelper,
//             signOffStatement: pdfData.signOffStatement,
//             context: context,
//           );

//           return msPdfItems;
//         },
//         header: (context) {
//           return MsHeaderRow(
//             pagesNo: context.pageNumber,
//             companyDetails: pdfData.companyDetails,
//             companyPhoneEmail: pdfData.companyPhoneEmail ?? "",
//             titleForPdf: "METHOD ASSESSMENT",
//             companyLogoMemoryImage: pdfData.companyLogoMemoryImage,
//           );
//         },
//         footer: (context) {
//           return MsFooterSection(
//             isSubscribed: pdfData.isSubscribed,
//             referenceNo: pdfData.referenceNo,
//             pageNumber: context.pageNumber.toString(),
//           );
//         },
//       ),
//     );

//     // here we are workign for linked RAMS
//     // if risk assessment is avaialbe generate its pdf
//     // String msPdfPath = FileManager.msPdfPath(
//     //      msAssessmentUniqueKey: msAssessmentDto?.uniqueKey ?? "");

//     if (pdfData.raPdfData != null && !showMsFirst) {
//       // RiskAssessmentEntity riskAssessmentEntity =
//       //     msAssessmentEntity!.riskAssessmentEntity!;

//       // RaPdfGenerator raPdfGenerator = RaPdfGenerator(
//       //   platFormLocaleName: platFormLocaleName,
//       //   theRiskAssessmentEntity: riskAssessmentEntity,
//       //   documentsDirPath: documentsDirPath,
//       //   pdfDocumentFromMs: pdf,
//       //   pdfHelper: pdfHelper,
//       //   showMsFirst: showMsFirst,
//       // );
//       TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
//         pdfData: pdfData.raPdfData!,
//         pdfDocumentFromMs: pdf,
//         pdfHelper: pdfHelper,
//         showMsFirst: showMsFirst,
//       );

//       await raPdfGenerator.generatePDF();
//     }

//     if (pdfDocumentFromRa == null) {
//       // final file = File(aPath);

//       var data = await pdf.save();
//       // file.writeAsBytesSync(data);
//       return data;

//       // await FileManager.saveAssessmentPdfFile(
//       //   pdf: pdf,
//       //   pdfPath: msPdfPath,
//       // );
//     }

//     return null;
//   }

//   /* ********************************** */
//   // SHOW USER DETAILS AND REVIEW USER ON PDF
//   /// in this method passed [msAssessmentDto]and
//   /// update the widget of Ms Review Signature Section and
//   /// added into the audit pdf item list
//   /* ************************************ */

//   void showUserDetailsAndReviewUserOnPdf({
//     required MsPdfData pdfData,
//     required Context context,
//   }) {
//     Widget widget = MsReviewSignatureSection(
//       reviewDate: pdfData.reviewSignature?.date ?? "",
//       reviewUserName: pdfData.reviewSignature?.name,
//       approvalMode: pdfData.approvalMode,
//       reviewSignatureImage: pdfData.reviewSignature?.signatureMemoryImage,
//       userName: pdfData.userSignature.name,
//       userAssessmentDate: pdfData.userSignature.date,
//       userSignature: pdfData.userSignature.signatureMemoryImage,
//       userPosition: pdfData.userSignature.position,
//     );
//     msPdfItems.add(widget);
//   }

// /* *************** */
// // CREATE HEADER ROW
//   /// responsible to iterate all the headers of a templates
//   /// and create widgets for header, subHeaders and statements/ hazard icons

// /* ***************** */

//   void iterateHeadersForPdfWidets({
//     required MsPdfData pdfData,
//     required Context context,
//   }) {
//     for (HeaderRows headerRow in pdfData.headers) {
//       createHeaderWidgets(
//         headerRow: headerRow,
//         context: context,
//       );
//     }
//     print(headerWidget);
//   }

// /* ************************************** */
// //  CREATE HEADER WIDGET
//   /// responsible to iterate headers /statements and create widgets
// /* ************************************** */

//   void createHeaderWidgets({
//     required HeaderRows headerRow,
//     required Context context,
//   }) {
//     Widget widget = MsPdfCustomText(
//       text: headerRow.name,
//       padding: headerRow.level == 0
//           ? TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelZero
//           : TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelNotZero,
//       textStyle: headerRow.level == 0
//           // ? msPdfTextStyle.msMainHeaderTextStyle()
//           ? TbPdfHelper().textStyleGenerator(
//               font: Theme.of(context).header0.fontBold,
//               color: TbMsPdfColors.black,
//               fontSize: 12,
//             )
//           : TbPdfHelper().textStyleGenerator(
//               font: Theme.of(context).header0.fontBold,
//               color: TbMsPdfColors.black,
//               fontSize: 11,
//             ),
//     );
//     if (widget is MsPdfCustomText) {
//       widget.rowType = 1;
//     }

//     if (headerRow.level == 0) {
//       NonSplittingWidget headerColumn = NonSplittingWidget(
//         children: [widget],
//       );

//       // Add to headerWidget list
//       headerWidget.add(headerColumn);
//     } else {
//       if (headerWidget.last is NonSplittingWidget) {
//         // Get the column (last widget)
//         NonSplittingWidget column = headerWidget.last as NonSplittingWidget;

//         // Remove the column
//         headerWidget.removeLast();

//         // Add first icon row to column's children
//         List<Widget> updatedChildren = List.from(column.children);
//         updatedChildren.add(widget);

//         // Create new column with updated children
//         NonSplittingWidget updatedColumn = NonSplittingWidget(
//           children: updatedChildren,
//         );

//         // Add updated column back to headerWidget
//         headerWidget.add(updatedColumn);
//       } else {
//         headerWidget.add(widget);
//       }
//     }

//     if ((headerRow.headerRows ?? []).isNotEmpty) {
//       for (HeaderRows headerRow in headerRow.headerRows ?? []) {
//         createHeaderWidgets(
//           headerRow: headerRow,
//           context: context,
//         );
//       }
//     } else if ((headerRow.hazardIcons ?? []).isNotEmpty) {
//       showMsStatementIconsOnPdf(hazardIconData: headerRow.hazardIcons ?? []);
//     } else if ((headerRow.statements ?? []).isNotEmpty) {
//       for (HeaderStatementData statementData in headerRow.statements ?? []) {
//         Widget w = MsStatementRow(
//           statementName: statementData.text,
//           statmentTextStyle: TbPdfHelper().textStyleGenerator(
//             font: Theme.of(context).header0.font,
//             color: MsPdfColors.black,
//             fontSize: 11,
//           ),
//         );
//         // headerWidget.add(w);

//         if (headerWidget.last is NonSplittingWidget) {
//           // Get the column (last widget)
//           NonSplittingWidget column = headerWidget.last as NonSplittingWidget;

//           // Remove the column
//           headerWidget.removeLast();

//           // Add first icon row to column's children
//           List<Widget> updatedChildren = List.from(column.children);
//           updatedChildren.add(w);

//           // Create new column with updated children
//           NonSplittingWidget updatedColumn = NonSplittingWidget(
//             children: updatedChildren,
//           );

//           // Add updated column back to headerWidget
//           headerWidget.add(updatedColumn);
//         } else {
//           headerWidget.add(w);
//         }

//         if ((statementData.memoryImages ?? []).isNotEmpty) {
//           headerWidget.addAll(
//             showStatementImagesOnPdf(
//               images: statementData.memoryImages ?? [],
//             ),
//           );
//         }
//       }
//     }

//     if ((headerRow.images ?? []).isNotEmpty) {
//       List<MemoryImage> images = [];

//       for (HeaderReferenceImageData image in headerRow.images ?? []) {
//         if (image.memoryImage != null) {
//           images.add(image.memoryImage!);
//         }
//       }
//       headerWidget.addAll(
//         showStatementImagesOnPdf(
//           images: images,
//         ),
//       );
//     }
//   }

//   /* *********************************** / 
//     // SHOW STATEMENT IMAGE ON PDF  
    
//     /// 
//    / ************************************ */

//   List<Widget> showStatementImagesOnPdf({
//     List<MemoryImage>? images,
//     bool isHeaderImage = false,
//   }) {
//     List<Widget> imageRowWidgets = [];
//     List<Widget> rowChildren = [];
//     final imagesList = images ?? [];

//     // this if for top padding
//     imageRowWidgets.add(Container(height: 8));

//     // Process images in pairs to create rows
//     for (int i = 0; i < imagesList.length; i++) {
//       // Add the current image to row children
//       MemoryImage memoryImage = imagesList[i];
//       rowChildren.add(
//         MsAssessmentImageBox(
//           image: memoryImage,
//           index: i + 1,
//         ),
//       );

//       // Add spacing between images
//       rowChildren.add(Container(width: 10));

//       // When we have 2 images or we're at the last image, create a row
//       if (rowChildren.length == 4 || i == imagesList.length - 1) {
//         imageRowWidgets.add(
//           MsAssessmentImageRow(
//             listChildren: List.from(rowChildren),
//           ),
//         );

//         // Add vertical spacing after each row
//         imageRowWidgets.add(Container(height: 10));

//         // Clear row children for the next row
//         rowChildren = [];
//       }
//     }

//     return imageRowWidgets;
//   }

// /* ****************************/
// //  SHOW MS STATEMENT ICON ON PDF
//   /// in this method we passed the [msStatementIconDtoList] to get the selected icons image and
//   /// implement the logic of show only 6 icons image in a single row and
//   /// image which came after the 6th one is show on next row
// /*  ************************* */

//   void showMsStatementIconsOnPdf({
//     required List<HazardIconData> hazardIconData,
//   }) {
//     /// this list holds the memory image widget of ms Statement Icons
//     List<Widget> listIconImageItems = [];
//     // this holds the row widget which contain children widget as listIconImageItems
//     List<Widget> listIconRow = [];
//     // this loop for iterating the element of list of StatementIcon
//     // in this loop we have implement the logic to show only 6 image in a single row and image which came after the 6th one
//     // is show on next row
//     // Future.forEach(msStatementHazadIconDtoList, (iconDto) {
//     for (HazardIconData iconData in hazardIconData) {
//       int index = (hazardIconData).indexOf(iconData);

//       MemoryImage? iconImage = iconData.iconMemoryImage;

//       ///logic behind the code is we get the remainder of index of iconImage image by
//       /// taking the modulus of index by 6
//       /// when remainder equals to zero we create new Widget MsStatementHazardIconRow which contains
//       /// the list of listIconImageItems as children and add it this new widget to the list of listIconImageRow
//       /// to show the on pdf page
//       if (index % 6 == 0) {
//         if (index == 0) {
//           if (iconImage != null) {
//             Widget iconWidget = MsStatementHazardIconItem(
//               iconImage: iconImage,
//             );
//             listIconImageItems.add(iconWidget);
//           }
//         } else {
//           var row = MsStatementHazardIconsRow(
//             iconsImageList: listIconImageItems,
//           );
//           listIconRow.add(row);
//           listIconImageItems = [];
//           if (iconImage != null) {
//             Widget iconWidget = MsStatementHazardIconItem(
//               iconImage: iconImage,
//             );
//             listIconImageItems.add(iconWidget);
//           }
//         }
//       } else {
//         if (iconImage != null) {
//           Widget iconWidget = MsStatementHazardIconItem(
//             iconImage: iconImage,
//           );
//           listIconImageItems.add(iconWidget);
//         }
//       }
//     }

//     var row = MsStatementHazardIconsRow(
//       iconsImageList: listIconImageItems,
//     );
//     listIconRow.add(row);

//     headerWidget.addAll(listIconRow);

//     listIconRow = [];

//     listIconImageItems = [];
//   }

//   /// ***********************************
//   ///   SHOW SIGN OFF USER WITH DATA
//   /// this method is responsible showing the sign off in pdf
//   /// ***********************************
//   void showSignOffUserWithData({
//     required Context context,
//     required List<ReviewSignOffSignatureData> signOffUsers,
//     required TbPdfHelper pdfHelper,
//     required String? signOffStatement,
//   }) {
//     if (signOffUsers.isEmpty) return;
//     // Add section divider
//     MsBorder();

//     // Add section header with title and statement
//     // msPdfItems.add(
//     //   Container(
//     //     padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
//     //     child: Column(
//     //       crossAxisAlignment: CrossAxisAlignment.start,
//     //       children: [
//     //         // Title in bold
//     //         Text(
//     //           "SIGN OFF USERS",
//     //           style: TbPdfHelper().textStyleGenerator(
//     //             font: Theme.of(context).header0.fontBold,
//     //             color: TbMsPdfColors.black,
//     //             fontSize: 12,
//     //           ),
//     //         ),
//     //         SizedBox(height: 5),
//     //         // Sign-off statement
//     //         if (signOffStatement != null)
//     //           Text(
//     //             signOffStatement,
//     //             style: TbPdfHelper().textStyleGenerator(
//     //               font: Theme.of(context).header0.fontNormal,
//     //               color: TbMsPdfColors.black,
//     //               fontSize: 9,
//     //             ),
//     //           ),
//     //       ],
//     //     ),
//     //   ),
//     // );

//     // Process sign-off users in pairs
//     for (int i = 0; i < signOffUsers.length; i += 2) {
//       List<Widget> rowChildren = [];

//       // Add first user in the pair
//       rowChildren.add(Container(
//         width: TbMsPdfWidth.pageWidth / 2 - 25, // Half width with padding
//         decoration: BoxDecoration(
//           color: TbMsPdfColors.lightGreyBackground, // Light grey background
//           border: Border.all(width: 0.5, color: PdfColors.grey300),
//           borderRadius: BorderRadius.circular(4), // Rounded corners
//         ),
//         margin: const EdgeInsets.only(right: 10),
//         child: MsSignOffSection(
//           user: signOffUsers[i],
//         ),
//       ));

//       // Add second user if available
//       if (i + 1 < signOffUsers.length) {
//         rowChildren.add(
//           MsSignOffSection(
//             user: signOffUsers[i + 1],
//           ),
//         );
//       } else {
//         // Add empty container for even spacing
//         rowChildren.add(Container(
//           width: MsPdfWidth.pageWidth / 2 - 25, // Half width with padding
//         ));
//       }

//       if (i == 0) {
//         msPdfItems.add(Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 // padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title in bold
//                     Text(
//                       "SIGN OFF USERS",
//                       style: TbPdfHelper().textStyleGenerator(
//                         font: Theme.of(context).header0.fontBold,
//                         color: TbMsPdfColors.black,
//                         fontSize: 12,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     // Sign-off statement
//                     if (signOffStatement != null)
//                       Text(
//                         signOffStatement,
//                         style: TbPdfHelper().textStyleGenerator(
//                           font: Theme.of(context).header0.fontNormal,
//                           color: TbMsPdfColors.black,
//                           fontSize: 9,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: rowChildren,
//               ),
//             ],
//           ),
//         ));
//       } else {
//         msPdfItems.add(Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: rowChildren,
//           ),
//         ));
//       }

//       // Add row to PDF
//     }
//   }

//   Future<void> preparePDFImages(MsPdfData pdfData) async {
//     if (pdfData.siteImage != null) {
//       pdfData.siteMemoryImage =
//           await TbPdfHelper().generateMemoryImageForPath(pdfData.siteImage!);
//     }

//     if (pdfData.userSignature.signature != null) {
//       pdfData.userSignature.signatureMemoryImage =
//           await TbPdfHelper().generateMemoryImageForPath(
//         pdfData.userSignature.signature ?? "",
//       );
//     }

//     if (pdfData.reviewSignature?.signature != null) {
//       pdfData.reviewSignature?.signatureMemoryImage =
//           await TbPdfHelper().generateMemoryImageForPath(
//         pdfData.reviewSignature?.signature ?? "",
//       );
//     }

//     if (pdfData.companyLogo != null) {
//       pdfData.companyLogoMemoryImage =
//           await TbPdfHelper().generateMemoryImageForPath(pdfData.companyLogo!);
//     }
//     await _processReviewSignOff(
//         signOffSignatures: pdfData.signOffSignatures ?? []);

//     await _processHeadersMemoryImagesRecursively(pdfData.headers);
//   }

//   Future<void> _processHeadersMemoryImagesRecursively(
//       List<HeaderRows> headers) async {
//     for (var header in headers) {
//       // Process immediate content of this header
//       await Future.wait([
//         _processStatements(header.statements ?? []),
//         _processHazardIcons(header.hazardIcons ?? []),
//         _processReferenceImages(header.images ?? []),
//       ]);

//       // Process any nested headers recursively
//       if (header.headerRows != null && header.headerRows!.isNotEmpty) {
//         await _processHeadersMemoryImagesRecursively(header.headerRows!);
//       }
//     }
//   }

//   /// Process images in statements
//   Future<void> _processStatements(List<HeaderStatementData> statements) async {
//     // for (var statement in statements) {

//     await Future.forEach(statements, (statement) async {
//       List<MemoryImage> memoryImage = [];
//       await Future.forEach((statement.images ?? []), (image) async {
//         if ((statement.images ?? []).isNotEmpty) {
//           StatementImageData statementImageData = image as StatementImageData;
//           var i = await TbPdfHelper()
//               .generateMemoryImageForPath(statementImageData.image ?? "");
//           if (i != null) {
//             memoryImage.add(i);
//           }
//         }
//       });
//       if (memoryImage.isNotEmpty) {
//         statement.memoryImages = memoryImage;
//       }
//     });
//   }

//   /// Process hazard icons
//   Future<void> _processHazardIcons(List<HazardIconData> hazardIcons) async {
//     for (var hazardIcon in hazardIcons) {
//       if (hazardIcon.icon != null) {
//         hazardIcon.iconMemoryImage =
//             await TbPdfHelper().generateMemoryImageForPath(hazardIcon.icon!);
//       }
//     }
//   }

//   Future<void> _processReviewSignOff(
//       {required List<ReviewSignOffSignatureData> signOffSignatures}) async {
//     for (ReviewSignOffSignatureData signOff in signOffSignatures) {
//       if ((signOff.signature ?? "").isNotEmpty) {
//         signOff.signatureMemoryImage =
//             await TbPdfHelper().generateMemoryImageForPath(signOff.signature!);
//       }
//     }
//   }

//   /// Process reference images
//   Future<void> _processReferenceImages(
//       List<HeaderReferenceImageData> images) async {
//     for (var image in images) {
//       if (image.image != null) {
//         image.memoryImage =
//             await TbPdfHelper().generateMemoryImageForPath(image.image!);
//       }
//     }
//   }
// }
