import 'dart:typed_data';

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_injury_option_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_photo_dto.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_witness_dto.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_incident_report_injury_image_box.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_incident_report_location_image.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_incident_report_pdf_image_item.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_incident_report_pdf_image_row.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_incident_report_sketch_image.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_date_time.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_footer.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_header.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_image_title.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_info_box.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_injury_box.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_injury_option_title.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_line_area_manager.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_question.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_space_box.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_text_question.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_type.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_user_details_table.dart';
import 'package:dart_pdf_package/src/utils/enums/incident_report_enum.dart';
import 'package:dart_pdf_package/src/utils/enums/yes_and_no_enum.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIrPdfGenerator {
  final String platFormLocaleName;
  final IncidentReportDto? incidentReportDto;

  final TbPdfHelper pdfHelper;

  TbIrPdfGenerator({
    this.incidentReportDto,
    required this.pdfHelper,
    required this.platFormLocaleName,
  });

  final incidentReportPdfTextStyle = TbIncidentReportPdfTextStyle();

  /// this list holds the widget  which render on the pdf
  final List<Widget> listReportItems = List.empty(growable: true);

  // this list holds the list incidentReport
  List<Widget> listImageRows = List.empty(growable: true);

  /* ************************************** */
  // GENERATOR
  /* ************************************** */

  Future<Uint8List> generatePDF() async {
    final pdf = Document();

    // IMAGES
    final MemoryImage irLogoImage = TbPdfHelper().irLogoImage;

    await preparePdfs(incidentReportDto: incidentReportDto!);

    MemoryImage? logoImage =
        incidentReportDto?.companyDto?.companyLogoMemoryImage;

    // REPORT TYPE
    listReportItems.add(TbIrType(
      incidentReportType: incidentReportDto?.reportingType ?? 0,
    ));

    listReportItems.add(
      TbIrSpaceBox(
        height: 13,
      ),
    );

    //ARE YOU THE PERSON WHO HAD ACCIDENT
    var incidentReportUser = TbIrQuestionRow(
      question: TbPdfHelper().returnTextForIncidentReportType(
        incidentReportEntity: incidentReportDto,
        illHealthTypeText: "ARE YOU THE PERSON WHO HAS ILL-HEALTH?",
        injuryTypeText: "ARE YOU THE PERSON WHO HAD THE ACCIDENT?",
        nearMissType: "ARE YOU THE PERSON WHO HAD THE NEAR MISS?",
      ),
      middleDistance: 25,
      answer: incidentReportDto?.reportedRelation ?? 0,
    );

    listReportItems.add(incidentReportUser);

    //YOUR DETAILS TABLE
    var yourDetailsTable = TbIrUserDetailsTable(
      heading: "YOUR DETAILS",
      padding: TbIrPadding.paddingForUserDetails,
      name: incidentReportDto?.incidentReportUsers?.userName ?? "",
      jobTitle: incidentReportDto?.incidentReportUsers?.jobTitle ?? "",
      addressLine1: incidentReportDto?.incidentReportUsers?.address1 ?? "",
      addressLine2: incidentReportDto?.incidentReportUsers?.address2 ?? "",
      email: incidentReportDto?.incidentReportUsers?.email ?? "",
      postcode: incidentReportDto?.incidentReportUsers?.postcode ?? "",
      telephone: incidentReportDto?.incidentReportUsers?.telephone ?? "",
    );
    listReportItems.add(yourDetailsTable);

    listReportItems.add(TbIrSpaceBox(
      height: 3.5,
    ));

    // YOUR CONNECTION TO THE INJURED PARTY
    // WILL BE SHOWN ONLY IF USER HAS SELECTED NO IN (ARE YOU THE PERSON WHO HAD ACCIDENT)
    if (incidentReportDto?.reportedRelation == YesAndNoOptions.no.index) {
      var connectWidget = TbIrTextQuestion(
        question: "YOUR CONNECTION:",
        answer: returnTextForConnection(),
        answerBoxWidth: TbIrPdfDimension.connectionRowWidth,
      );
      listReportItems.add(connectWidget);
      // adding space
      listReportItems.add(
        TbIrSpaceBox(
          height: 5,
        ),
      );

      // SHOW OTHER CONNECTION OF THE PERSON
      if ((incidentReportDto?.otherConnection ?? "").isNotEmpty) {
        var otherConnectionWidget = TbIrInfoBox(
          title: "CONNECTION",
          value: incidentReportDto?.otherConnection ?? "",
        );
        listReportItems.add(otherConnectionWidget);

        listReportItems.add(
          TbIrSpaceBox(
            height: 10,
          ),
        );
      }

      var incidentReportYesNoOptions = TbIrQuestionRow(
        question:
            "DOES THE PERSON INVOLVED IN THE INCIDENT WORK IN YOUR ORGANISATION?",
        answer: incidentReportDto?.sameOrganisation ?? 0,
      );
      listReportItems.add(incidentReportYesNoOptions);

      listReportItems.add(
        TbIrSpaceBox(
          height: 5,
        ),
      );

      if (incidentReportDto?.sameOrganisation == YesAndNoOptions.no.index) {
        var reasonForPresence = TbIrTextQuestion(
          question:
              incidentReportDto?.reportingType == IncidentReport.nearMissType
                  ? "WHO COULD BE AT RISK?"
                  : "WHY WERE THEY THERE?",
          answer: returnTextForReasonOfPressence(),
          answerBoxWidth: TbIrPdfDimension.connectionRowWidth,
        );
        listReportItems.add(
          TbIrSpaceBox(
            height: 10,
          ),
        );
        listReportItems.add(reasonForPresence);
      }

      var injuredPersonDetails = TbIrUserDetailsTable(
        heading: TbPdfHelper().returnTextForIncidentReportType(
          incidentReportEntity: incidentReportDto,
          injuryTypeText: "Details of the person who had the accident",
          illHealthTypeText: "Details of the person who has ill-health",
          nearMissType: "Details of the person who had the near miss",
        ),
        jobTitle: incidentReportDto?.incidentReportInjuryPerson?.jobTitle ?? "",
        addressLine1:
            incidentReportDto?.incidentReportInjuryPerson?.address1 ?? "",
        addressLine2:
            incidentReportDto?.incidentReportInjuryPerson?.address2 ?? "",
        email: incidentReportDto?.incidentReportInjuryPerson?.email ?? "",
        name: incidentReportDto?.incidentReportInjuryPerson?.name ?? "",
        postcode: incidentReportDto?.incidentReportInjuryPerson?.postcode ?? "",
        telephone:
            incidentReportDto?.incidentReportInjuryPerson?.telephone ?? "",
      );

      listReportItems.add(injuredPersonDetails);
    }

    // update the widget incidentReportAreaManagerRow
    var incidentReportAreaManager =
        TbIrLineAreaManager(incidentReportEntity: incidentReportDto);
    listReportItems.add(
      TbIrSpaceBox(
        height: 15,
      ),
    );
    listReportItems.add(incidentReportAreaManager);

    listReportItems.add(
      TbIrSpaceBox(
        height: 5,
      ),
    );

    // DATE TIME ALONG WITH LOCATION
    var dateTimeRow = TbIrDateTime(
      localName: platFormLocaleName,
      incidentReportDto: incidentReportDto,
    );
    listReportItems.add(dateTimeRow);

    listReportItems.add(
      TbIrSpaceBox(
        height: 10,
      ),
    );

    var incidentReportDescription = TbIrInfoBox(
      title: incidentReportDto?.reportingType == IncidentReport.nearMissType
          ? "What could have happened?"
          : "What happened?",
      value: incidentReportDto?.whatHappen ?? "",
    );

    listReportItems.add(incidentReportDescription);

    listReportItems.add(
      TbIrSpaceBox(
        height: 10,
      ),
    );

    if (incidentReportDto?.reportingType != IncidentReport.illHealthType) {
      var subtanceInvoled = TbIrQuestionRow(
        question: incidentReportDto?.reportingType == IncidentReport.injuryType
            ? "WAS ANY EQUIPMENT OR SUBSTANCE INVOLVED?"
            : "IS ANY EQUIPMENT OR SUBSTANCE INVOLVED?",
        answer: incidentReportDto?.anySubtanceInvolve ?? 0,
      );
      listReportItems.add(subtanceInvoled);

      if (incidentReportDto?.anySubtanceInvolve == YesAndNoOptions.yes.index) {
        listReportItems.add(
          TbIrSpaceBox(
            height: 8,
          ),
        );
        var incidentReportSubtanceDescriptionWidget = TbIrInfoBox(
          title: "WHAT WAS THE EQUIPMENT OR SUBSTANCE?",
          value: incidentReportDto?.substanceDetails ?? "",
        );
        listReportItems.add(incidentReportSubtanceDescriptionWidget);
      }
    }

    if (incidentReportDto?.reportingType != IncidentReport.illHealthType) {
      if ((incidentReportDto?.listIncidentInjuryPhoto ?? []).isNotEmpty) {
        listReportItems.add(
          TbIrSpaceBox(
            height: 8,
          ),
        );

        displayIncidentInjuryPhoto(
          incidentReportLogoImage: irLogoImage,
          pdf: pdf,
        );

        // var widget = listReportItems.last;
        // double height = TbPdfHelper().calculateHeightOfWidget(
        //     widget: widget, width: TbIrPdfDimension.pageWidth);

        // if (height > 600) {
        //   listReportItems.add(
        //     TbIrSpaceBox(
        //       height: 30,
        //       // color: PdfColors.indigo,
        //     ),
        //   );
        // } else {
        //   listReportItems.add(
        //     TbIrSpaceBox(
        //       // color: PdfColors.red,
        //       height: 15,
        //     ),
        //   );
        // }
      }
    }
    listReportItems.add(
      TbIrSpaceBox(
        // color: PdfColors.red,
        height: 15,
      ),
    );

    var anyWitenss = TbIrQuestionRow(
      question: "WERE THERE ANY WITNESSES?",
      answer: incidentReportDto?.anyWitness ?? 0,
    );

    listReportItems.add(anyWitenss);

    showWitnessDetails();

    listReportItems.add(
      TbIrSpaceBox(
        height: 10,
      ),
    );
    // SHOW INJURY OPTIONS
    showIncidentReportOption(irLogoImage);

    showWidgetForIncidentReportType();

    listReportItems.add(
      TbIrSpaceBox(
        height: 10,
      ),
    );
    var isInfoBeingSharedWidget = TbIrQuestionRow(
      question: "I CONSENT TO MY PERSONAL INFORMATION BEING SHARED.",
      answer: incidentReportDto?.isInfoBeingShared ?? 0,
    );
    listReportItems.add(isInfoBeingSharedWidget);

    if (incidentReportDto?.mapImagePath != null) {
      listReportItems.add(TbIrSpaceBox(
        height: 10,
      ));
      showIncidentReportMapLocationImage();
    }

    // ACTUAL RENDERING OF listReportItems
    pdf.addPage(
      MultiPage(
        pageTheme: PageTheme(
          theme: pdfHelper.irTheme,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
        ),
        build: (context) {
          return listReportItems;
        },
        header: (context) {
          return TbIrHeader(
            incidentReportLogoImage: irLogoImage,
            companyLogoImage: logoImage,
          );
        },
        footer: (context) {
          return TbIrFooter(
            companyEntity: incidentReportDto?.companyDto,
            pageNo: context.pageNumber,
            incidentReportEntity: incidentReportDto,
          );
        },
      ),
    );

    var data = pdf.save();

    return data;

    // await TbFileManager.saveAssessmentPdfFile(pdf: pdf, pdfPath: path);
  }

  /*************************************** */
  // SHOW INCIDENT REPORT OPTION
  /// this method is responsible show the injury option on incidentReport Pdf
  /* ************************************** */
  void showIncidentReportOption(MemoryImage irLogoImage) {
    var listIncidentInjuryOptions =
        incidentReportDto?.listIncidentReportInjuryOptions ?? [];

    // if list is empty we don't need to add anything
    if (listIncidentInjuryOptions.isEmpty) {
      return;
    }

    // calculate height of the footer and header and then the page
    var headerHeight = TbPdfHelper().calculateHeightOfWidget(
      widget: TbIrHeader(incidentReportLogoImage: irLogoImage),
      width: TbIrPdfDimension.pageWidth,
    );

    var footerHeight = TbPdfHelper().calculateHeightOfWidget(
      widget:
          TbIrFooter(companyEntity: incidentReportDto?.companyDto, pageNo: 0),
      width: TbIrPdfDimension.pageWidth,
    );

    var consumablePageHeight =
        TbIrPdfDimension.pageHeight - headerHeight - footerHeight;

    var remainingHeight = consumablePageHeight;

    // this list will have the only widgets that will come on to the next
    // page, suppose we have data that comes in 1.5 pages
    // here next page widget list will hold all the widgets
    // of the half page, So that we can calculate remaining height of the page
    List<Widget> nextPageWidget = [];

    // this flag determines if we have renered the
    // title as it will be renered only onec on a page
    int isTitleRendered = 0;

    // calcuale height of the title
    var titleWidget = TbIrInjuryOptionTitle(
      incidentReportEntity: incidentReportDto,
    );
    var titleHeight = TbPdfHelper().calculateHeightOfWidget(
        widget: titleWidget, width: TbIrPdfDimension.pageWidth);

    // it will hold the height of the widgets already present on the page
    double heightSum = 0;

    // loop to calculate height of the page that is half filled
    for (var e in listReportItems) {
      double widgetHeight = TbPdfHelper().calculateHeightOfWidget(
          widget: e, width: TbIrPdfDimension.pageWidth);

      // here we check if there is still space on the widget
      if (remainingHeight > widgetHeight) {
        remainingHeight = remainingHeight - widgetHeight;
      } else {
        // if there is not enough space, we re-initialise
        // the remainingHeight property so it has all the space
        // but widgetHeight
        remainingHeight = consumablePageHeight - widgetHeight;

        // we will initialise the heightSum to 0 as this will be a new page
        heightSum = 0;
      }

      heightSum = heightSum + widgetHeight;

      if (heightSum > consumablePageHeight) {
        nextPageWidget.add(e);
      }
    }

    double nextPageHeight = 0;

    //if remaining height is so small that no image will come in it,
    // then we will have to move image to next page, we do this by adding
    // empty space
    // don't remove -3 form here
    if (remainingHeight < titleHeight + 41) {
      listReportItems.add(Container(
        height: remainingHeight - 3,
      ));

      // loop for the current widget height of the current page
      for (var e in nextPageWidget) {
        double widgetHeight = TbPdfHelper().calculateHeightOfWidget(
            widget: e, width: TbIrPdfDimension.pageWidth);
        nextPageHeight = nextPageHeight + widgetHeight;
      }

      remainingHeight = consumablePageHeight - nextPageHeight;
    }

    List<IncidentReportInjuryOptionDto> listOptions = listIncidentInjuryOptions;

    // here we are iterating all the iamges
    for (var optionEntity in listOptions) {
      var boxWidget = TbIrInjuryOptionBox(
        text: optionEntity.name ?? "",
      );

      // if imageTitleRendered == 0 this means we have not rendered
      // title yet on this page
      if (isTitleRendered == 0) {
        isTitleRendered = 1;
        listReportItems.add(
          TbIrInjuryOptionTitle(
            incidentReportEntity: incidentReportDto,
          ),
        );
        remainingHeight = remainingHeight - titleHeight;
      }

      var hImage = TbPdfHelper().calculateHeightOfWidget(
          widget: boxWidget, width: TbIrPdfDimension.pageWidth);

      if (remainingHeight > hImage) {
        listReportItems.add(boxWidget);

        remainingHeight = remainingHeight - hImage;
      } else {
        if (remainingHeight - 2 > 0) {
          listReportItems.add(
            Container(
              height: remainingHeight - 2,
            ),
          );
        } else {
          listReportItems.add(
            Container(
              height: remainingHeight,
            ),
          );
        }

        isTitleRendered = 0;
        remainingHeight = consumablePageHeight;

        if (isTitleRendered == 0) {
          isTitleRendered = 1;
          listReportItems.add(TbIrInjuryOptionTitle(
            incidentReportEntity: incidentReportDto,
          ));
          remainingHeight = remainingHeight - titleHeight;
        }
        listReportItems.add(boxWidget);

        remainingHeight = remainingHeight - hImage;
      }
    }

    if ((incidentReportDto?.anotherInjury ?? "").isNotEmpty) {
      // update the incidentReportDescription Widget to show

      /// adding the extra Space
      listReportItems.add(
        TbIrSpaceBox(
          height: 10,
        ),
      );

      var irOtherInjuryWidget = TbIrInfoBox(
        title: incidentReportDto?.reportingType != IncidentReport.illHealthType
            ? "Specify Other Injury?"
            : "Specify Other Ill- Health?",
        value: "${incidentReportDto?.anotherInjury}",
      );

      listReportItems.add(irOtherInjuryWidget);
    }
  }

  /*************************************** */
  // SHOW WIDGET FOR INCIDENT REPORT TYPE
  /// in this method we show data into according the incidentreportType
  /* ************************************** */

  void showWidgetForIncidentReportType() async {
    if (incidentReportDto?.reportingType == IncidentReport.injuryType) {
      showInjuryData();
      showCourseOfActionAndOffTime();
    } else if (incidentReportDto?.reportingType ==
        IncidentReport.illHealthType) {
      listReportItems.add(
        TbIrSpaceBox(
          height: 10,
        ),
      );
      var irIllHealthComment = TbIrInfoBox(
        title: "ANY OTHER COMMENT ABOUT ILL HEALTH",
        value: incidentReportDto?.illHealthComment ?? "",
      );
      listReportItems.add(irIllHealthComment);
      showCourseOfActionAndOffTime();
    } else {
      showInjuryCommentAndSeriourness();
    }
  }

  /*************************************** */
  //  SHOW INJURY COMMENT AND SERIOUSNESS
  /// this method is responsible for showing the injury seriousness and
  /// injury comment on incidentReport pdf
  /* ************************************** */
  void showInjuryCommentAndSeriourness() {
    if (incidentReportDto?.injurySeriousness != null) {
      /// adding the extra Space
      listReportItems.add(
        TbIrSpaceBox(
          height: 10,
        ),
      );
      var seriousnessRow = TbIrTextQuestion(
          textWidth: TbIrPdfDimension.injurySeriousNessQuestionWidth,
          question:
              incidentReportDto?.reportingType == IncidentReport.injuryType
                  ? "HOW SERIOUS WAS THE INJURY?"
                  : "HOW SERIOUS COULD THE POSSIBLE INJURY BE ?",
          answer: returnTextForInjurySeriousNess(),
          answerBoxWidth: TbIrPdfDimension.pageWidth -
              TbIrPdfDimension.injurySeriousNessQuestionWidth -
              TbIrPdfDimension.spaceUsedForPadding);

      listReportItems.add(seriousnessRow);
    }

    /// adding the extra Space
    listReportItems.add(
      TbIrSpaceBox(
        height: 10,
      ),
    );

    var injuryCommentBox = TbIrInfoBox(
      title: incidentReportDto?.reportingType == IncidentReport.injuryType
          ? "ANY FURTHER COMMENTS ABOUT THE INJURY?"
          : "ANY FURTHER COMMENTS ABOUT THE POSSIBLE INJURY?",
      value: incidentReportDto?.injuryComment ?? "",
    );

    listReportItems.add(injuryCommentBox);
  }

  /*************************************** */
  // SHOW COURSE OF ACTION AND OFF TIME
  /// this method is responsible for showing the course of
  /// action and work time taken off into pdf
  /* ************************************** */
  void showCourseOfActionAndOffTime() {
    /// adding the extra Space
    listReportItems.add(
      TbIrSpaceBox(
        height: 10,
      ),
    );
    var nextCourseOfActionWidget = TbIrTextQuestion(
      question:
          """WHAT WAS THE NEXT COURSE OF ACTION\nFOR THE PERSON/S AFFECTED?""",
      answer: returnTextForWhatHappenNext(),
      answerBoxWidth: TbIrPdfDimension.pageWidth -
          TbIrPdfDimension.nextCourseOfActionWidgetWidth -
          TbIrPdfDimension.spaceUsedForPadding -
          8,
    );
    listReportItems.add(nextCourseOfActionWidget);

    /// adding the extra Space
    listReportItems.add(
      TbIrSpaceBox(
        height: 10,
      ),
    );
    // show how much time taken off
    var timeTakenOffWidgetRow = TbIrTextQuestion(
      textWidth: TbIrPdfDimension.timeTakenOffWidgetSectionWidth,
      question: "HOW MUCH TIME WAS TAKEN OFF WORK?",
      answer: returnTextForTimeOffWork(),
      // middleDistance: 10,
      answerBoxWidth: TbIrPdfDimension.pageWidth -
          TbIrPdfDimension.timeTakenOffWidgetSectionWidth -
          TbIrPdfDimension.spaceUsedForPadding -
          8,
    );
    listReportItems.add(timeTakenOffWidgetRow);

    if (incidentReportDto?.offWorkNeed == IrOffWorkNeedType.moreThan3days ||
        incidentReportDto?.offWorkNeed == IrOffWorkNeedType.moreThan7days) {
      if (incidentReportDto?.numberOfDaysOffWork != null) {
        /// adding the extra Space
        listReportItems.add(
          TbIrSpaceBox(
            height: 10,
          ),
        );
        var incidentReportNumberOfDays = TbIrInfoBox(
          title: "NUMBER OF DAYS OFF FROM WORK?",
          value: (incidentReportDto?.numberOfDaysOffWork).toString(),
        );
        listReportItems.add(incidentReportNumberOfDays);
      }
    }
  }

  /* ************************************** */
  // SHOW DATA RELATED TO INJURY TYPE
  /* ************************************** */

  void showInjuryData() async {
    if (incidentReportDto?.injuredBodyPart != null) {
      String? bodyPart = (incidentReportDto?.injuredBodyPart ?? "")
          .replaceAll("Other", "${incidentReportDto?.otherBodyPart}");

      // add the extra space in string
      String? injuredBodyPart = bodyPart.replaceAll(",", ", ");

      listReportItems.add(
        TbIrSpaceBox(
          height: 10,
        ),
      );

      var incidentReportDescription = TbIrInfoBox(
        title: "WHICH PART OF THE BODY IS INJURED?",
        value: injuredBodyPart,
      );
      listReportItems.add(incidentReportDescription);
    }
    if (incidentReportDto?.bodySketchPath != null) {
      listReportItems.add(
        TbIrSpaceBox(height: 10),
      );
      MemoryImage? image = incidentReportDto?.memorySketchImage;
      if (image != null) {
        var w = TbIncidentReportSketchImage(
          image: image,
        );

        listReportItems.add(w);
      }
    }
    showInjuryCommentAndSeriourness();

    /// adding the extra Space
    listReportItems.add(
      TbIrSpaceBox(
        height: 10,
      ),
    );
    var incidentReportYesNoOptions = TbIrQuestionRow(
      question: "WAS ANY FIRST ADD GIVEN?",
      answer: incidentReportDto?.firstAidGiven ?? 0,
    );
    listReportItems.add(incidentReportYesNoOptions);
    // show the first add given details on pdf

    if (incidentReportDto?.firstAidGiven == YesAndNoOptions.yes.index) {
      /// adding the extra Space
      listReportItems.add(
        TbIrSpaceBox(
          height: 10,
        ),
      );
      var firstBox = TbIrInfoBox(
        title: "WHO GAVE THE FIRST AID?",
        value: incidentReportDto?.firstAidDetails ?? "",
      );
      listReportItems.add(firstBox);
    }
  }

