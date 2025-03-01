import 'dart:typed_data';

import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_data.dart';

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

import '../utils/pdf/tb_pdf_helper.dart';

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

          showUserDetailsAndReviewUserOnPdf(
            pdfData: pdfData,
            context: context,
          );

          showSignOffUserWithData(
            signOffUsers: pdfData.signOffSignatures ?? [],
            pdfHelper: pdfHelper,
            signOffStatement: pdfData.signOffStatement,
            context: context,
          );

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
      createHeaderWidgets(
        headerRow: headerRow,
        context: context,
      );
    }
    print(headerWidget);
  }

/* ************************************** */
//  CREATE HEADER WIDGET
  /// responsible to iterate headers /statements and create widgets
/* ************************************** */

  void createHeaderWidgets({
    required HeaderRows headerRow,
    required Context context,
  }) {
    Widget widget = MsPdfCustomText(
      text: headerRow.name,
      padding: headerRow.level == 0
          ? TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelZero
          : TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelNotZero,
      textStyle: headerRow.level == 0
          // ? msPdfTextStyle.msMainHeaderTextStyle()
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
    if (widget is MsPdfCustomText) {
      widget.rowType = 1;
    }

    headerWidget.add(widget);

    if ((headerRow.headerRows ?? []).isNotEmpty) {
      for (HeaderRows headerRow in headerRow.headerRows ?? []) {
        createHeaderWidgets(
          headerRow: headerRow,
          context: context,
        );
      }
    } else if ((headerRow.hazardIcons).isNotEmpty) {
      showMsStatementIconsOnPdf(hazardIconData: headerRow.hazardIcons);
    } else if ((headerRow.statements).isNotEmpty) {
      for (HeaderStatementData statementData in headerRow.statements) {
        Widget w = MsStatementRow(
          statementName: statementData.text,
          statmentTextStyle: TbPdfHelper().textStyleGenerator(
            font: Theme.of(context).header0.font,
            color: MsPdfColors.black,
            fontSize: 11,
          ),
        );
        headerWidget.add(w);

        if ((statementData.memoryImages ?? []).isNotEmpty) {
          headerWidget.addAll(
            showStatementImagesOnPdf(
              images: statementData.memoryImages ?? [],
            ),
          );
        }
      }
    }

    if ((headerRow.images ?? []).isNotEmpty) {
      List<MemoryImage> images = [];

      for (HeaderReferenceImageData image in headerRow.images) {
        if (image.memoryImage != null) {
          images.add(image.memoryImage!);
        }
      }
      headerWidget.addAll(
        showStatementImagesOnPdf(
          images: images,
        ),
      );
    }
  }

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
    msPdfItems.add(
      Container(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
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
    );

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

      // Add row to PDF
      msPdfItems.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowChildren,
        ),
      ));
    }
  }

  // void showSignOffUserWithData({
  //   required Context context,
  //   required List<ReviewSignOffSignatureData> signOffUsers,
  //   required TbPdfHelper pdfHelper,
  //   required String? signOffStatement,
  // }) {
  //   // Add section divider
  //   msPdfItems.add(MsBorder());

  //   // Add section header with title and statement
  //   msPdfItems.add(
  //     Container(
  //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Title in bold
  //           Text(
  //             "SIGN OFF USERS",
  //             style: TbPdfHelper().textStyleGenerator(
  //               font: Theme.of(context).header0.fontBold,
  //               color: TbMsPdfColors.black,
  //               fontSize: 12,
  //             ),
  //           ),
  //           SizedBox(height: 5),
  //           // Sign-off statement
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
  //     ),
  //   );

  //   // Add spacing after header
  //   msPdfItems.add(SizedBox(height: 10));

  //   // Lists to hold widgets
  //   List<Widget> listSignOffUserItem = [];
  //   List<Widget> listSignOffUserRow = [];

  //   // Process all sign-off users
  //   for (int i = 0; i < signOffUsers.length; i++) {
  //     var signOffUser = signOffUsers[i];

  //     // Create widget for this sign-off user
  //     Widget reviewSignWidget = MsSignOffSection(
  //       user: signOffUser,
  //     );

  //     listSignOffUserItem.add(reviewSignWidget);

  //     // Create a row after every 2 items or at the end
  //     int result = (i + 1) % 2;
  //     if (result == 0) {
  //       var row = MsReviewSignOffUserRow(listOfSignOff: listSignOffUserItem);
  //       listSignOffUserRow.add(row);
  //       listSignOffUserRow.add(Container(height: 10));
  //       listSignOffUserItem = [];
  //     }
  //   }

  //   // Handle any remaining sign-off items (odd number case)
  //   if (listSignOffUserItem.isNotEmpty) {
  //     var row = MsReviewSignOffUserRow(listOfSignOff: listSignOffUserItem);
  //     listSignOffUserRow.add(row);
  //     listSignOffUserRow.add(Container(height: 10));
  //   }

  //   // Add all sign-off rows to the PDF
  //   msPdfItems.addAll(listSignOffUserRow);
  // }
  // void showSignOffUserWithData({
  //   required Context context,
  //   required List<ReviewSignOffSignatureData> signOffUsers,
  //   required TbPdfHelper pdfHelper,
  //   required String? signOffStatement,
  // }) {
  //   msPdfItems.add(MsBorder());
  //   msPdfItems.add(
  //     Container(
  //       color: MsPdfColors.greyCompanyDetailsBackground,
  //       padding: MsPdfPaddings.pageHorizontalPadding,
  //       child: Column(children: [
  //         MsPdfCustomText(
  //           text: "SIGN OFF USERS",
  //           textStyle: TbPdfHelper().textStyleGenerator(
  //             font: Theme.of(context).header0.fontBold,
  //             color: TbMsPdfColors.black,
  //             fontSize: 12,
  //           ),
  //         ),
  //         MsPdfCustomText(
  //           text: pdfData.signOffStatement,
  //           textStyle: TbPdfHelper().textStyleGenerator(
  //             font: Theme.of(context).header0.fontNormal,
  //             color: TbMsPdfColors.black,
  //             fontSize: 9,
  //           ),
  //         ),
  //       ]),
  //     ),
  //   );

  //   // Lists to hold widgets
  //   List<Widget> listSignOffUserItem = [];
  //   List<Widget> listSignOffUserRow = [];

  //   // Process all sign-off users
  //   for (int i = 0; i < signOffUsers.length; i++) {
  //     var signOffUser = signOffUsers[i];

  //     // Create widget for this sign-off user
  //     Widget reviewSignWidget = MsSignOffSection(
  //       user: signOffUser,
  //     );

  //     listSignOffUserItem.add(reviewSignWidget);

  //     // Create a row after every 2 items or at the end
  //     int result = (i + 1) % 2;
  //     if (result == 0) {
  //       var row = MsReviewSignOffUserRow(listOfSignOff: listSignOffUserItem);
  //       listSignOffUserRow.add(row);
  //       listSignOffUserRow.add(Container(height: 10));
  //       listSignOffUserItem = [];
  //     }
  //   }

  //   // Handle any remaining sign-off items (odd number case)
  //   if (listSignOffUserItem.isNotEmpty) {
  //     var row = MsReviewSignOffUserRow(listOfSignOff: listSignOffUserItem);
  //     listSignOffUserRow.add(row);
  //     listSignOffUserRow.add(Container(height: 10));
  //   }
  //   msPdfItems.addAll(listSignOffUserRow);
  // }

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
    await _processHeadersMemoryImagesRecursively(pdfData.headers);
  }

  Future<void> _processHeadersMemoryImagesRecursively(
      List<HeaderRows> headers) async {
    for (var header in headers) {
      // Process immediate content of this header
      await Future.wait([
        _processStatements(header.statements),
        _processHazardIcons(header.hazardIcons),
        _processReferenceImages(header.images),
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
        if ((statement.memoryImages ?? []).isEmpty) {
          var i = await TbPdfHelper().generateMemoryImageForPath(image);
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
