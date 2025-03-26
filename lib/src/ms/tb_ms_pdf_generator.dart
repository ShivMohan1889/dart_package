import 'dart:typed_data';

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';

import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_assessment_image_box.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_assessment_image_row.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_border.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_pdf_custom_text.dart';
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

  // this list holds the Ms Assessment Image

  // list of widgets that show Detials related to ms Assessment in pdf
  List<Widget> msPdfItems = List.empty(growable: true);

  // holds the memory image of company logo
  MemoryImage? companyLogo;

  Future<Uint8List?> generatePDF() async {
    Document pdf = Document();
    if (pdfDocumentFromRa != null) {
      pdf = pdfDocumentFromRa!;
    }

    if (pdfData.raPdfData != null && showMsFirst) {
      // RiskAssessmentEntity riskAssessmentEntity =
      //     msAssessmentEntity!.riskAssessmentEntity!;

      // RaPdfGenerator raPdfGenerator = RaPdfGenerator(
      //   platFormLocaleName: platFormLocaleName,
      //   theRiskAssessmentEntity: riskAssessmentEntity,
      //   documentsDirPath: documentsDirPath,
      //   pdfDocumentFromMs: pdf,
      //   pdfHelper: pdfHelper,
      //   showMsFirst: showMsFirst,
      // );
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

    msPdfItems.add(projectDetailsSection);

    msPdfItems.add(MsBorder());

    if (pdfData.siteMemoryImage != null) {
      msPdfItems.add(
        MsSitePhoto(
          memoryImage: pdfData.siteMemoryImage,
        ),
      );
    }
    msPdfItems.add(MsBorder());

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
          iterateHeadersForPdfWidets(
            pdfData: pdfData,
            context: context,
          );

          msPdfItems.addAll(headerWidget);

          // showUserDetailsAndReviewUserOnPdf(
          //   pdfData: pdfData,
          //   context: context,
          // );

          // showSignOffUserWithData(
          //   signOffUsers: pdfData.signOffSignatures ?? [],
          //   pdfHelper: pdfHelper,
          //   signOffStatement: pdfData.signOffStatement,
          //   context: context,
          // );

          return msPdfItems;
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

    // here we are workign for linked RAMS
    // if risk assessment is avaialbe generate its pdf
    // String msPdfPath = FileManager.msPdfPath(
    //      msAssessmentUniqueKey: msAssessmentDto?.uniqueKey ?? "");

    if (pdfData.raPdfData != null && !showMsFirst) {
      // RiskAssessmentEntity riskAssessmentEntity =
      //     msAssessmentEntity!.riskAssessmentEntity!;

      // RaPdfGenerator raPdfGenerator = RaPdfGenerator(
      //   platFormLocaleName: platFormLocaleName,
      //   theRiskAssessmentEntity: riskAssessmentEntity,
      //   documentsDirPath: documentsDirPath,
      //   pdfDocumentFromMs: pdf,
      //   pdfHelper: pdfHelper,
      //   showMsFirst: showMsFirst,
      // );
      TbRaPdfGenerator raPdfGenerator = TbRaPdfGenerator(
        pdfData: pdfData.raPdfData!,
        pdfDocumentFromMs: pdf,
        pdfHelper: pdfHelper,
        showMsFirst: showMsFirst,
      );

      await raPdfGenerator.generatePDF();
    }

    if (pdfDocumentFromRa == null) {
      // final file = File(aPath);

      var data = await pdf.save();
      // file.writeAsBytesSync(data);
      return data;

      // await FileManager.saveAssessmentPdfFile(
      //   pdf: pdf,
      //   pdfPath: msPdfPath,
      // );
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

  void iterateHeadersForPdfWidets({
    required MsPdfData pdfData,
    required Context context,
  }) {
    for (HeaderRows headerRow in pdfData.headers) {
      List<Widget> headerWidgets = createHeaderWidgets(
        headerRow: headerRow,
        context: context,
      );
      headerWidget.addAll(headerWidgets);
    }
    print(headerWidget);
  }

  // void iterateHeadersForPdfWidets({
  //   required MsPdfData pdfData,
  //   required Context context,
  // }) {
  //   for (HeaderRows headerRow in pdfData.headers) {
  //     createHeaderWidgets(
  //       headerRow: headerRow,
  //       context: context,
  //     );
  //   }
  //   print(headerWidget);
  // }

/* ************************************** */
//  CREATE HEADER WIDGET
  /// responsible to iterate headers /statements and create widgets
/* ************************************** */

  // List<Widget> createHeaderWidgets({
  //   required HeaderRows headerRow,
  //   required Context context,
  // }) {
  //   List<Widget> result = [];

  //   // Create the header widget
  //   Widget widget = MsPdfCustomText(
  //     text: headerRow.name,
  //     padding: headerRow.level == 0
  //         ? TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelZero
  //         : TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelNotZero,
  //     textStyle: headerRow.level == 0
  //         ? TbPdfHelper().textStyleGenerator(
  //             font: Theme.of(context).header0.fontBold,
  //             color: TbMsPdfColors.black,
  //             fontSize: 12,
  //           )
  //         : TbPdfHelper().textStyleGenerator(
  //             font: Theme.of(context).header0.fontBold,
  //             color: TbMsPdfColors.black,
  //             fontSize: 11,
  //           ),
  //   );

  //   if (widget is MsPdfCustomText) {
  //     widget.rowType = 1;
  //   }

  //   // Add the header to our result list
  //   result.add(widget);

  //   // Now handle the different cases for what follows the header
  //   if ((headerRow.headerRows ?? []).isNotEmpty) {
  //     // Process subheaders recursively
  //     for (HeaderRows subHeader in headerRow.headerRows ?? []) {
  //       List<Widget> subHeaderWidgets = createHeaderWidgets(
  //         headerRow: subHeader,
  //         context: context,
  //       );
  //       result.addAll(subHeaderWidgets);
  //     }
  //   } else if ((headerRow.hazardIcons ?? []).isNotEmpty) {
  //     // Add hazard icons
  //     List<Widget> iconRows = [];
  //     showMsStatementIconsOnPdf(
  //       hazardIconData: headerRow.hazardIcons ?? [],
  //       outputList: iconRows,
  //     );
  //     result.addAll(iconRows);
  //   } else if ((headerRow.statements ?? []).isNotEmpty) {
  //     // For statements, we'll wrap the header with the first statement
  //     List<Widget> statementWidgets = [];

  //     for (HeaderStatementData statementData in headerRow.statements ?? []) {
  //       Widget statementWidget = MsStatementRow(
  //         statementName: statementData.text,
  //         statmentTextStyle: TbPdfHelper().textStyleGenerator(
  //           font: Theme.of(context).header0.font,
  //           color: MsPdfColors.black,
  //           fontSize: 11,
  //         ),
  //       );
  //       statementWidgets.add(statementWidget);

  //       if ((statementData.memoryImages ?? []).isNotEmpty) {
  //         statementWidgets.addAll(
  //           showStatementImagesOnPdf(
  //             images: statementData.memoryImages ?? [],
  //           ),
  //         );
  //       }
  //     }

  //     // If there are statements, take the first one and group it with the header
  //     if (statementWidgets.isNotEmpty) {
  //       // Remove the header from result as we'll add it back grouped
  //       result.removeLast();

  //       // Create a group with header and first statement
  //       Widget headerWithFirstStatement = Row(children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             widget, // The header
  //             statementWidgets.first, // The first statement
  //           ],
  //         ),
  //       ]);

  //       result.add(headerWithFirstStatement);

  //       // Add remaining statements (if any)
  //       if (statementWidgets.length > 1) {
  //         result.addAll(statementWidgets.sublist(1));
  //       }
  //     }
  //   }

  //   // Add any header images
  //   if ((headerRow.images ?? []).isNotEmpty) {
  //     List<MemoryImage> images = [];

  //     for (HeaderReferenceImageData image in headerRow.images ?? []) {
  //       if (image.memoryImage != null) {
  //         images.add(image.memoryImage!);
  //       }
  //     }

  //     result.addAll(
  //       showStatementImagesOnPdf(
  //         images: images,
  //       ),
  //     );
  //   }

  //   return result;
  // }

  // void createHeaderWidgets({
  //   required HeaderRows headerRow,
  //   required Context context,
  // }) {
  //   Widget widget = MsPdfCustomText(
  //     text: headerRow.name,
  //     padding: headerRow.level == 0
  //         ? TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelZero
  //         : TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelNotZero,
  //     textStyle: headerRow.level == 0
  //         // ? msPdfTextStyle.msMainHeaderTextStyle()
  //         ? TbPdfHelper().textStyleGenerator(
  //             font: Theme.of(context).header0.fontBold,
  //             color: TbMsPdfColors.black,
  //             fontSize: 12,
  //           )
  //         : TbPdfHelper().textStyleGenerator(
  //             font: Theme.of(context).header0.fontBold,
  //             color: TbMsPdfColors.black,
  //             fontSize: 11,
  //           ),
  //   );
  //   if (widget is MsPdfCustomText) {
  //     widget.rowType = 1;
  //   }

  //   headerWidget.add(widget);

  //   if ((headerRow.headerRows ?? []).isNotEmpty) {
  //     for (HeaderRows headerRow in headerRow.headerRows ?? []) {
  //       createHeaderWidgets(
  //         headerRow: headerRow,
  //         context: context,
  //       );
  //     }
  //   } else if ((headerRow.hazardIcons ?? []).isNotEmpty) {
  //     showMsStatementIconsOnPdf(hazardIconData: headerRow.hazardIcons ?? []);
  //   } else if ((headerRow.statements ?? []).isNotEmpty) {
  //     for (HeaderStatementData statementData in headerRow.statements ?? []) {
  //       Widget w = MsStatementRow(
  //         statementName: statementData.text,
  //         statmentTextStyle: TbPdfHelper().textStyleGenerator(
  //           font: Theme.of(context).header0.font,
  //           color: MsPdfColors.black,
  //           fontSize: 11,
  //         ),
  //       );
  //       headerWidget.add(w);

  //       if ((statementData.memoryImages ?? []).isNotEmpty) {
  //         headerWidget.addAll(
  //           showStatementImagesOnPdf(
  //             images: statementData.memoryImages ?? [],
  //           ),
  //         );
  //       }
  //     }
  //   }

  //   if ((headerRow.images ?? []).isNotEmpty) {
  //     List<MemoryImage> images = [];

  //     for (HeaderReferenceImageData image in headerRow.images ?? []) {
  //       if (image.memoryImage != null) {
  //         images.add(image.memoryImage!);
  //       }
  //     }
  //     headerWidget.addAll(
  //       showStatementImagesOnPdf(
  //         images: images,
  //       ),
  //     );
  //   }
  // }

  /* *********************************** / 
    // SHOW STATEMENT IMAGE ON PDF  
    
    /// 
   / ************************************ */

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

  List<Widget> createHeaderWidgets({
    required HeaderRows headerRow,
    required Context context,
  }) {
    List<Widget> result = [];

    // Create the header widget
    Widget headerWidget = MsPdfCustomText(
      text: headerRow.name,
      padding: headerRow.level == 0
          ? TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelZero
          : TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelNotZero,
      textStyle: headerRow.level == 0
          ? TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbMsPdfColors.black,
              fontSize: 12,
            )
          : TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbMsPdfColors.black,
              fontSize: 11,
            ),
    );

    if (headerWidget is MsPdfCustomText) {
      headerWidget.rowType = 1;
    }

    // Check if this is a leaf header (has statements or icons but no subheaders)
    if ((headerRow.headerRows ?? []).isEmpty) {
      // It's a leaf header
      if ((headerRow.statements ?? []).isNotEmpty) {
        // Has statements - group header with first statement
        List<Widget> statementWidgets = [];

        // Process first statement only
        HeaderStatementData firstStatement = headerRow.statements!.first;
        Widget statementWidget = MsStatementRow(
          statementName: firstStatement.text,
          statmentTextStyle: TbPdfHelper().textStyleGenerator(
            font: Theme.of(context).header0.font,
            color: MsPdfColors.black,
            fontSize: 11,
          ),
        );
        statementWidgets.add(statementWidget);

        // Add statement images if any
        if ((firstStatement.memoryImages ?? []).isNotEmpty) {
          statementWidgets.addAll(
            showStatementImagesOnPdf(
              images: firstStatement.memoryImages ?? [],
            ),
          );
        }

        // Group header with first statement
        result.add(Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget,
              ...statementWidgets,
            ],
          ),
        ));

        // Add remaining statements separately
        for (int i = 1; i < (headerRow.statements ?? []).length; i++) {
          HeaderStatementData statementData = headerRow.statements![i];
          Widget statementWidget = MsStatementRow(
            statementName: statementData.text,
            statmentTextStyle: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: MsPdfColors.black,
              fontSize: 11,
            ),
          );
          result.add(statementWidget);

          if ((statementData.memoryImages ?? []).isNotEmpty) {
            result.addAll(
              showStatementImagesOnPdf(
                images: statementData.memoryImages ?? [],
              ),
            );
          }
        }
      } else if ((headerRow.hazardIcons ?? []).isNotEmpty) {
        // Has hazard icons - group header with icons
        List<Widget> iconRows = [];
        showMsStatementIconsOnPdf(
          hazardIconData: headerRow.hazardIcons ?? [],
          outputList: iconRows,
        );

        result.add(Container(
            child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget,
              ...iconRows,
            ],
          ),
        ])));
      } else {
        // Just a header with no content
        result.add(headerWidget);
      }

      // Add header images if any
      if ((headerRow.images ?? []).isNotEmpty) {
        List<MemoryImage> images = [];
        for (HeaderReferenceImageData image in headerRow.images ?? []) {
          if (image.memoryImage != null) {
            images.add(image.memoryImage!);
          }
        }
        result.addAll(
          showStatementImagesOnPdf(
            images: images,
          ),
        );
      }
    } else {
      // It's a parent header with subheaders
      // Process all subheaders
      List<Widget> allSubheaderWidgets = [];

      for (HeaderRows subHeader in headerRow.headerRows!) {
        List<Widget> subHeaderWidgets = createHeaderWidgets(
          headerRow: subHeader,
          context: context,
        );
        allSubheaderWidgets.addAll(subHeaderWidgets);
      }

      // Group this header with its subheaders
      result.add(Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget,
          ...allSubheaderWidgets,
        ],
      )));
    }

    return result;
  }

