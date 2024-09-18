import 'dart:io';

import 'package:dart_pdf_package/src/audit/dto/user_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_assessment_statement_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_header_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_statement_dto.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_company_details_row.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_pdf_custom_text.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_project_details_section.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_statement_row.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/tb_ms_pdf_constants.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import '../../utils/enums/enum/review_sign_off_mode.dart';
import '../../utils/enums/enum/review_sign_off_user_type.dart';
import '../../utils/pdf/tb_pdf_helper.dart';
import '../../utils/tb_file_manager/tb_file_manager.dart';
import '../dto/ms_assessment_dto.dart';
import '../dto/ms_assessment_hazard_icon_dto.dart';
import '../dto/ms_assessment_image_dto.dart';
import '../dto/ms_statement_hazard_icon_dto.dart';
import '../dto/ms_template_dto.dart';
import '../dto/ms_template_value_dto.dart';
import '../dto/review_sign_off_dto.dart';
import 'ms_pdf_widget/ms_Assessment_image_Column.dart';
import 'ms_pdf_widget/ms_footer_section.dart';
import 'ms_pdf_widget/ms_header_row.dart';
import 'ms_pdf_widget/ms_review_sign_off_user_row.dart';
import 'ms_pdf_widget/ms_review_signature_section.dart';
import 'ms_pdf_widget/ms_sign_off_section.dart';
import 'ms_pdf_widget/ms_statement_hazard_icon_item.dart';
import 'ms_pdf_widget/ms_statement_hazard_icons_row.dart';

class TbMsPdfGenerator {
  /// holds the Ms Assessment Dto
  final MsAssessmentDto? msAssessmentDto;
  String pathToWritePDF;

  Document? pdfDocumentFromRa;
  late TbPdfHelper pdfHelper;
  final String platFormLocaleName;

  TbMsPdfGenerator({
    required this.msAssessmentDto,
    // required this.documentsDirPath,
    required this.pdfHelper,
    this.pdfDocumentFromRa,
    required this.platFormLocaleName,
    required this.pathToWritePDF,
  });

  final msPdfTextStyle = TbMsPdfTextStyles();

  /// holds all the data related to a header  like header name, statements and hazard icons
  List<Widget> headerWidget = List.empty(growable: true);

  // this list holds the Ms Assessment Image
  List<MsAssessmentImageDto> listImage = List.empty(growable: true);

  // list of widgets that show Detials related to ms Assessment in pdf
  List<Widget> msPdfItems = List.empty(growable: true);

  // holds the memory image of company logo
  MemoryImage? companyLogo;