/*************************************** */
  // DISPLAY INCIDENT INJURY PHOTO
  /// in the method we show the incident Report Images to page of
  /// pdf and in this we also implement the logic of showing 2 on the single row in pdf
  /* ************************************** */

  void displayIncidentInjuryPhoto({
    required Document pdf,
    required MemoryImage incidentReportLogoImage,
  }) {
    // calculate height of the footer and header and then the page
    var headerHeight = TbPdfHelper().calculateHeightOfWidget(
      widget: TbIrHeader(incidentReportLogoImage: incidentReportLogoImage),
      width: TbIrPdfDimension.pageWidth,
    );

    var footerHeight = TbPdfHelper().calculateHeightOfWidget(
      widget:
          TbIrFooter(companyEntity: incidentReportDto?.companyDto, pageNo: 0),
      width: TbIrPdfDimension.pageWidth,
    );

    var consumablePageHeight =
        TbIrPdfDimension.pageHeight - headerHeight - footerHeight;

    // listReportItems.add(Container(
    //   height: 40,
    //   color: PdfColors.amber,
    // ));
    var remainingHeight = consumablePageHeight;

    List<Widget> nextPageWidget = [];

    // determines if imageTitle has been rendered if yes we  will not
    // render it till its not next page
    int imageTitleRendered = 0;

    var titleWidget = TbIrImageTitle(incidentReportEntity: incidentReportDto!);
    var titleHeight = TbPdfHelper().calculateHeightOfWidget(
        widget: titleWidget, width: TbIrPdfDimension.pageWidth);

    double heightSum = 0;

    // this logic for getting height of the widget which show on the next page
    for (var e in listReportItems) {
      double widgetHeight = TbPdfHelper().calculateHeightOfWidget(
          widget: e, width: TbIrPdfDimension.pageWidth);

      // remainingHeight = remainingHeight - widgetHeight;
      remainingHeight = remainingHeight - widgetHeight;

      heightSum = heightSum + widgetHeight;
      // this condition is for getting the current list items which display in the new page
      // for calculating the height
      if (heightSum > consumablePageHeight) {
        nextPageWidget.add(e);
      }
    }

    double nextPageHeight = 0;

    //if remaining height is so small that no image will come in it,
    // then we will have to move image to next page, we do this by adding
    // empty space
    // don't remove -3 form here
    if (remainingHeight < TbIrPdfDimension.incidentReportImageBoxHeight) {
      listReportItems.add(
        Container(
          height: remainingHeight - 3,
          // color: PdfColors.red,
        ),
      );
      // listReportItems
      //     .add(Container(height: remainingHeight - 3, color: PdfColors.red));

      // loop for the current widget  height of the current page
      for (var e in nextPageWidget) {
        double widgetHeight = TbPdfHelper().calculateHeightOfWidget(
            widget: e, width: TbIrPdfDimension.pageWidth);
        nextPageHeight = nextPageHeight + widgetHeight;
      }

      remainingHeight = consumablePageHeight - nextPageHeight;
    }
    // holds the listIncidentInjuryPhoto
    List<IncidentInjuryPhotoDto> incidentPhotosList =
        incidentReportDto?.listIncidentInjuryPhoto ?? [];

    // holds the particular Image Widget
    List<Widget> listImageItem = [];

    // holds the image Row
    List<Widget> listOfRow = [];

    // // here we are iterating all the iamges

    for (IncidentInjuryPhotoDto incidentInjuryPhotoEntity
        in incidentPhotosList) {
      // int index = incidentPhotosList.indexOf(element);

      // here we are making memory image and adding to to listImageItem
      MemoryImage? image = incidentInjuryPhotoEntity.memoryImage;

      var w = TbIncidentReportPdfImageItem(
        image: image,
      );
      listImageItem.add(w);

      // if imageTitleRendered == 0 this means we have not rendered
      // title yet on this page
      if (imageTitleRendered == 0) {
        imageTitleRendered = 1;
        if (incidentReportDto != null) {
          listReportItems
              .add(TbIrImageTitle(incidentReportEntity: incidentReportDto!));
        }

        remainingHeight = remainingHeight - titleHeight;
      }

      // when we have two images we will add them to the page
      if (listImageItem.length == 2) {
        remainingHeight = insertImages(
            listImageItem: listImageItem,
            remainingHeight: remainingHeight,
            imageTitleRendered: imageTitleRendered,
            consumablePageHeight: consumablePageHeight,
            titleHeight: titleHeight,
            listOfRow: listOfRow);
        listImageItem = [];
      }
    }

    if (listImageItem.isNotEmpty) {
      remainingHeight = insertImages(
        listImageItem: listImageItem,
        remainingHeight: remainingHeight,
        imageTitleRendered: imageTitleRendered,
        consumablePageHeight: consumablePageHeight,
        titleHeight: titleHeight,
        listOfRow: listOfRow,
      );
    }
    if (listImageRows.isNotEmpty) {
      var widget = TbIncidentReportInjuryImageBox(
        listRowItems: listImageRows,
      );
      listReportItems.add(widget);
    }
  }
  /* ************************************** */
  // INSERT IMAGES
  /* ************************************** */

  double insertImages({
    required var listImageItem,
    required double remainingHeight,
    required int imageTitleRendered,
    required double consumablePageHeight,
    required double titleHeight,
    required List<Widget> listOfRow,
  }) {
    Widget row = TbIncidentReportPdfImageRow(children: listImageItem);
    var hImage = TbPdfHelper().calculateHeightOfWidget(
        widget: row, width: TbIrPdfDimension.pageWidth);

    if (remainingHeight > hImage) {
      listImageRows.add(row);

      remainingHeight = remainingHeight - hImage;
      listImageItem = [];
    } else {
      imageTitleRendered = 0;
      var imageTitleWidget = listReportItems.last;

      var widget = TbIncidentReportInjuryImageBox(listRowItems: listImageRows);
      listReportItems.add(widget);

      listReportItems.add(
        TbIrSpaceBox(
          // height: remainingHeight - 2,
          height: remainingHeight - 30,
        ),
      );
      remainingHeight = consumablePageHeight;

      if (imageTitleWidget !=
          TbIrImageTitle(incidentReportEntity: incidentReportDto!)) {
        if (imageTitleRendered == 0) {
          imageTitleRendered = 1;
          listReportItems
              .add(TbIrImageTitle(incidentReportEntity: incidentReportDto!));
          remainingHeight = remainingHeight - titleHeight;
        }
      }

      listImageRows = [];

      listImageRows.add(row);
      remainingHeight = remainingHeight - hImage;
      listImageItem = [];
    }
    return remainingHeight;
  }