/* ****************************/
//  SHOW MS STATEMENT ICON ON PDF
  /// in this method we passed the [msStatementIconDtoList] to get the selected icons image and
  /// implement the logic of show only 6 icons image in a single row and
  /// image which came after the 6th one is show on next row
/*  ************************* */

  void showMsStatementIconsOnPdf({
    required List<HazardIconData> hazardIconData,
    required List<Widget> outputList,
  }) {
    /// this list holds the memory image widget of ms Statement Icons
    List<Widget> listIconImageItems = [];
    // this holds the row widget which contain children widget as listIconImageItems
    List<Widget> listIconRow = [];

    // this loop for iterating the element of list of StatementIcon
    // in this loop we have implement the logic to show only 6 image in a single row and image which came after the 6th one
    // is show on next row
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

    // Add the last row if it has any items
    if (listIconImageItems.isNotEmpty) {
      var row = MsStatementHazardIconsRow(
        iconsImageList: listIconImageItems,
      );
      listIconRow.add(row);
    }

    // Add all rows to the output list instead of headerWidget
    outputList.addAll(listIconRow);
  }

  // void showMsStatementIconsOnPdf({
  //   required List<HazardIconData> hazardIconData,
  // }) {
  //   /// this list holds the memory image widget of ms Statement Icons
  //   List<Widget> listIconImageItems = [];
  //   // this holds the row widget which contain children widget as listIconImageItems
  //   List<Widget> listIconRow = [];
  //   // this loop for iterating the element of list of StatementIcon
  //   // in this loop we have implement the logic to show only 6 image in a single row and image which came after the 6th one
  //   // is show on next row
  //   // Future.forEach(msStatementHazadIconDtoList, (iconDto) {
  //   for (HazardIconData iconData in hazardIconData) {
  //     int index = (hazardIconData).indexOf(iconData);

  //     MemoryImage? iconImage = iconData.iconMemoryImage;

  //     ///logic behind the code is we get the remainder of index of iconImage image by
  //     /// taking the modulus of index by 6
  //     /// when remainder equals to zero we create new Widget MsStatementHazardIconRow which contains
  //     /// the list of listIconImageItems as children and add it this new widget to the list of listIconImageRow
  //     /// to show the on pdf page
  //     if (index % 6 == 0) {
  //       if (index == 0) {
  //         if (iconImage != null) {
  //           Widget iconWidget = MsStatementHazardIconItem(
  //             iconImage: iconImage,
  //           );
  //           listIconImageItems.add(iconWidget);
  //         }
  //       } else {
  //         var row = MsStatementHazardIconsRow(
  //           iconsImageList: listIconImageItems,
  //         );
  //         listIconRow.add(row);
  //         listIconImageItems = [];
  //         if (iconImage != null) {
  //           Widget iconWidget = MsStatementHazardIconItem(
  //             iconImage: iconImage,
  //           );
  //           listIconImageItems.add(iconWidget);
  //         }
  //       }
  //     } else {
  //       if (iconImage != null) {
  //         Widget iconWidget = MsStatementHazardIconItem(
  //           iconImage: iconImage,
  //         );
  //         listIconImageItems.add(iconWidget);
  //       }
  //     }
  //   }

  //   var row = MsStatementHazardIconsRow(
  //     iconsImageList: listIconImageItems,
  //   );
  //   listIconRow.add(row);

  //   headerWidget.addAll(listIconRow);

  //   listIconRow = [];

  //   listIconImageItems = [];
  // }

  /// ***********************************
  ///   SHOW SIGN OFF USER WITH DATA
  /// this method is responsible showing the sign off in pdf
  /// ***********************************
  void showSignOffUserWithData({
    required Context context,
    required List<ReviewSignOffSignatureData> signOffUsers,
    required TbPdfHelper pdfHelper,
    required String? signOffStatement,
  }) {
    if (signOffUsers.isEmpty) return;
    // Add section divider
    MsBorder();

    // Add section header with title and statement
    // msPdfItems.add(
    //   Container(
    //     padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // Title in bold
    //         Text(
    //           "SIGN OFF USERS",
    //           style: TbPdfHelper().textStyleGenerator(
    //             font: Theme.of(context).header0.fontBold,
    //             color: TbMsPdfColors.black,
    //             fontSize: 12,
    //           ),
    //         ),
    //         SizedBox(height: 5),
    //         // Sign-off statement
    //         if (signOffStatement != null)
    //           Text(
    //             signOffStatement,
    //             style: TbPdfHelper().textStyleGenerator(
    //               font: Theme.of(context).header0.fontNormal,
    //               color: TbMsPdfColors.black,
    //               fontSize: 9,
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    // );

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
        msPdfItems.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
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
        ));
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
}