  Future<void> generatePDF() async {
    Document pdf = Document();
    if (pdfDocumentFromRa != null) {
      pdf = pdfDocumentFromRa!;
    }

    await preparePDFImages(
      msAssessmentDto!,
    );

    // TbFileManager.documentsDirectoryPathString = documentsDirPath;
    var companyDetailsRow =
        MsCompanyDetailsRow(msAssessmentDto: msAssessmentDto);

    companyLogo = msAssessmentDto?.companyDto?.companyLogoMemoryImage;

    msPdfItems.add(companyDetailsRow);
    // msPdfItems.add(
    //   Container(
    //     height: 5,
    //     color: PdfColors.red,
    //   ),
    // );
    var list = (msAssessmentDto?.listMsTemplateValues ?? [])
        .where((element) => element.keyName == "Created On")
        .toList();
    if ((list).isEmpty) {
      updateTemplateFields(
        msAssessmentDto: msAssessmentDto,
      );
    }

    var projectDetailsSection = MsProjectDetailsSection(
      msAssessmentDto: msAssessmentDto,
      localeName: platFormLocaleName,
    );

    msPdfItems.add(projectDetailsSection);

    //border between project details and headers
    msPdfItems.add(Container(
      width: TbMsPdfWidth.pageWidth,
      height: 2,
      color: TbMsPdfColors.projectDetailsBorderColor,
    ));

    await updateSelectedStatementInTemplate(
      msTemplateDto: msAssessmentDto?.templateDto,
      listMsAssessmentStatementList:
          msAssessmentDto?.listMsAssessmentStatement ?? [],
      listMsAssessmentIconList: msAssessmentDto?.msAssessmentIconList ?? [],
    );

    // if (msAssessmentDto?.riskAssessmentDto != null) {
    //   RiskAssessmentDto riskAssessmentDto =
    //       msAssessmentDto!.riskAssessmentDto!;

    //   RaPdfGenerator raPdfGenerator = RaPdfGenerator(
    //     platFormLocaleName: platFormLocaleName,
    //     theRiskAssessmentDto: riskAssessmentDto,
    //     documentsDirPath: documentsDirPath,
    //     pdfDocumentFromMs: pdf,
    //     pdfHelper: pdfHelper,
    //   );

    //   await raPdfGenerator.generatePDF();
    // }

    pdf.addPage(
      MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          isSubcribed: msAssessmentDto?.isSubscribed ?? 0,
          waterMarkImage: pdfHelper.msWaterMarkImage,
          themeData: pdfHelper.msTheme,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
        ),
        build: (context) {
          iterateHeadersForPdfWidets(
            context: context,
          );

          msPdfItems.addAll(headerWidget);

          showUserDetailsAndReviewUserOnPdf(
            msAssessmentDto: msAssessmentDto,
          );

          return msPdfItems;
        },
        header: (context) {
          return MsHeaderRow(
            localeName: platFormLocaleName,
            msAssessmentDto: msAssessmentDto,
            pagesNo: context.pageNumber,
            companyLogo: companyLogo,
          );
        },
        footer: (context) {
          return MsFooterSection(
            msAssessmentDto: msAssessmentDto,
            pageNumber: context.pageNumber.toString(),
          );
        },
      ),
    );
    // this one is for Refrence Images
    addMsAssessmentImages(pdf);

    /// filtered the user sign off list from the listReviewSignOffUsers
    List<ReviewSignOffUserDto> signOffList =
        (msAssessmentDto?.listReviewSignOffUsers ?? [])
            .where(
              (element) => element.userType == ReviewSignOffUserType.signOff,
            )
            .toList();

    if (signOffList.isNotEmpty) {
      showSignOffUser(
        listSignOff: signOffList,
        companyWidget: companyDetailsRow,
        projectDetailsWidget: projectDetailsSection,
        pdf: pdf,
      );
    } else if ((msAssessmentDto?.numberOfSignOffReivew ?? 0) > 0) {
      showSignOffUser(
        pdf: pdf,
        listSignOff: [],
        companyWidget: companyDetailsRow,
        projectDetailsWidget: projectDetailsSection,
      );
    }

    // here we are workign for linked RAMS
    // if risk assessment is avaialbe generate its pdf
    // String msPdfPath = FileManager.msPdfPath(
    //      msAssessmentUniqueKey: msAssessmentDto?.uniqueKey ?? "");

    String aPath = pathToWritePDF;

    print(aPath);

    if (msAssessmentDto?.uniqueKey != null &&
        msAssessmentDto?.uniqueKey != "") {
      if (pdfDocumentFromRa == null) {
        final file = File(aPath);

        var data = await pdf.save();
        file.writeAsBytesSync(data);
        return;

        // await FileManager.saveAssessmentPdfFile(
        //   pdf: pdf,
        //   pdfPath: msPdfPath,
        // );
      }
    }
  }

  /* ************************************** */
  //  UPDATE SELECTED STATEMENT IN TEMPLATE
  /// in this method we applied recursion to update is selected property
  /// of statement And Icon for Given template entity
  /* ************************************** */
  updateSelectedStatementInTemplate({
    required MsTemplateDto? msTemplateDto,
    required List<MsAssessmentStatementDto> listMsAssessmentStatementList,
    required List<MsAssessmentHazardIconDto> listMsAssessmentIconList,
  }) {
    // loop for getting header entity from template
    for (MsHeaderDto headerDto in msTemplateDto?.listHeader ?? []) {
      checkStatementInHeader(
        msHeaderDto: headerDto,
        listSelectedIcons: listMsAssessmentIconList,
        listSelectedStatement: listMsAssessmentStatementList,
      );
    }
  }
  /* ************************************** */
  //  CHECK STATEMENT IN HEADER
  /// this method call itself recursively and set isSelected true
  /// for header, statement and hazard icons
  /* ************************************** */

  void checkStatementInHeader({
    required MsHeaderDto msHeaderDto,
    List<MsAssessmentStatementDto>? listSelectedStatement,
    List<MsAssessmentHazardIconDto>? listSelectedIcons,
  }) {
    if (msHeaderDto.headerCloudId == 1130405) {}
    if ((msHeaderDto.listMsHeaderDto ?? []).isNotEmpty) {
      // loop for iterating header entity from the listMsHeaderDto
      for (MsHeaderDto headerDto in msHeaderDto.listMsHeaderDto ?? []) {
        headerDto.isHeaderLevel = msHeaderDto.isHeaderLevel + 1;
        checkStatementInHeader(
          msHeaderDto: headerDto,
          listSelectedIcons: listSelectedIcons,
          listSelectedStatement: listSelectedStatement,
        );

        if (headerDto.isHeaderSelected == 1) {
          msHeaderDto.isHeaderSelected = headerDto.isHeaderSelected;
        }
      }
    } else if ((msHeaderDto.listMsStatementHazardIcons ?? []).isNotEmpty) {
      // in this we update the property of  isSelected in MsStatementHazardIconDto  by comparing with MsAssessmentHazardIconDto
      for (MsAssessmentHazardIconDto msAssessmentHazardIconDto
          in listSelectedIcons ?? []) {
        // filter the selected icons  from the list Ms statementHazardIcons list
        List<MsStatementHazardIconDto> iconsDtoList =
            (msHeaderDto.listMsStatementHazardIcons ?? [])
                .where(
                  (element) =>
                      element.uniqueKey == msAssessmentHazardIconDto.uniqueKey,
                )
                .toList();

        if (iconsDtoList.isNotEmpty) {
          iconsDtoList.first.isSelected = 1;

          msHeaderDto.isHeaderSelected = 1;
        }
      }
    } else {
      // first of all lets check that there must not be any statement that we have added prevously in the template's header
      msHeaderDto.listMsStatement
          ?.removeWhere((element) => element.addedOnlyForPdf == 1);

      // in this we update the property of isSelected in MsStatementDto by comparing with MsAssessmentStatementDto
      List<MsAssessmentStatementDto> tempList = List.empty(growable: true);

      tempList.addAll(listSelectedStatement ?? []);

      for (MsAssessmentStatementDto msAssessmentStatementDto
          in listSelectedStatement ?? []) {
        List<MsStatementDto> statementList = (msHeaderDto.listMsStatement ?? [])
            .where(
              (element) => (element.uniqueKey ==
                  msAssessmentStatementDto.originalStatementUniqueKey),
            )
            .toList();
        if (statementList.isNotEmpty) {
          //
          tempList.remove(msAssessmentStatementDto);
          if (statementList.first.templateCloudId != null) {
            statementList.first.statementName =
                msAssessmentStatementDto.statementName;
            statementList.first.isSelected = 1;
            if (statementList.first.isSelected == 1) {
              msHeaderDto.isHeaderSelected = 1;
            }
          }
        }
      }

      for (MsAssessmentStatementDto msAssessmentStatementDto in tempList) {
        // adding the selected custom statment into the Ms Statement list of header entity

        var filter = msHeaderDto.listMsStatement?.where((element) =>
                element.uniqueKey == msAssessmentStatementDto.uniqueKey) ??
            [];
        if (filter.isNotEmpty) {
          continue;
        }
        if (msHeaderDto.headerCloudId ==
            msAssessmentStatementDto.headerCloudId) {
          msHeaderDto.isHeaderSelected = 1;

          MsStatementDto msStatementDto = MsStatementDto(
            cloudUserId: msAssessmentStatementDto.cloudUserId,
            cloudCompanyId: msAssessmentStatementDto.cloudCompanyId,
            templateCloudId: msAssessmentStatementDto.templateCloudId,
            headerCloudId: msAssessmentStatementDto.headerCloudId,
            statementName: msAssessmentStatementDto.statementName,
            uniqueKey: msAssessmentStatementDto.originalStatementUniqueKey,
            isSelected: 1,
            colorIdentifier: 0,
            parentHeader: msHeaderDto,
          );

          // getting the  last index of list of list Statement
          int index = (msHeaderDto.listMsStatement ?? []).length;

          // inserting selected custom statement at last into the listStatement
          msHeaderDto.listMsStatement?.insert(index, msStatementDto);
        }
      }
    }
  }

  /* ********************************** */
  // SHOW USER DETAILS AND REVIEW USER ON PDF
  /// in this method passed [msAssessmentDto]and
  /// update the widget of Ms Review Signature Section and
  /// added into the audit pdf item list
  /* ************************************ */

  void showUserDetailsAndReviewUserOnPdf({
    required MsAssessmentDto? msAssessmentDto,
  }) {
    //Check if user signature image is present
    MemoryImage? userSignatureImage;
    if (msAssessmentDto?.userDto?.signature != null) {
      userSignatureImage = msAssessmentDto?.userDto?.signatureMemoryImage;
    }

    // if its manual review we need to show empty strings
    if (msAssessmentDto?.approvalMode == ReviewSignOffMode.manual) {
      Widget widget = MsReviewSignatureSection(
          localeName: platFormLocaleName,
          reviewDate: "",
          reviewUserName: "",
          userName: msAssessmentDto?.user ?? "",
          userAssessmentDate: msAssessmentDto?.date ?? "",
          userSignature: userSignatureImage,
          userPosition: msAssessmentDto?.userDto?.position ?? "",
          msAssessmentDto: msAssessmentDto!);
      msPdfItems.add(widget);
    } else {
      List<ReviewSignOffUserDto> reviewUserDtoList = (msAssessmentDto
                  ?.listReviewSignOffUsers ??
              [])
          .where((element) => element.userType == ReviewSignOffUserType.review)
          .toList();
      String? reviewUserName = null;
      String createdOn = "";
      MemoryImage? reviewSignatureImage;
      if (reviewUserDtoList.isNotEmpty) {
        reviewUserName = [
          "${reviewUserDtoList.first.firstName}",
          " ",
          "${reviewUserDtoList.first.lastName}"
        ].join();
        createdOn = reviewUserDtoList.first.createdOn ?? "";
        // reviewSignatureImage =  generateReviewSignOffSignatureImage(
        //     user: reviewUserDtoList.first);
        reviewSignatureImage = reviewUserDtoList.first.memoryImage;
      }
      Widget widget = MsReviewSignatureSection(
        localeName: platFormLocaleName,
        msAssessmentDto: msAssessmentDto!,
        reviewUserName: reviewUserName ?? "",
        reviewSignatureImage: reviewSignatureImage,
        reviewDate: createdOn,
        userName: msAssessmentDto.user ?? "",
        userAssessmentDate: msAssessmentDto.date,
        userSignature: userSignatureImage,
        userPosition: msAssessmentDto.userDto?.position ?? "",
      );
      msPdfItems.add(widget);
    }
  }

  /* *************** */
  // CREATE HEADER ROW
  /// responsible to iterate all the headers of a templates
  /// and create widgets for header, subHeaders and statements/ hazard icons

  /* ***************** */

  void iterateHeadersForPdfWidets({
    required Context context,
  }) {
    MsTemplateDto? msTemplateDto = msAssessmentDto?.templateDto;

    List<MsHeaderDto> listHeaderDto = msTemplateDto?.listHeader ?? [];

    // loop for getting header entity from list of listHeaderDto
    // Future.forEach(listHeaderDto, (MsHeaderDto headerDto) {

    for (MsHeaderDto headerDto in listHeaderDto) {
      createHeaderWidgets(
        msHeaderDto: headerDto,
        context: context,
      );

      // filter the list of images related to header entity
      var listFilteredImages = (msAssessmentDto?.listMsAssessmentImageDto ?? [])
          .where((element) => element.headerCloudId == headerDto.headerCloudId)
          .toList();

      // when user does not selected the any statement but select the image
      if (headerDto.isHeaderSelected == 0 && listFilteredImages.isNotEmpty) {
        Widget widget = MsPdfCustomText(
          text: "${headerDto.name}",
          padding: TbMsPdfPaddings.paddingForTbMsheaderEntity,
          // textStyle: msPdfTextStyle.msMainHeaderTextStyle(),
          textStyle: TbPdfHelper().textStyleGenerator(
            font: Theme.of(context).header0.fontBold,
            color: TbMsPdfColors.msBlueThemeColor,
            fontSize: 12,
          ),
        );
        headerWidget.add(widget);
      }

      // loop for iterating the image from the listFilterImage
      for (var element in listFilteredImages) {
        listImage.add(element);

        Widget widget = MsStatementRow(
            statementName:
                "See Image Reference ${listImage.length} in Appendix",
            // statmentTextStyle: msPdfTextStyle.msStatementTextStyle(),
            statmentTextStyle: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              fontSize: 11,
              color: TbMsPdfColors.companyDetailsTextColor,
            ));
        headerWidget.add(widget);
      }
    }
  }

  /* ************************************** */
  //  CREATE HEADER WIDGET
  /// responsible to iterate headers /statements and create widgets
  /* ************************************** */

  void createHeaderWidgets({
    required MsHeaderDto msHeaderDto,
    required Context context,
  }) {
    if (msHeaderDto.isHeaderSelected == 1) {
      Widget widget = MsPdfCustomText(
        text: "${msHeaderDto.name}",
        padding: msHeaderDto.isHeaderLevel == 0
            ?
            // const EdgeInsets.only(
            //     left: 20,
            //     // top: 18,
            //     top: 15,
            //     right: 20,
            //   )
            TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelZero
            :
            // const EdgeInsets.only(
            //     left: 20,
            //     top: 5,
            //     right: 20,
            //   ),
            TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelNotZero,
        textStyle: msHeaderDto.isHeaderLevel == 0
            // ? msPdfTextStyle.msMainHeaderTextStyle()
            ? TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbMsPdfColors.msBlueThemeColor,
                fontSize: 12,
              )
            : TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbMsPdfColors.companyDetailsTextColor,
                fontSize: 11,
              ),
      );

      headerWidget.add(widget);
    }

    if ((msHeaderDto.listMsHeaderDto ?? []).isNotEmpty) {
      for (MsHeaderDto msHeaderDto in msHeaderDto.listMsHeaderDto ?? []) {
        createHeaderWidgets(
          msHeaderDto: msHeaderDto,
          context: context,
        );
      }
    } else if ((msHeaderDto.listMsStatement ?? []).isNotEmpty) {
      // loop for iterating the statement from the listStatement
      for (MsStatementDto statementDto in msHeaderDto.listMsStatement ?? []) {
        if (statementDto.isSelected == 1) {
          Widget w = MsStatementRow(
            statementName: statementDto.statementName,
            // statmentTextStyle: msPdfTextStyle.msStatementTextStyle(),
            statmentTextStyle: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbMsPdfColors.companyDetailsTextColor,
              fontSize: 11,
            ),
          );
          headerWidget.add(w);
        }
      }
    } else if ((msHeaderDto.listMsStatementHazardIcons ?? []).isNotEmpty) {
      // filtered the selected Ms StatementHazardIcon from the listMsStatementHazardIcons
      List<MsStatementHazardIconDto> listStatementIconDtoList =
          (msHeaderDto.listMsStatementHazardIcons ?? [])
              .where((element) => element.isSelected == 1)
              .toList();
      if (listStatementIconDtoList.isNotEmpty) {
        showMsStatementIconsOnPdf(
            msStatementHazadIconDtoList: listStatementIconDtoList);
      }
    }
  }

  /* ****************************/
  //  SHOW MS STATEMENT ICON ON PDF
  /// in this method we passed the [msStatementIconDtoList] to get the selected icons image and
  /// implement the logic of show only 6 icons image in a single row and
  /// image which came after the 6th one is show on next row
  /*  ************************* */

  void showMsStatementIconsOnPdf({
    required List<MsStatementHazardIconDto> msStatementHazadIconDtoList,
  }) {
    /// this list holds the memory image widget of ms Statement Icons
    List<Widget> listIconImageItems = [];
    // this holds the row widget which contain children widget as listIconImageItems
    List<Widget> listIconRow = [];
    // this loop for iterating the element of list of StatementIcon
    // in this loop we have implement the logic to show only 6 image in a single row and image which came after the 6th one
    // is show on next row
    // Future.forEach(msStatementHazadIconDtoList, (iconDto) {
    for (MsStatementHazardIconDto iconDto in msStatementHazadIconDtoList) {
      int index = (msStatementHazadIconDtoList).indexOf(iconDto);

      MemoryImage? iconImage = iconDto.memoryImage;

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

  /* ****************************/
  //  ADD MS ASSESSMENT IMAGES
  /// in this method we render Ms Assessment Image
  /// into the new page of pdf
  /* ************************* */

  void addMsAssessmentImages(
    Document pdf,
  ) {
    List<Widget> list = List.empty(growable: true);

    if (listImage.isNotEmpty) {
      // loop for iterating MsAssessment Image Dto from listImage
      // Future.forEach(listImage, (MsAssessmentImageDto imageDto) async {
      for (MsAssessmentImageDto imageDto in listImage) {
        int index = listImage.indexOf(imageDto) + 1;

        /// get the memory image of  Ms Assessment Image
        MemoryImage? image = imageDto.memoryImage;
        if (image != null) {
          // update the Ms Assessment Image Column Widget and add into the list
          list.add(
            MsAssessmentImageColumn(
              msAssessmentImage: image,
              msAssessmentImageIndex: index.toString(),
            ),
          );
        }
      }
    }

    pdf.addPage(
      MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          isSubcribed: msAssessmentDto?.isSubscribed ?? 0,
          waterMarkImage: pdfHelper.msWaterMarkImage,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
          themeData: pdfHelper.msTheme,
        ),
        build: (context) {
          return list;
        },
        header: (context) {
          return MsHeaderRow(
            localeName: platFormLocaleName,
            msAssessmentDto: msAssessmentDto,
            pagesNo: context.pageNumber,
            companyLogo: companyLogo,
          );
        },
        footer: (context) {
          return MsFooterSection(
            msAssessmentDto: msAssessmentDto,
            pageNumber: context.pageNumber.toString(),
          );
        },
      ),
    );
  }

  /* ****************************/
  // REVIEW SIGN OFF SIGNATURE IMAGE
  ///in this method we render the review Sign Off User
  ///into new page of pdf
  ///
  /* ************************* */

  void showSignOffUser({
    required Document pdf,
    required Widget companyWidget,
    required Widget projectDetailsWidget,
    required List<ReviewSignOffUserDto> listSignOff,

    // required Context context,
  }) {
    // this list holds Widget of MsSignOffSignatureSection
    List<Widget> listSignOffUserItem = [];

    // this list holds ms review sign off user row widget
    List<Widget> listSignOffUserRow = [];

    // this condition is applied for showing manual sign off in ms pdf
    if (msAssessmentDto?.numberOfSignOffReivew != null &&
        msAssessmentDto?.numberOfSignOffReivew != 0) {
      int numberOfSignOff = msAssessmentDto?.numberOfSignOffReivew ?? 1;

      // we add a new sign for every iteration and when
      // even number of sign are added we add them in the row and finally
      // rows are added to the pdf
      for (int i = 1; i <= numberOfSignOff; i++) {
        Widget reviewSignWidget = MsSignOffSection(
          localeName: platFormLocaleName,
        );
        listSignOffUserItem.add(reviewSignWidget);

        int result = i % 2;
        if (result == 0) {
          var row = MsReviewSignOffUserRow(listOfSignOff: listSignOffUserItem);
          listSignOffUserRow.add(row);
          listSignOffUserItem = [];
        }
      }
    } else {
      // Future.forEach(listSignOff, (reviewSignOffUser) {
      for (ReviewSignOffUserDto reviewSignOffUser in listSignOff) {
        int index = listSignOff.indexOf(reviewSignOffUser);

        MemoryImage? signatureImage = reviewSignOffUser.memoryImage;

        Widget reviewSignWidget = MsSignOffSection(
            localeName: platFormLocaleName,
            user: reviewSignOffUser,
            signatureImage: signatureImage,
            signOffDate: msAssessmentDto?.date);
        listSignOffUserItem.add(reviewSignWidget);

        int result = (index + 1) % 2;
        if (result == 0) {
          var row = MsReviewSignOffUserRow(listOfSignOff: listSignOffUserItem);

          listSignOffUserRow.add(row);
          listSignOffUserRow.add(Container(
            height: 10,
            // color: PdfColors.purple,
          ));
          listSignOffUserItem = [];
        }
      }
    }

    var row = MsReviewSignOffUserRow(listOfSignOff: listSignOffUserItem);

    listSignOffUserRow.add(row);
    listSignOffUserRow.add(Container(
      height: 10,
      // color: PdfColors.purple,
    ));

    List<Widget> listShowUserSignOff = [];
    listShowUserSignOff.addAll(listSignOffUserRow);

    listSignOffUserItem = [];

    pdf.addPage(
      MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          isSubcribed: msAssessmentDto?.isSubscribed ?? 0,
          waterMarkImage: pdfHelper.msWaterMarkImage,
          themeData: pdfHelper.msTheme,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
        ),
        header: (context) {
          return Column(
            // children: listOfWidget,
            children: returnPdfHeaderList(
                companyWidget: companyWidget,
                projectDetailsWidget: projectDetailsWidget,
                context: context),
          );
        },
        build: (context) {
          return listShowUserSignOff;
        },
        footer: (context) {
          return MsFooterSection(
            msAssessmentDto: msAssessmentDto,
            pageNumber: context.pageNumber.toString(),
          );
        },
      ),
    );
  }

  List<Widget> returnPdfHeaderList({
    required Widget companyWidget,
    required Widget projectDetailsWidget,
    required Context context,
  }) {
    //This list holds the header items.
    List<Widget> listOfWidget = List.empty(growable: true);

    Widget headerWidget = MsHeaderRow(
      localeName: platFormLocaleName,
      msAssessmentDto: msAssessmentDto,
      pagesNo: 0,
      companyLogo: companyLogo,
    );
    Widget borderWidth =
        Container(height: 2, color: TbMsPdfColors.projectDetailsBorderColor);
    listOfWidget.add(headerWidget);
    listOfWidget.add(companyWidget);

    listOfWidget.add(borderWidth);
    listOfWidget.add(projectDetailsWidget);
    listOfWidget.add(
      borderWidth,
    );

    Widget text = MsPdfCustomText(
        text: msAssessmentDto?.companyDto?.signOffStatementReport ??
            "sign_off_statement_report}",
        padding: const EdgeInsets.only(
          top: 25,
          left: 20,
        ),
        textAlign: TextAlign.left,
        // textStyle: msPdfTextStyle.boldBlack9(),\
        textStyle: TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.fontBold,
          color: TbMsPdfColors.black,
          fontSize: 9,
        ));
    listOfWidget.add(text);
    return listOfWidget;
  }
  /* ****************************/
  //  UPDATE TEMPLATE FIELDS
  /// responsible for updating the list of fields, we want to show created on the
  /// first position in the second column.
  ///
  /*  ************************* */

  void updateTemplateFields({
    required MsAssessmentDto? msAssessmentDto,
  }) {
    // in this we get the first entity from list of listMsTemplateValues

    if ((msAssessmentDto?.listMsTemplateValues ?? []).isNotEmpty) {
      MsTemplateValueDto? valueDto =
          (msAssessmentDto?.listMsTemplateValues ?? [])[0] ??
              MsTemplateValueDto();
      valueDto.keyName = "Created On";
      //remove the project date from the list of listMsTemplateValues
      (msAssessmentDto?.listMsTemplateValues ?? [])
          .removeWhere((element) => element.dbKeyName == "date");

      // get the index of mid element from the list of listMsTemplateValues
      int index =
          (((msAssessmentDto?.listMsTemplateValues ?? []).length) / 2).floor();

      //now insert the value entity into the list of listTemplateValues at mid
      (msAssessmentDto?.listMsTemplateValues ?? []).insert(++index, valueDto);

      // loop for iterating the values entity from listTemplateValues
      for (MsTemplateValueDto valueDto
          in msAssessmentDto?.listMsTemplateValues ?? []) {
        if (valueDto.type == "radio") {
          if (valueDto.values == "1") {
            valueDto.values = "Yes";
          } else {
            valueDto.values = "No";
          }
        }

        // // update the "NA" in values if values is equal to null or empty string
        // if (valueDto.values == "" || valueDto.values == null) {
        //   valueDto.values = "NA";
        // }
        valueDto.values ??= "";
      }
    }
  }

  Future<void> preparePDFImages(MsAssessmentDto msAssessmentDto) async {
    msAssessmentDto.userDto?.signatureMemoryImage =
        await TbPdfHelper().generateMemoryImageForPath(
      msAssessmentDto.userDto?.imagePath ?? "",
    );
    msAssessmentDto.companyDto?.companyLogoMemoryImage = await TbPdfHelper()
        .generateMemoryImageForPath(
            msAssessmentDto.companyDto?.imagePath ?? "");

    await Future.forEach(msAssessmentDto.listMsAssessmentImageDto ?? [],
        (msImageEntity) async {
      MsAssessmentImageDto msAssessmentImageDto =
          msImageEntity as MsAssessmentImageDto;

      msAssessmentImageDto.memoryImage = await TbPdfHelper()
          .generateMemoryImageForPath(msAssessmentImageDto.imagePath ?? "");
    });
    // update the memory image msStatementIcons
    await Future.forEach(msAssessmentDto.templateDto?.listHeader ?? [],
        (element) async {
      await updateMemoryImageInMsStatementIcons(
        msHeaderEntity: element,
        listAssessementStatement: msAssessmentDto.listMsAssessmentStatement,
        listAssessmentIconsList: msAssessmentDto.msAssessmentIconList,
      );
    });

    // // update the memory image in review sign off users
    await Future.forEach(
      msAssessmentDto.listReviewSignOffUsers ?? [],
      (element) async {
        ReviewSignOffUserDto reviewUserDto = element;

        reviewUserDto.memoryImage = await TbPdfHelper()
            .generateMemoryImageForPath(reviewUserDto.imagePath ?? "");
      },
    );
  }

  Future<void> updateMemoryImageInMsStatementIcons({
    required MsHeaderDto msHeaderEntity,
    List<MsAssessmentStatementDto>? listAssessementStatement,
    List<MsAssessmentHazardIconDto>? listAssessmentIconsList,
  }) async {
    if ((msHeaderEntity.listMsHeaderDto ?? []).isNotEmpty) {
      // loop for iterating the header entity from listHeaderEntity
      await Future.forEach(
        msHeaderEntity.listMsHeaderDto ?? [],
        (msHeaderEntity) async {
          await updateMemoryImageInMsStatementIcons(
              msHeaderEntity: msHeaderEntity);
        },
      );
    } else if ((msHeaderEntity.listMsStatementHazardIcons ?? []).isNotEmpty) {
      await Future.forEach(listAssessmentIconsList ?? [],
          (msAssessmentIconEntity) async {
        MsAssessmentHazardIconDto iconEntity =
            msAssessmentIconEntity as MsAssessmentHazardIconDto;

        List<MsStatementHazardIconDto> iconEntityList =
            (msHeaderEntity.listMsStatementHazardIcons ?? [])
                .where((element) => element.uniqueKey == iconEntity.uniqueKey)
                .toList();

        if (iconEntityList.isNotEmpty) {
          MsStatementHazardIconDto msStatementHazardIconEntity =
              iconEntityList.first;

          if (msStatementHazardIconEntity.templateCloudId != null) {
            msStatementHazardIconEntity.isSelected = 1;

            msStatementHazardIconEntity.memoryImage = await TbPdfHelper()
                .generateMemoryImageForPath(
                    msStatementHazardIconEntity.iconPath ?? "");
          }
        }
      });

      // await Future.forEach(msHeaderEntity.listMsStatementHazardIcons ?? [],
      //     (msIconEntity) async {
      //   msIconEntity as MsStatementHazardIconDto;
      //   if (msIconEntity.isSelected == 1) {
      //     msIconEntity.memoryImage = await TbPdfHelper()
      //         .generateMemoryImageForPath(msIconEntity.iconPath ?? "");
      //   }
      // });
    }
  }
}