// /************************************* */
//   // RETURN INCIDENT REPORT SKTECH IMAGE
//   /// this method is responsible for generating the sketch image of incidentReport
//   /* ************************************** */
//   Future<MemoryImage?> returnTbIncidentReportSketchImage() async {
//     MemoryImage? irSketchImage;
//     if (incidentReportDto?.uniqueKey != null &&
//         incidentReportDto?.uniqueKey != "") {
//       String sketchImagePath = FileManager.returnIncidentReportSketchPath(
//         uniqueKey: incidentReportDto?.uniqueKey ?? '',
//       );
//       irSketchImage = await TbPdfHelper().image(sketchImagePath);
//     }
//     return irSketchImage;
//   }

  // // *************************************
  // // RETURN INCIDENT INJURY PHOTO
  // /* ************************************** */
  // Future<MemoryImage?> returnIncidentInjuryPhoto({
  //   required IncidentInjuryPhotoEntity imageEntity,
  // }) async {
  //   MemoryImage? incidentInjuryPhoto;
  //   if (imageEntity.uniqueKey != null && imageEntity.uniqueKey != "") {
  //     String incidentInjuryPhotoPath = FileManager.incidentReportInjuryPhoto(
  //       uniqueKey: imageEntity.uniqueKey ?? '',
  //     );
  //     incidentInjuryPhoto = await TbPdfHelper().image(incidentInjuryPhotoPath);
  //   }
  //   return incidentInjuryPhoto;
  // }

  /// *************************************
  // SHOW WITNESS DETAILS
  /* ************************************** */

  void showWitnessDetails() {
    var listWitnessDetails = incidentReportDto?.listIncidentReportWitness ?? [];

    if (listWitnessDetails.isNotEmpty) {
      listReportItems.add(
        TbIrSpaceBox(
          height: 5,
        ),
      );
    }
    for (IncidentReportWitnessDto witnessEntity in listWitnessDetails) {
      int index = listWitnessDetails.indexOf(witnessEntity) + 1;

      var widget = TbIrUserDetailsTable(
        padding: const EdgeInsets.only(left: 20, right: 25, top: 8),
        heading: "$index. WITNESS DETAILS",
        name: witnessEntity.name ?? "",
        jobTitle: witnessEntity.jobTitle ?? "",
        addressLine1: witnessEntity.address1 ?? "",
        addressLine2: witnessEntity.address2 ?? "",
        email: witnessEntity.email ?? "",
        postcode: witnessEntity.postcode ?? '',
        telephone: witnessEntity.telephone ?? "",
      );

      listReportItems.add(widget);
    }
  }

  /// *************************************
  // RETURN TEXT FOR TIME OFF WORK

  /* ************************************** */

  String returnTextForTimeOffWork() {
    if (incidentReportDto?.offWorkNeed == IrOffWorkNeedType.lessThan3days) {
      return "Less than 3 days";
    } else if (incidentReportDto?.offWorkNeed ==
        IrOffWorkNeedType.moreThan3days) {
      return "More than 3 days";
    } else {
      return "More than 7 days";
    }
  }
  /*************************************** */
  // RETURN TEXT FOR CONNECTION
  /// return text for connection
  /* ************************************** */

  String returnTextForConnection() {
    if (incidentReportDto?.connectionToIncident == IrConnectionType.colleague) {
      return "Colleague";
    } else if (incidentReportDto?.connectionToIncident ==
        IrConnectionType.firstAider) {
      return "First Aider";
    } else if (incidentReportDto?.connectionToIncident ==
        IrConnectionType.witness) {
      return "Witness";
    } else {
      return "Other";
    }
  }

  String returnTextForReasonOfPressence() {
    if (incidentReportDto?.reasonForPresence ==
        IrReasonForPresenceType.customer) {
      return "Customer";
    } else if (incidentReportDto?.reasonForPresence ==
        IrReasonForPresenceType.deliveryDriver) {
      return "Delivery Driver";
    } else if (incidentReportDto?.reasonForPresence ==
        IrReasonForPresenceType.subContractor) {
      return "Sub Contractor";
    } else if (incidentReportDto?.reasonForPresence ==
        IrReasonForPresenceType.vistor) {
      return "Visitor";
    } else {
      return "Other";
    }
  }

  String returnTextForWhatHappenNext() {
    if (incidentReportDto?.whatHappenNext == "0") {
      return "Back to Work";
    } else if (incidentReportDto?.whatHappenNext == "1") {
      return "Doctor";
    } else if (incidentReportDto?.whatHappenNext == "2") {
      return "Hospital";
    } else {
      return "Other";
    }
  }

  String returnTextForInjurySeriousNess() {
    if (incidentReportDto?.injurySeriousness ==
        IrInjurySeriousNessType.noInjury) {
      return "No Injury";
    } else if (incidentReportDto?.injurySeriousness ==
        IrInjurySeriousNessType.minorInjury) {
      return "Minor Injury";
    } else if (incidentReportDto?.injurySeriousness ==
        IrInjurySeriousNessType.lostTimeInjury) {
      return "Lost Time Injury";
    } else if (incidentReportDto?.injurySeriousness ==
        IrInjurySeriousNessType.severeInjury) {
      return "Severe Injury";
    } else {
      return "Fatality";
    }
  }

