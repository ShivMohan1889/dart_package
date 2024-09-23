import 'dart:ffi';
import 'dart:typed_data';

import 'package:dart_pdf_package/src/ra/dto/assessment_image_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/harm_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/hazard_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/reference_image_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/review_sign_off_user_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/risk_assessment_dto.dart';
import 'package:dart_pdf_package/src/ra/dto/weather/weather_dto.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/models/tb_hazard_row_model.dart';
import 'package:dart_pdf_package/src/ra/pdf_generator/widgets/ra_header_row.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../dart_pdf_package.dart';
import '../../utils/enums/enum/ra_pdf_title_type.dart';
import '../../utils/enums/enum/review_sign_off_mode.dart';
import '../../utils/enums/enum/review_sign_off_user_type.dart';
import '../dto/hazard_control_dto.dart';
import 'tb_ra_pdf_constants.dart';
import 'widgets/assessment_image_section.dart';
import 'widgets/hazard_table_row.dart';
import 'widgets/map_image_row.dart';
import 'widgets/ra_footer_row.dart';
import 'widgets/ra_map_header_row.dart';
import 'widgets/sign_off_signature.dart';

/// Class that will create pdf for Risk assessment
class TbRaPdfGenerator {
  TbRaPdfGenerator({
    required this.theRiskAssessmentDto,
    required this.pdfHelper,
    this.pdfDocumentFromMs,
    required this.platFormLocaleName,
  });

  Document? pdfDocumentFromMs;
  TbPdfHelper pdfHelper;
  String platFormLocaleName;

  /// risk assessment for which we need to create pdf
  final RiskAssessmentDto theRiskAssessmentDto;

  /// pdf page number to determine page height
  var globalPageNumber = 1;

  /// styles that will be used to style our pdf
  final raPdfTextStyles = TbRaPdfTextStyles();

  ///
  MemoryImage? companyLogo;

  /// lastAssessment - this will be used to determine if entity has been changed
  /// because whenever entity will change we need to show first page header
  /// we update this at two places
  /// 1. after generating pdf
  /// 2. in the header, for some reason after generating was not working so we
  /// needed to do this in header callback as well. As it is called two times
  RiskAssessmentDto? lastAssessmentForHeader;
  RiskAssessmentDto? lastAssessmentForFooter;

  int pageNo = 1;
  double remainingHeight = TbRaPdfSectionHeights.FIRST_PAGE_HEADER_HEIGHT;
  List<TbHazardRowModel> listHazardModels = List.empty(growable: true);