/*************************************** */
  // SHOW INCIDENT REPORT LOCATION IMAGE
  /// this is responsible for showing the location image into pdf
  ///
  /* ************************************** */

  void showIncidentReportMapLocationImage() {
    MemoryImage? mapImage = incidentReportDto?.memoryLocationMapImage;

    if (mapImage != null) {
      var mapImageWidget = TbIncidentReportLocationImage(
        image: mapImage,
        incidentReportDto: incidentReportDto,
      );
      listReportItems.add(mapImageWidget);
    }
  }

  Future<IncidentReportDto> preparePdfs({
    required IncidentReportDto incidentReportDto,
  }) async {
    incidentReportDto.companyDto?.companyLogoMemoryImage = await TbPdfHelper()
        .generateMemoryImageForPath(
            incidentReportDto.companyDto?.imagePath ?? "");
    incidentReportDto.userDto?.signatureMemoryImage = await TbPdfHelper()
        .generateMemoryImageForPath(incidentReportDto.userDto?.imagePath ?? "");

    incidentReportDto.memoryLocationMapImage = await TbPdfHelper()
        .generateMemoryImageForPath(
            incidentReportDto.locationMapImagePath ?? "");

    incidentReportDto.memorySketchImage = await TbPdfHelper()
        .generateMemoryImageForPath(
            incidentReportDto.bodySketchImagePath ?? "");
    // Section Images
    await Future.forEach(incidentReportDto.listIncidentInjuryPhoto ?? [],
        (element) async {
      IncidentInjuryPhotoDto incidentInjuryPhoto = element;
      incidentInjuryPhoto.memoryImage = await TbPdfHelper()
          .generateMemoryImageForPath(incidentInjuryPhoto.irImagePath ?? "");
    });

    return incidentReportDto;
    // Section Images
    // await Future.forEach(incidentReportDto.listIncidentInjuryPhoto ?? [],
    //     (element) async {
    //   IncidentInjuryPhotoDto sectionEntity = element;
    //   await Future.forEach(sectionEntity.image ?? [], (imageEntity) async {
    //     SectionImageDto sectionImageDto = imageEntity;
    //   });
    // });
  }
}