  /* ************************************** */
  // GENERATE PDF
  /* ************************************** */
  Future<Uint8List?> generatePDF() async {
    Document pdf = Document();
    if (pdfDocumentFromMs != null) {
      pdf = pdfDocumentFromMs!;
    }

    await theRiskAssessmentDto.prepareEntityForPDF();

    // here we are adding all the assessments in the list
    // first add the main one and then all of the children
    List<RiskAssessmentDto> l = [];
    l.add(theRiskAssessmentDto);
    l.addAll(theRiskAssessmentDto.listChildren ?? []);

    // here we are calling generatePDf method for each entity

    for (RiskAssessmentDto raEntity in l) {
      generatePdfFor(pdf, raEntity);
    }

    // String raPdfPath = TbFileManager.raPdfPath(
    //     raAssessmentUniqueKey: theRiskAssessmentDto.uniqueKey ?? "");

    // here we are workign for linked RAMS
    // if risk assessment is avaialbe generate its pdf

    if (theRiskAssessmentDto.msAssessmentDto != null) {
      MsAssessmentDto msAssessmentEntity =
          theRiskAssessmentDto.msAssessmentDto!;

      // String msPdfPath = FileManager.msPdfPath(
      //     msAssessmentUniqueKey: msAssessmentEntity.uniqueKey ?? "");

      TbMsPdfGenerator msPdfGenerator = TbMsPdfGenerator(
        msAssessmentDto: msAssessmentEntity,
        // documentsDirPath: documentsDirPath,
        pdfDocumentFromRa: pdf,
        pdfHelper: pdfHelper,
        // localeName: platFormLocaleName,
        platFormLocaleName: platFormLocaleName,
      );
      await msPdfGenerator.generatePDF();
      //  await FileManager.mergePDf(
      //    msPath: msPdfPath,
      //   raPath: raPdfPath,
      //   documentsDirectoryPath: documentsDirPath,
      //  );
    }
    // if (pdfDocumentFromMs == null) {
    //   await FileManager.saveAssessmentPdfFile(pdf: pdf, pdfPath: raPdfPath);
    // }

    if (pdfDocumentFromMs == null) {
      var data = await pdf.save();
      return data;
    } else {
      return null;
    }
  }

/* ************************************** */
  // Generate pdf
/* ************************************** */
  void generatePdfFor(
    pw.Document pdf,
    RiskAssessmentDto riskAssessmentEntity,
  ) {
    listHazardModels.clear();

    remainingHeight = TbRaPdfSectionHeights.FIRST_PAGE_HEIGHT;

    MemoryImage? userSignImage =
        riskAssessmentEntity.userDto?.signatureMemoryImage;

    // review user image
    var reviewUser = (riskAssessmentEntity.listReviewSignOffUsers ?? [])
        .where((element) => element.userType == ReviewSignOffUserType.review);
    MemoryImage? reviewSignImage;
    if (reviewUser.isNotEmpty) {
      reviewSignImage = reviewUser.first.memoryImage;
    }

    //company logo
    if (riskAssessmentEntity.companyDto != null) {
      companyLogo = riskAssessmentEntity.companyDto?.companyLogoMemoryImage;
    }

    // create hazard models that will be used to generate pdf
    createHazardModels(
      riskAssessmentEntity,
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          pageFormat: const PdfPageFormat(
            29.7 * PdfPageFormat.cm,
            21.0 * PdfPageFormat.cm,
            marginAll: 0,
          ),
          themeData: pdfHelper.raTheme,
          isSubcribed: riskAssessmentEntity.isSubscribed ?? 0,
          pageOrientation: PageOrientation.landscape,
          waterMarkImage: pdfHelper.raWaterMarkImage,
        ),
        build: (Context context) {
          return createHazardTableRows(
            list: listHazardModels,
            riskAssessmentEntity: riskAssessmentEntity,
          );
        },
        header: (context) {
          int pageNo = 1;
          if (lastAssessmentForHeader?.uniqueKey !=
              riskAssessmentEntity.uniqueKey) {
            pageNo = 1;
            lastAssessmentForHeader = riskAssessmentEntity;
          } else {
            pageNo = context.pageNumber;
          }
          return RaHeaderRow(
            localeName: platFormLocaleName,
            riskAssessmentEntity: riskAssessmentEntity,
            pageNo: pageNo,
            logoImage: companyLogo,
            pdfHelper: pdfHelper,
          );
        },
        footer: (context) {
          int pageNo = 1;
          if (lastAssessmentForFooter?.uniqueKey !=
              riskAssessmentEntity.uniqueKey) {
            pageNo = 1;
            lastAssessmentForFooter = riskAssessmentEntity;
          } else {
            pageNo = context.pageNumber;
          }
          return RaFooterRow(
            pageNo: pageNo,
            riskAssessmentEntity: riskAssessmentEntity,
            signatureImage: userSignImage,
            reviewImage: reviewSignImage,
            isSignOffFooter: false,
            localeName: platFormLocaleName,
          );
        },
      ),
    );

    showAssessmentImageOnPdf(
      pdf: pdf,
      riskAssessmentEntity: riskAssessmentEntity,
    );
    showReferenceImageOnPdf(
      pdf: pdf,
      riskAssessmentEntity: riskAssessmentEntity,
    );
    showMapInfoOnPdf(
      // context: context,
      riskAssessmentEntity: riskAssessmentEntity,
      pdf: pdf,

      // context:  context
    );
    addSignOffPages(
      pdf: pdf,
      riskAssessmentEntity: riskAssessmentEntity,

      // context: context,
    );
  }

  /* ************************************** */
  // CREATE HAZARD TABLE ROWS
  /// loops all the hazards into an assessment
  /// and create table rows
  /* ************************************** */
  List<pw.Widget> createHazardTableRows({
    required RiskAssessmentDto riskAssessmentEntity,
    required List<TbHazardRowModel> list,
  }) {
    // contains the widget list that will actually draw on the pdf page
    List<pw.Widget> listForTableRows = [];
    for (var item in list) {
      var tableRow2 = HazardTableRow(
        row: item,
        isStandard: riskAssessmentEntity.assessmentType ?? 0,
      );
      listForTableRows.add(tableRow2);
    }
    return listForTableRows;
  }

/* ************************************** */
  // SPLIT HAZARD MODEL
  /// responsible to split given [item] HazardRowModel so it fits into given [maxHeight]
/* ************************************** */
  List<TbHazardRowModel> splitHazardModel({
    required RiskAssessmentDto riskAssessmentEntity,
    required TbHazardRowModel item,
    required double maxHeight,
  }) {
    // first lets split hazard name for given height
    int index1 = splitText(
        text: item.name ?? "",
        maxHeight: maxHeight,
        height: item.height,
        riskAssessmentEntity: riskAssessmentEntity);
    // then split cotrol in place
    int index2 = splitText(
        text: item.controlInPlace ?? "",
        maxHeight: maxHeight,
        height: item.height,
        riskAssessmentEntity: riskAssessmentEntity);
    // then split additioal control
    int index3 = splitText(
        text: item.additionalControl ?? "",
        maxHeight: maxHeight,
        height: item.height,
        riskAssessmentEntity: riskAssessmentEntity);
    TbHazardRowModel second = TbHazardRowModel();
    if (index1 > 0) {
      var part1 = item.name?.substring(0, index1);
      var part2 = item.name?.substring(index1);
      item.name = part1;
      second.name = part2;
      // second.score  = item.score;
      /// update the split item score for showing the color on the score section of hazard table after the pdf get split
      second.splitItemScore = item.score;
    }
    if (index2 > 0) {
      var part1 = item.controlInPlace?.substring(0, index2).trim();
      var part2 = item.controlInPlace?.substring(index2).trim();
      item.controlInPlace = part1;
      second.controlInPlace = part2;

      /// update the split item score for showing the color on the score section of hazard table after the pdf get split

      second.splitItemScore = item.score;
    }
    if (index3 > 0) {
      var part1 = item.additionalControl?.substring(0, index3).trim();
      var part2 = item.additionalControl?.substring(index3).trim();
      item.additionalControl = part1;
      second.additionalControl = part2;

      /// update the split item additional score for showing the color on the score section of hazard table after the pdf get split

      second.splitItemAdditionalScore = item.additionalScore;

      // second.secondScore = item.score;
    }
    if (index1 > 0 || index2 > 0 || index3 > 0) {
      item.isSplitHazard = 1;
      second.isSplitHazard = 1;
      // second.secondScore = item.score;
      var itemHeight = TbPdfHelper().calculateHeightOfWidget(
          widget: HazardTableRow(
            row: item,
            // hazardScore:  item.score,

            isStandard: riskAssessmentEntity.assessmentType ?? 0,
          ),
          width: TbRaPdfWidth.pageWidth);
      item.height = itemHeight;
      var secondHeight = TbPdfHelper().calculateHeightOfWidget(
          widget: HazardTableRow(
            row: second,

            // hazardScore:   item.score,

            isStandard: riskAssessmentEntity.assessmentType ?? 0,
          ),
          width: TbRaPdfWidth.pageWidth);
      second.height = secondHeight;
      return [item, second];
    } else {
      return [item];
    }
  }

/* ************************************** */
  // SPLIT TEXT
  /// splits text for the given [maxHeight] and provides the [index]
/* ************************************** */
  int splitText({
    required RiskAssessmentDto riskAssessmentEntity,
    required String text,
    required double maxHeight,
    required double height,
  }) {
    var index = 0;

    // create a row and find height
    var rowModel = TbHazardRowModel(controlInPlace: text);
    var textHeight = TbPdfHelper().calculateHeightOfWidget(
        widget: HazardTableRow(
          row: rowModel,
          isStandard: riskAssessmentEntity.assessmentType ?? 0,
        ),
        width: TbRaPdfWidth.pageWidth);
    // if text height is greater then the max height,
    // we will find the index to split
    if (textHeight > maxHeight) {
      // find approx index so we need to do less calculation
      // instead of doing calculation word by word from starting
      // we are doing that from the approx index so it reduces calculations
      int approxIndex = ((maxHeight / height) * text.length).toInt();
      int newindex = TbPdfHelper().findPreviousSpace(text, approxIndex);
      var subString = text.substring(0, newindex);
      var newModel = TbHazardRowModel(controlInPlace: subString);
      // find height of the substring
      var newHeight = TbPdfHelper().calculateHeightOfWidget(
          widget: HazardTableRow(
            row: newModel,
            isStandard: riskAssessmentEntity.assessmentType ?? 0,
          ),
          width: TbRaPdfWidth.pageWidth);
      index = newindex;
      // check if height is greate then the max
      // if yes reduce string till its height is not less then maxHeight
      if (newHeight > maxHeight) {
        while (newHeight > maxHeight) {
          int newindex1 = TbPdfHelper().findPreviousSpace(text, newindex);
          index = newindex;
          var subString = text.substring(0, newindex);
          newModel = TbHazardRowModel(controlInPlace: subString);
          newHeight = TbPdfHelper().calculateHeightOfWidget(
              widget: HazardTableRow(
                row: newModel,
                isStandard: riskAssessmentEntity.assessmentType ?? 0,
              ),
              width: TbRaPdfWidth.pageWidth);
          newindex = newindex1;
          if (newHeight < maxHeight) {
            index = newindex;
            break;
          }
        }
      } else {
        while (newHeight < maxHeight) {
          int newindex1 = TbPdfHelper().findNextSpace(text, newindex);
          var subString = text.substring(0, newindex1);
          newModel = TbHazardRowModel(controlInPlace: subString);
          newHeight = TbPdfHelper().calculateHeightOfWidget(
              widget: HazardTableRow(
                row: newModel,
                isStandard: riskAssessmentEntity.assessmentType ?? 0,
              ),
              width: TbRaPdfWidth.pageWidth);
          if (newHeight > maxHeight) {
            index = newindex;
            break;
          } else {
            newindex = newindex1;
          }
        }
        // return index;
      }
    }
    // else {
    // no need to trim
    // }
    return index;
  }

  /* ************************************** */
  // CREATE HAZARD MODELS
  /// create a list of hazard row, so it can be rendered
  /* ************************************** */
  void createHazardModels(
    RiskAssessmentDto riskAssessmentEntity,
  ) {
    for (HazardDto hazard in riskAssessmentEntity.listHazards ?? []) {
      // selected controls:
      // first we will concat the selected controls with the new line character with three dots
      // we are appending three dots becuase without these three dots it was not respecting
      // new line character
      String selectedControlString = "";
      for (HazardControlDto control in hazard.listHazardControlDto ?? []) {
        if (control.isSelected == 1 && control.isRequired == 0) {
          selectedControlString += control.name ?? "";
          selectedControlString += "\n...\n...";
        }
      }
      // remove "\n...\n..." appended at the end of string
      if (selectedControlString.length > 4) {
        var lastCharacters =
            selectedControlString.substring(selectedControlString.length - 8);
        if (lastCharacters == "\n...\n...") {
          selectedControlString = selectedControlString.substring(
              0, selectedControlString.length - 8);
        }
      }
      // required controls:
      // same as above we are appending required controls in a string varaible
      String requiredControlString = "";
      for (HazardControlDto control in hazard.listHazardControlDto ?? []) {
        if (control.isSelected == 1 && control.isRequired == 1) {
          requiredControlString += control.name ?? "";
          requiredControlString += "\n...\n...";
        }
      }
      // remove "\n...\n..." appended at the end of string
      if (requiredControlString.length > 4) {
        var lastCharacters =
            requiredControlString.substring(requiredControlString.length - 8);
        if (lastCharacters == "\n...\n...") {
          requiredControlString = requiredControlString.substring(
              0, requiredControlString.length - 8);
        }
      }

      // String dash = "-";
      String? harm = setRiskOfHarmOnUploading(personAtRisk: hazard.harm ?? "");

      String harmName = harm != null ? "($harm)" : "";

      var row = TbHazardRowModel(
        name: '${hazard.name} $harmName',
        gridRef: hazard.cellPosition,
        worstCase: hazard.worstcase,
        likelihood: hazard.liklihood,
        additionalLikelihood: hazard.additionalLiklihood,
        score: hazard.score.toString(),
        rating: hazard.rating,
        additionalRating: hazard.additionalRating,
        additionalScore: hazard.additionalScore.toString(),
        additionalControl: requiredControlString,
        controlInPlace: selectedControlString,
      );

      var tableRow = HazardTableRow(
        row: row,
        isStandard: riskAssessmentEntity.assessmentType ?? 0,
      );
      var h = TbPdfHelper().calculateHeightOfWidget(
          widget: tableRow, width: TbRaPdfWidth.pageWidth);
      row.height = h;
      // here we check if global page is not equal to pageNo
      // if not then assign new height as if page no is changed
      // height should also refreshed
      // here we have added an additional condition remainingHeight < 20
      // this helps to manage liklihood/worstcase those goes in two lines
      // and has height 19.64 and we don't want them to split into two parts
      // so if there is space less then 20 we insert new page

      newMethod(row, riskAssessmentEntity);

      // if (pageNo != globalPageNumber || remainingHeight < 20) {
      //   remainingHeight = RaPdfSectionHeights.SECOND_PAGE_HEIGHT;
      //   globalPageNumber = pageNo;
      // }
      // // here we are checking if the table row can be shown in the remaining height
      // if (h > remainingHeight) {
      //   // if not we have to split our model into two parts
      //   var arr = splitHazardModel(
      //       item: row,
      //       maxHeight: remainingHeight,
      //       riskAssessmentEntity: riskAssessmentEntity);
      //   listHazardModels.add(arr.first);
      //   // if (listHazardModels.length == 2) {
      //   //   tempModels.add(arr.last);
      //   // }
      //   pageNo++;
      // } else {
      //   // if it can be shown in the remaining height we - row height from the
      //   // remaining height so we have updated remining height for next hazards
      //   listHazardModels.add(row);
      //   remainingHeight = remainingHeight - row.height;
      // }
    }
    // return listHazardModels;
  }

  void newMethod(TbHazardRowModel row, RiskAssessmentDto riskAssessmentEntity) {
    var h = row.height;
    // if (pageNo != globalPageNumber || remainingHeight < 20) {

    //   globalPageNumber = pageNo;
    // }
    // here we are checking if the table row can be shown in the remaining height

    if (remainingHeight < 19) {
      remainingHeight = TbRaPdfSectionHeights.SECOND_PAGE_HEIGHT;
    }
    if (h > remainingHeight) {
      // if not we have to split our model into two parts
      var arr = splitHazardModel(
          item: row,
          maxHeight: remainingHeight,
          riskAssessmentEntity: riskAssessmentEntity);
      listHazardModels.add(arr.first);
      if (arr.length == 2) {
        // pageNo++;
        remainingHeight = TbRaPdfSectionHeights.SECOND_PAGE_HEIGHT;
        newMethod(arr.last, riskAssessmentEntity);
      }
    } else {
      // if it can be shown in the remaining height we - row height from the
      // remaining height so we have updated remining height for next hazards
      listHazardModels.add(row);
      remainingHeight = remainingHeight - row.height;
    }
  }

  /* ************************************** */
  // SIGN OFF PAGE HEADEING
  /* ************************************** */
  Widget signOffPageHeading(
      // RiskAssessmentDto riskAssessmentEntity,
      // Context context,
      {
    required RiskAssessmentDto riskAssessmentEntity,
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
            riskAssessmentEntity.companyDto?.signOffStatementReport ??
                "sign_off_statement_report",
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
  // CREATE SIGN OFF ROWS
  ///
  /* ************************************** */
  void addSignOffPages({
    required RiskAssessmentDto riskAssessmentEntity,
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
          isSubcribed: riskAssessmentEntity.isSubscribed ?? 0,
          pageOrientation: PageOrientation.landscape,
          themeData: pdfHelper.raTheme,
        ),
        build: (context) {
          return returnSignOffWidgetList(
            context: context,
            riskAssessmentEntity: riskAssessmentEntity,
          );
        },
        header: (context) {
          return RaHeaderRow(
              localeName: platFormLocaleName,
              riskAssessmentEntity: riskAssessmentEntity,
              pageNo: context.pageNumber,
              logoImage: companyLogo,
              headerForSignOff: true,
              pdfHelper: pdfHelper);
        },
        footer: (context) {
          return RaFooterRow(
            localeName: platFormLocaleName,
            pageNo: context.pageNumber,
            riskAssessmentEntity: riskAssessmentEntity,
            signatureImage: null,
            reviewImage: null,
            isSignOffFooter: true,
          );
        },
      ),
    );
  }

  List<Widget> returnSignOffWidgetList({
    required RiskAssessmentDto riskAssessmentEntity,
    required Context context,
  }) {
    List<Widget> list = List.empty(growable: true);
    var signOffUsers = (riskAssessmentEntity.listReviewSignOffUsers ?? [])
        .where((element) => element.userType == ReviewSignOffUserType.signOff)
        .toList();

    List<Widget> rowChildren = [];

    if ((riskAssessmentEntity.signoffMode ?? 0) == 0) {
      return [];
    }
    list.add(signOffPageHeading(
      // context: context,
      context: context,
      riskAssessmentEntity: riskAssessmentEntity,
    ));

    /// this condition is applied to show  manual SignOff review
    if (riskAssessmentEntity.signoffMode == ReviewSignOffMode.manual) {
      int numberOfSignOff = riskAssessmentEntity.numberOfSigneeRequired ?? 0;
      int numberOfRowToShow = 3;
      if (numberOfSignOff != 0) {
        for (int i = 1; i <= numberOfSignOff; i++) {
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
                    child: SignOffSignature(
                        user: ReviewSignOffUserDto(),
                        localeName: platFormLocaleName),
                  ),
                ),
              ),
            ),
          );
          if (i == numberOfRowToShow) {
            numberOfRowToShow = numberOfRowToShow + 3;
            list.add(createSignOffRow(rowChildren));
            rowChildren.clear();
          }
        }
        list.add(createSignOffRow(rowChildren));
        rowChildren.clear();
      }
    } else if (signOffUsers.isNotEmpty) {
      for (var user in signOffUsers) {
        MemoryImage? image = user.memoryImage;

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
                  child: SignOffSignature(
                    localeName: platFormLocaleName,
                    user: user,
                    signatureImage: image,
                  ),
                ),
              ),
            ),
          ),
        );
        if (rowChildren.length == 3) {
          list.add(createSignOffRow(rowChildren));
          rowChildren.clear();
        } else if (signOffUsers.last == user) {
          list.add(createSignOffRow(rowChildren));
          rowChildren.clear();
        }
      }
    }
    return list;
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

  /* ********************/
  // SHOW ASSESSMENT IMAGE ON PDF
  /// this method is responsible for showing assessment image on pdf
  /* ********************/
  void showAssessmentImageOnPdf({
    required RiskAssessmentDto riskAssessmentEntity,
    required Document pdf,
    // required Context context,
  }) {
    List<Widget> list = List.empty(growable: true);
    List<AssessmentImageDto> assessmentImageList =
        riskAssessmentEntity.listAssessmentImage ?? [];

    if (assessmentImageList.isNotEmpty) {
      // here we first filtered it so we can get the selected image
      // and put it in a symbolic loop so we don't have to write logic seperately
      var filterList =
          assessmentImageList.where((element) => element.isSelected == 1);

      for (AssessmentImageDto imageEntity in filterList) {
        MemoryImage? assessmentImage =
            // await generateAssessmentImage(imageEntity);
            imageEntity.memoryImage;

        int index = assessmentImageList.indexOf(imageEntity) + 1;
        if (assessmentImage != null) {
          list.add(
            AssessmentImageSection(
              logoImage: companyLogo,
              isSelected: imageEntity.isSelected,
              image: assessmentImage,
              riskAssessmentEntity: riskAssessmentEntity,
              index: 1,
              raPdfPageTitleType: RaPdfPageTitleType.assessmentImage,
            ),
          );
        }
      }

      //iterate the assessment image entity from the assessment image list
      var filterUnselectedImages = assessmentImageList
          .where((element) => element.isSelected == 0)
          .toList();

      int count = 2;

      for (AssessmentImageDto imageEntity in filterUnselectedImages) {
        MemoryImage? assessmentImage =
            // await generateAssessmentImage(imageEntity);
            imageEntity.memoryImage;
        int index = assessmentImageList.indexOf(imageEntity) + 1;
        if (assessmentImage != null) {
          list.add(
            AssessmentImageSection(
              logoImage: companyLogo,
              isSelected: imageEntity.isSelected,
              image: assessmentImage,
              riskAssessmentEntity: riskAssessmentEntity,
              index: count++,
              raPdfPageTitleType: RaPdfPageTitleType.assessmentImage,
            ),
          );
        }
      }

      pdf.addPage(
        pw.MultiPage(
          pageTheme: TbPdfHelper().returnPageTheme(
            waterMarkImage: pdfHelper.raWaterMarkImage,
            pageFormat: const PdfPageFormat(
              29.7 * PdfPageFormat.cm,
              21.0 * PdfPageFormat.cm,
              marginAll: 0,
            ),
            isSubcribed: riskAssessmentEntity.isSubscribed ?? 0,
            pageOrientation: PageOrientation.landscape,
            themeData: pdfHelper.raTheme,
          ),
          build: (context) {
            return list;
          },
          footer: (context) {
            return Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(
                  bottom: 15, right: TbRaPdfPaddings.pageRightPadding.right),
              child: Text(
                "Page No: ${context.pageNumber}${getReferenceNumber(riskAssessmentEntity)}",
                // style: raPdfTextStyles.italicBlack8(),
                style: TbPdfHelper().textStyleGenerator(
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
  }

  /* ********************/
  // SHOW REFERENCE IMAGE ON PDF
  ///this method is responsible for showing reference image on pdf
  /* ********************/
  void showReferenceImageOnPdf({
    required RiskAssessmentDto riskAssessmentEntity,
    required Document pdf,
  }) {
    int index = 0;
    List<Widget> list = List.empty(growable: true);
    List<ReferenceImageDto> referenceImageList =
        riskAssessmentEntity.listReferenceImage ?? [];
    if (referenceImageList.isNotEmpty) {
      for (ReferenceImageDto imageEntity in referenceImageList) {
        MemoryImage? referenceImage = imageEntity.memoryImage;
        index = referenceImageList.indexOf(imageEntity) + 1;
        if (referenceImage != null) {
          list.add(
            AssessmentImageSection(
              logoImage: companyLogo,
              image: referenceImage,
              riskAssessmentEntity: riskAssessmentEntity,
              index: index,
              raPdfPageTitleType: RaPdfPageTitleType.referenceImage,
            ),
          );
        }
      }
      pdf.addPage(
        pw.MultiPage(
          pageTheme: TbPdfHelper().returnPageTheme(
            waterMarkImage: pdfHelper.raWaterMarkImage,
            pageFormat: const PdfPageFormat(
              29.7 * PdfPageFormat.cm,
              21.0 * PdfPageFormat.cm,
              marginAll: 0,
            ),
            isSubcribed: riskAssessmentEntity.isSubscribed ?? 0,
            pageOrientation: PageOrientation.landscape,
            themeData: pdfHelper.raTheme,
          ),
          build: (context) {
            return list;
          },
          footer: (context) {
            return Container(
              padding: EdgeInsets.only(
                  bottom: 15, right: TbRaPdfPaddings.pageRightPadding.right),
              alignment: Alignment.bottomRight,
              child: Text(
                "Page No: ${context.pageNumber}${getReferenceNumber(riskAssessmentEntity)}",
                // style: raPdfTextStyles.italicBlack8(),
                style: TbPdfHelper().textStyleGenerator(
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
  }

  /* ************************************** */
  // ADD MAP IMAGE
  /// this will come into handy when we need to add map image
  /// if user has added Location and weather info
  /* ************************************** */
  void showMapInfoOnPdf({
    required RiskAssessmentDto riskAssessmentEntity,
    required Document pdf,
  }) {
    // create Image Row
    //  MemoryImage? image = await mapImage(riskAssessmentEntity);
    MemoryImage? image = riskAssessmentEntity.mapMemoryImage;

    if (image != null) {
      pdf.addPage(
        pw.MultiPage(
          pageTheme: TbPdfHelper().returnPageTheme(
            waterMarkImage: pdfHelper.raWaterMarkImage,
            pageFormat: const PdfPageFormat(
              29.7 * PdfPageFormat.cm,
              21.0 * PdfPageFormat.cm,
              marginAll: 0,
            ),
            isSubcribed: riskAssessmentEntity.isSubscribed ?? 0,
            pageOrientation: PageOrientation.landscape,
            themeData: pdfHelper.raTheme,
          ),
          build: (context) {
            // return listWidget;
            return returMapWidgetList(
              context: context,
              riskAssessmentEntity: riskAssessmentEntity,
              image: image,
            );
          },
          header: (context) {
            return RaMapHeaderRow(
              riskAssessmentEntity: riskAssessmentEntity,
              logoImage: companyLogo,
            );
          },
          footer: (context) {
            int pageNo = context.pageNumber;
            return Container(
              // padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(
                  bottom: 15, right: TbRaPdfPaddings.pageRightPadding.right),
              child: Text(
                  "Page No: $pageNo${getReferenceNumber(riskAssessmentEntity)}",
                  // style: raPdfTextStyles.italicBlack8(),

                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontItalic,
                    color: TbRaPdfColors.black,
                    fontSize: 8,
                  )),
            );
          },
        ),
      );
    }
  }

  Widget mapDisclaimerWidge({
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

  /* ************************************* / 
   //  RETURN MAP WIDGET LIST 
   
   /// this method  return the list of widget contains map discalmer, mapheaderrow,
   /// mapHeading cell as widget item
  / ************************************* */

  List<Widget> returMapWidgetList({
    required MemoryImage? image,
    required RiskAssessmentDto riskAssessmentEntity,
    required Context context,
  }) {
    List<Widget> listWidget = [];
    // listWidget.add(Container(height: 10, width: double.infinity));

    if (image != null) {
      var row =
          MapImageRow(riskAssessmentEntity: riskAssessmentEntity, image: image);
      listWidget.add(row);
    }

    if ((riskAssessmentEntity.listWeatherDto ?? []).isNotEmpty) {
      listWidget
          .add(mapDisclaimer(context: context, entity: riskAssessmentEntity));
      listWidget.add(mapHeadingRow(
        context: context,
      ));
      for (WeatherDto element in riskAssessmentEntity.listWeatherDto ?? []) {
        if ((riskAssessmentEntity.listWeatherDto ?? []).indexOf(element) == 3) {
          // listWidget.add(Container(height: 20, width: double.infinity));
          listWidget.add(
              mapDisclaimer(context: context, entity: riskAssessmentEntity));
          listWidget.add(mapHeadingRow(
            context: context,
          ));
        }

        listWidget.add(
          Container(
            height: 25,
            width: double.infinity,
            padding: TbRaPdfPaddings.pageHorizontalPadding,
            child: Container(
              child: Row(
                children: [
                  mapHeadingCell(
                    // title: element.date ?? "",
                    title: TbPdfHelper.dateStringForLocaleInPdf(
                        date: element.date ?? "",
                        localeName: platFormLocaleName),
                    // style: raPdfTextStyles.hazardTableHeading(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.black,
                      fontSize: 10,
                    ),
                    color: TbRaPdfColors.greyBorder,
                  ),
                  mapHeadingCell(
                    title: element.sunrise ?? "",
                    // style: raPdfTextStyles.weatherCell13(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.weatherTextColor,
                      fontSize: 10,
                    ),
                    // color: RaPdfColors.lightgreyKeyStaffBackground,
                    color: PdfColors.white,
                  ),
                  mapHeadingCell(
                    title: element.sunset ?? "",
                    // style: raPdfTextStyles.weatherCell13(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.weatherTextColor,
                      fontSize: 10,
                    ),
                    // color: RaPdfColors.greyBorder,
                    color: TbRaPdfColors.lightgreyKeyStaffBackground,
                  ),
                  mapHeadingCell(
                    title: element.chancesOfRain ?? "",
                    // style: raPdfTextStyles.weatherCell13(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.weatherTextColor,
                      fontSize: 10,
                    ),
                    // color: RaPdfColors.lightgreyKeyStaffBackground,
                    color: PdfColors.white,
                  ),
                  mapHeadingCell(
                    title: element.humidity ?? "",
                    // style: raPdfTextStyles.weatherCell13(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.weatherTextColor,
                      fontSize: 10,
                    ),
                    // color: RaPdfColors.greyBorder,
                    color: TbRaPdfColors.lightgreyKeyStaffBackground,
                  ),
                  mapHeadingCell(
                    title: element.windSpeed ?? "",
                    // style: raPdfTextStyles.weatherCell13(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.weatherTextColor,
                      fontSize: 10,
                    ),
                    // color: RaPdfColors.lightgreyKeyStaffBackground,
                    color: TbRaPdfColors.white,
                  ),
                  mapHeadingCell(
                    title: element.pressure ?? "",
                    // style: raPdfTextStyles.weatherCell13(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.weatherTextColor,
                      fontSize: 10,
                    ),
                    // color: RaPdfColors.greyBorder,
                    color: TbRaPdfColors.lightgreyKeyStaffBackground,
                  ),
                  mapHeadingCell(
                    title: element.visibility ?? "",
                    // style: raPdfTextStyles.weatherCell13(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.weatherTextColor,
                      fontSize: 10,
                    ),
                    // color: RaPdfColors.lightgreyKeyStaffBackground,
                    color: PdfColors.white,
                  ),
                  mapHeadingCell(
                    title: element.uvIndex ?? "",
                    // style: raPdfTextStyles.weatherCell13(),
                    style: TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.weatherTextColor,
                      fontSize: 10,
                    ),
                    // color: RaPdfColors.greyBorder,
                    color: TbRaPdfColors.lightgreyKeyStaffBackground,
                  ),
                ],
              ),
            ),
          ),
        );
        if ((riskAssessmentEntity.listWeatherDto ?? []).indexOf(element) == 2) {
          listWidget.add(mapDisclaimerWidge(
            context: context,
          ));
        }
      }
      listWidget.add(mapDisclaimerWidge(
        context: context,
      ));
    }

    return listWidget;
  }

  /* ************************************* / 
   // MAP HEADING CELL 
   
   /// 
  / ************************************* */
  Widget mapHeadingCell({
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

  Widget mapDisclaimer(
      {required Context context, required RiskAssessmentDto entity}) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: EdgeInsets.only(
          left: TbRaPdfPaddings.pageHorizontalPadding.left,
          right: TbRaPdfPaddings.pageHorizontalPadding.right,
          top: 10),
      child: Container(
        // color: RaPdfColors.blue,
        color: TbRaPdfColors.weatherForeCastTitle,
        padding: const EdgeInsets.all(4),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Weather Forecast - ',
                  // style: raPdfTextStyles.boldWhite11(),
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    color: TbRaPdfColors.white,
                    fontSize: 11,
                  ),
                ),
                TextSpan(
                  text:
                      'This forecast is an estimate only, created ${TbPdfHelper.dateStringForLocaleInPdf(date: entity.assessmentDate ?? "", localeName: platFormLocaleName)} , and may not reflect actual weather conditions. You should check those conditions on the relevant day. The forecast is provided by Open-Meteo.com. and we accept no liability for any loss arising out of reliance upon the forecast.',
                  // style: raPdfTextStyles.normalWhite10(),
                  style: TbPdfHelper().textStyleGenerator(
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

  Widget mapHeadingRow({required Context context}) {
    return Container(
      height: 25,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.5),
      child: Container(
        child: Row(
          children: [
            mapHeadingCell(
              title: "Date",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              // color: RaPdfColors.greyBorder,
              color: PdfColors.white,
            ),
            mapHeadingCell(
              title: "Sunrise",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              // color: RaPdfColors.lightgreyKeyStaffBackground,
              // color: RaPdfColors.lightGreyPdfColor,
              color: TbRaPdfColors.lightGreyPdfColor,
            ),
            mapHeadingCell(
              title: "Sunset",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.greyBorder,
            ),
            mapHeadingCell(
              title: "Condition",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              // color: RaPdfColors.lightgreyKeyStaffBackground,
              color: TbRaPdfColors.lightGreyPdfColor,
            ),
            mapHeadingCell(
              title: "Humidity",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.greyBorder,
            ),
            mapHeadingCell(
              title: "Wind Speed",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              // color: RaPdfColors.lightgreyKeyStaffBackground,
              color: TbRaPdfColors.lightGreyPdfColor,
            ),
            mapHeadingCell(
              title: "Pressure",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              color: TbRaPdfColors.greyBorder,
            ),
            mapHeadingCell(
              title: "Visibility",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
              // color: RaPdfColors.lightgreyKeyStaffBackground,
              color: TbRaPdfColors.lightGreyPdfColor,
            ),
            mapHeadingCell(
              title: "UV Index",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
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

  /* ********************/
  // USER SIGNATURE IMAGE
  ///
  /* ********************/
//   Future<pw.MemoryImage?> userSignatureImage(
//     RiskAssessmentDto riskAssessmentEntity,
//   ) async {
//     MemoryImage? signatureImage;
//     if (riskAssessmentEntity.userDto?.signature != null) {
//       String signaturePath = TbFileManager.userSignaturePath(
//         uniqueKey: riskAssessmentEntity.userEntity?.uniqueKey ?? '',
//       );
//       signatureImage = await TbPdfHelper().image(signaturePath);
//     }
//     return signatureImage;
//   }

// // /* ************************************** */
//   // HAZARD IMAGE
//   ///
// /* ************************************** */
//   Future<void> hazardIconImage(HazardEntity entity) async {
//     MemoryImage? image;
//     String path = FileManager.hazardIconPath(iconName: entity.imagePath ?? "");
//     image = await TbPdfHelper().image(path);
//     entity.memoryImage = image;
//   }

  /* ********************/
  //
  ///
  // /* ********************/
  // Future<pw.MemoryImage?> reviewSignOffSignatureImage(
  //   ReviewSignOffUserEntity user,
  // ) async {
  //   MemoryImage? signatureImage;
  //   if (user.signature != null) {
  //     String signaturePath = FileManager.reviewSignOffUserSignaturePath(
  //       name: user.signature ?? "",
  //     );
  //     signatureImage = await TbPdfHelper().image(signaturePath);
  //   }
  //   return signatureImage;
  // }

  /* ********************/
  // GENERATE  ASSESSMENT IMAGE
  ///this method is responsible for generate the assessment image path
  ///for the given [imageEntity]
  // /* ********************/
  // Future<pw.MemoryImage?> generateAssessmentImage(
  //   AssessmentImageEntity imageEntity,
  // ) async {
  //   MemoryImage? assessmentImage;
  //   if (imageEntity.image != null) {
  //     String assessmentImagePath = FileManager.assessmentImagePath(
  //         uniqueKey: imageEntity.uniqueKey ?? "");
  //     assessmentImage = await TbPdfHelper().image(assessmentImagePath);
  //   }
  //   return assessmentImage;
  // }

  /* ********************/
  // GENERATE  REFERENCE  IMAGE
  ///this method is responsible for generate the assessment image path
  ///for the given [imageEntity]
  /* ********************/

  String getReferenceNumber(
    RiskAssessmentDto? riskAssessmentEntity,
  ) {
    if ((riskAssessmentEntity?.referenceNumber ?? "").isNotEmpty) {
      return " / ${riskAssessmentEntity?.referenceNumber ?? ''}";
    } else {
      return "";
    }
  }

  static String? setRiskOfHarmOnUploading({required String personAtRisk}) {
    var listHarmEntity = [
      HarmDto(
        name: "Employee (Emp)",
        keyName: "Emp",
      ),
      HarmDto(
        name: "Visitor (Vis)",
        keyName: "Vis",
      ),
      HarmDto(
        name: "Member of the public (MoP)",
        keyName: "MoP",
      ),
      HarmDto(
        name: "Young persons (YoP)",
        keyName: "YoP",
      ),
      HarmDto(
        name: "Contractor (Con)",
        keyName: "Con",
      ),
      HarmDto(
        name: "Nursing and Expectant Mums (NeM)",
        keyName: "NeM",
      ),
      HarmDto(
        name: "Service Users (SeU)",
        keyName: "SeU",
      ),
      HarmDto(
        name: "Disabled (Dis)",
        keyName: "Dis",
      ),
    ];

    if (personAtRisk.isNotEmpty) {
      List<HarmDto> listHarmDto = [];

      var listPersonAtRiskName = (personAtRisk).split(", ");

      if (listPersonAtRiskName.isNotEmpty) {
        for (String personAtRisk in listPersonAtRiskName) {
          var list = listHarmEntity
              .where(
                (element) => element.name == personAtRisk,
              )
              .toList();
          if (list.isNotEmpty) {
            listHarmDto.add(list.first);
          }
        }
      }
      String? names;
      if (listHarmEntity.isNotEmpty) {
        var listKeyNames = listHarmDto.map((e) => e.keyName).toList();
        names = listKeyNames.join(",");
      }
      return names;
    } else {
      return null;
    }
  }
}
