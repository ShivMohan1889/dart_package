import 'dart:io';
import 'dart:typed_data';

import 'package:dart_pdf_package/src/audit/dto/audit_assessment_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/audit_assessment_question_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/audit_image_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/chain_option_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/question_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/section_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/section_image_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/user_dto.dart';
import 'package:dart_pdf_package/src/utils/download_manager/tb_download_manager.dart';
import 'package:dart_pdf_package/src/utils/enums/enum/audit_enum.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:dart_pdf_package/src/utils/tb_file_manager/tb_file_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'audit_pdf_constants.dart';
import 'audit_pdf_widgets/audit_company_details_section.dart';
import 'audit_pdf_widgets/audit_footer_section.dart';
import 'audit_pdf_widgets/audit_header_section.dart';
import 'audit_pdf_widgets/audit_pdf_custom_text.dart';
import 'audit_pdf_widgets/audit_project_details_section.dart';
import 'audit_pdf_widgets/audit_question_image_column.dart';
import 'audit_pdf_widgets/audit_question_row.dart';
import 'audit_pdf_widgets/audit_question_textinput_answer_section.dart';
import 'audit_pdf_widgets/audit_section_image_item.dart';
import 'audit_pdf_widgets/audit_section_image_row.dart';
import 'audit_pdf_widgets/audit_summary_table.dart';
import 'audit_pdf_widgets/audit_user_details_section.dart';
import 'audit_pdf_widgets/chain_options_for_row.dart';

class TbAuditPdfGenerator {
  final AuditAssessmentDto? auditAssessmentEntity;

  late TbPdfHelper pdfHelper;

  final String platFormLocaleName;

  TbAuditPdfGenerator({
    required this.pdfHelper,
    required this.auditAssessmentEntity,
    required this.platFormLocaleName,
  });

  /// holds options of the pdf to show on the last page report
  /// which one used how many times
  Map<String, int> chainOptionMap = {};

  /// this list holds the widget  which render on the pdf
  final List<pw.Widget> auditPdfItems = List.empty(growable: true);

  /// this list holds the  AuditImage for the given Audit Assessment
  final List<AuditImageDto> auditImageList = List.empty(growable: true);

  Future<Uint8List> generatePDF() async {
    await preparePdfs(auditAssessmentEntity!);
    final pdf = pw.Document();

    for (SectionDto sectionDto
        in auditAssessmentEntity?.auditTemplateDto?.sectionsDto ?? []) {
      for (QuestionDto questionDto in sectionDto.questionsDto ?? []) {
        questionDto.sectionEntity = sectionDto;
      }
    }

    updateTemplateEntity(auditAssessmentEntity: auditAssessmentEntity);

    // adding the widget of company details row into the list of audit pdf items
    Widget companyDetailsRow = AuditCompanyDetailsSection(
      auditAssessmentEntity: auditAssessmentEntity,
    );
    auditPdfItems.add(companyDetailsRow);

    Widget divider = Center(
      child: Container(
        width: AuditPdfDimension.pageWidth,
        height: 1.5,
        color: AuditPdfColors.auditBlueLightColor,
      ),
    );

    auditPdfItems.add(divider);

    // adding the widget of project details row into the list of audit pdf items
    Widget projectDetailsRow = AuditProjectDetailSection(
      auditAssessmentEntity: auditAssessmentEntity,
      localeName: platFormLocaleName,
    );
    auditPdfItems.add(projectDetailsRow);

    auditPdfItems.add(divider);

    pdf.addPage(
      pw.MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          waterMarkImage: pdfHelper.msWaterMarkImage,
          isSubcribed: auditAssessmentEntity?.isSubscribed ?? 0,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
          themeData: pdfHelper.auditTheme,
        ),
        build: (context) {
          createSectionRows(
            auditAssessmentEntity: auditAssessmentEntity,
            context: context,
          );
          if (auditAssessmentEntity?.userDto != null) {
            showUserEntity(
              localeName: platFormLocaleName,
              pdf: pdf,
              userDto: auditAssessmentEntity?.userDto,
              userSignatureImage:
                  auditAssessmentEntity?.userDto?.signatureMemoryImage,
            );
          }

          return auditPdfItems;
        },
        header: (context) {
          return AuditHeaderSection(
            auditAssessmentEntity: auditAssessmentEntity,
            companyLogoImage:
                auditAssessmentEntity?.companyDto?.companyLogoMemoryImage,
          );
        },
        footer: (context) {
          return AuditFooterSection(
            pageNo: context.pageNumber.toString(),
            auditAssessmentEntity: auditAssessmentEntity,
          );
        },
      ),
    );

    await showAuditQuestionImages(
      pdf: pdf,
    );

    if (auditAssessmentEntity?.auditTemplateDto?.tableStatus == 1) {
      showAuditSummaryTable(
        auditChainOptionMap: chainOptionMap,
        pdf: pdf,
      );
    }

    // String aPath = pathToWritePDF;
    // final file = File(aPath);
    // var data = await pdf.save();
    // file.writeAsBytesSync(data);
    // return;
    var data = await pdf.save();
    // file.writeAsBytesSync(data);
    return data;
  }

  // void generate({
  //   required AuditAssessmentDto? auditAssessmentEntity,
  //   required MemoryImage checkImage,
  //   required MemoryImage unCheckedImage,
  //   required Context context,
  // }) {
  //   createSectionRows(
  //     auditAssessmentEntity: auditAssessmentEntity,
  //     checkImage: checkImage,
  //     unCheckedImage: unCheckedImage,
  //     context: context,
  //   );
  // }

  void showUserEntity({
    required pw.Document pdf,
    required UserDto? userDto,
    MemoryImage? userSignatureImage,
    required String localeName,
  }) {
    Widget userWidget = AuditUserDetailsSection(
      localeName: localeName,
      userAssessmentDate: auditAssessmentEntity?.date ?? "",
      userName: auditAssessmentEntity?.userDto?.userName ?? "",
      userPosition: auditAssessmentEntity?.userDto?.position ?? "",
      userSignature: userSignatureImage,
    );
    auditPdfItems.add(userWidget);
  }

  /* ************************************** */
  // SHOW AUDIT SUMMARY TABLE
  /// in this  we  show the audit summary table widget  into the last page of pdf
  /* ************************************** */

  void showAuditSummaryTable({
    required pw.Document pdf,
    required Map<String, int> auditChainOptionMap,
  }) {
    List<Widget> listWidget = List.empty(growable: true);

    Widget summeryTableRow = AuditSummaryTable(chainOptionMap: chainOptionMap);

  listWidget.add(summeryTableRow);

    pdf.addPage(
      pw.MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          waterMarkImage: pdfHelper.msWaterMarkImage,
          isSubcribed: auditAssessmentEntity?.isSubscribed ?? 0,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
          themeData: pdfHelper.auditTheme,
        ),
        build: (context) {
          return listWidget;
        },
        header: (context) {
          return AuditHeaderSection(
            companyLogoImage:
                auditAssessmentEntity?.companyDto?.companyLogoMemoryImage,
            auditAssessmentEntity: auditAssessmentEntity,
          );
        },
        footer: (context) {
          return AuditFooterSection(
            pageNo: context.pageNumber.toString(),
            auditAssessmentEntity: auditAssessmentEntity,
          );
        },
      ),
    );
  }

  /* ************************************** */
  //  SHOW AUDIT QUESTION IMAGES
  /// in this we render the audit image into new page of pdf
  /* ************************************** */

  Future<List<Widget>> showAuditQuestionImages({
    required pw.Document pdf,
  }) async {
    List<Widget> list = List.empty(growable: true);

    if (auditImageList.isNotEmpty) {
      await Future.forEach(
        auditImageList,
        (AuditImageDto imageEntity) async {
          int index = auditImageList.indexOf(imageEntity);
          ++index;
          MemoryImage? image = imageEntity.memoryImage;

          if (image != null) {
            list.add(
              AuditQuestionImageColumn(
                  auditAssessmentImage: image,
                  auditAssessmentImageIndex: index.toString()),
            );
          }
        },
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageTheme: TbPdfHelper().returnPageTheme(
          waterMarkImage: pdfHelper.msWaterMarkImage,
          isSubcribed: auditAssessmentEntity?.isSubscribed ?? 0,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
          themeData: pdfHelper.auditTheme,
        ),
        build: (context) {
          return list;
        },
        header: (context) {
          return AuditHeaderSection(
            auditAssessmentEntity: auditAssessmentEntity,
            pagesNo: 1,
            companyLogoImage:
                auditAssessmentEntity?.companyDto?.companyLogoMemoryImage,
          );
        },
        footer: (context) {
          return AuditFooterSection(
            pageNo: context.pageNumber.toString(),
            auditAssessmentEntity: auditAssessmentEntity,
          );
        },
      ),
    );
    return [];
  }

  /* ************************************** */
  //  UPDATE TEMPLATE
  /// updates templates so sections are selected and questions are selected and answers are assigned
  /* ************************************** */

  void updateTemplateEntity({
    required AuditAssessmentDto? auditAssessmentEntity,
  }) {
    List<AuditAssessmentQuestionDto> auditAssessmentQuestionList =
        auditAssessmentEntity?.listAuditAssessmentQuestionDto ?? [];
    // loop for iterating the section entity from the list of section
    for (SectionDto sectionEntity
        in auditAssessmentEntity?.auditTemplateDto?.sectionsDto ?? []) {
      List<QuestionDto> questionList = sectionEntity.questionsDto ?? [];

      for (QuestionDto questionEntity in questionList) {
        int index = questionList.indexOf(questionEntity);
        // this will update question no for parent questions
        questionEntity.questionNumber = "${index + 1}";

        if (questionList.indexOf(questionEntity) == 0) {
          // update chainOptions for parent
          questionEntity.chainOptionsForPdf = questionEntity.chainOption;
        }
        updateQuestion(
          questionEntity: questionEntity,
          assessmentQuestionList: auditAssessmentQuestionList,
        );

        // updating the is Selected of Section Entity
        if (questionEntity.isQuestionSelected == 1) {
          sectionEntity.isSelected = 1;
        }
      }
    }
  }

  /* ************************************** */
  //  UPDATE QUESTION
  /// Updates the passed [questionEntity]
  ///
  /// [assessmentQuestionList] holds the answered question while creating audit
  /* ************************************** */

  void updateQuestion({
    required QuestionDto questionEntity,
    required List<AuditAssessmentQuestionDto> assessmentQuestionList,
  }) {
    findQuestionNumber(questionEntity);
    // here we are checking if question is child and assinging questin no to it.
    if (questionEntity.parent != null) {
      if (questionEntity.answerType != QuestionType.statement) {}
    }

    // loop for iterating the subQuestion of Question Entity
    for (QuestionDto subQuestionDto in questionEntity.subQuestions ?? []) {
      updateQuestion(
        questionEntity: subQuestionDto,
        assessmentQuestionList: assessmentQuestionList,
      );

      // here we are making question as selected if any of the child is selected.
      if (subQuestionDto.isQuestionSelected == 1) {
        questionEntity.isQuestionSelected = 1;
      }
    }

    // find if the question was answered while creating audit
    List<AuditAssessmentQuestionDto> filteredList =
        assessmentQuestionList.where((element) {
      return element.cloudQuestionId == questionEntity.cloudQuestionId;
    }).toList();

    // here we are updating questionEntity to have value as answer, comment and images,
    // as we are going to use template for pdf generation
    if (filteredList.isNotEmpty) {
      if (questionEntity.answerType != AnswerType.statement &&
          questionEntity.questionType == QuestionType.question) {
        questionEntity.values = filteredList.first.answer;
        questionEntity.listAuditImageDto = filteredList.first.listAuditImageDto;
        questionEntity.comment = filteredList.first.comment;
      } else {
        questionEntity.comment = filteredList.first.comment;

        questionEntity.listAuditImageDto = filteredList.first.listAuditImageDto;
      }
      questionEntity.isQuestionSelected = 1;
    }

    // this is condition apply update the chainOptionforpdf only on those questionEntity in which
    // values is not equal to null
    if (questionEntity.values != null) {
      // updating the chainOption in those entity in which chain option is Empty
      // by assign the chain option of its parent
      if (questionEntity.answerType == AnswerType.option) {
        // this condition will work only for sub questions as
        // parent will always have chain options
        if ((questionEntity.chainOption ?? []).isEmpty) {
          questionEntity.chainOption = questionEntity.parent?.chainOption;
        }

        // Access only chain option names (strings) as a list
        var list = (questionEntity.chainOption ?? []).map((ChainOptionDto e) {
          return e.name;
        }).toList();

        // join all the chain options and assign to question
        questionEntity.chainOptionsString = list.join("");

        // this condition will check if question is a sub question
        if (questionEntity.parent != null) {
          int index = (questionEntity.parent?.subQuestions ?? [])
              .indexOf(questionEntity);

          // we will check if it is not first question in the list
          // as we need to check in second question if chain option are same
          // or different, if different then they have a heading with thier own
          // chain options
          if (index > 0) {
            QuestionDto? previousQuestion =
                (questionEntity.parent?.subQuestions ?? [])[index - 1];

            if (previousQuestion.chainOptionsString !=
                questionEntity.chainOptionsString) {
              questionEntity.chainOptionsForPdf = questionEntity.chainOption;
            }
          }
        }
        // updating question when it is a parent, only parents are going to have sectionEntity
        else if (questionEntity.sectionEntity != null) {
          int index = (questionEntity.sectionEntity?.questionsDto ?? [])
              .indexOf(questionEntity);

          if (index > 0) {
            QuestionDto? previousQuestion =
                (questionEntity.sectionEntity?.questionsDto ?? [])[index - 1];

            if (previousQuestion.chainOptionsString !=
                questionEntity.chainOptionsString) {
              questionEntity.chainOptionsForPdf = questionEntity.chainOption;
            }
          }
        }
      }
    }
  }

  /* ************************************** */
  //  CREATE SECTION ROWS
  /// responsible for iterating all the section of a template
  /// and create widgets for section, question comment and images
  /* ************************************** */

  void createSectionRows({
    required AuditAssessmentDto? auditAssessmentEntity,
    required Context context,
  }) async {
    int count = 0;
    Future.forEach(auditAssessmentEntity?.auditTemplateDto?.sectionsDto ?? [],
        (sectionEntity) {
      List<QuestionDto> questionList = sectionEntity.questionsDto ?? [];
      sectionEntity as SectionDto;

      if (sectionEntity.isSelected == 1) {
        auditPdfItems.add(
          Container(
            height: 5,
          ),
        );

        Widget sectionNameWidget = AuditPdfCustomText(
          height: 30,

          text: sectionEntity.name.toString().toUpperCase(),
          // textStyle: auditPdfTextStyle.auditSectionTextStyle(),
          textStyle: TbPdfHelper().textStyleGenerator(
            font: Theme.of(context).header0.fontBoldItalic,
            color: AuditPdfColors.auditBlueLightColor,
            fontSize: 15,
          ),
          padding: ((sectionEntity.image ?? []).isNotEmpty ||
                  sectionEntity.description != "")
              ? const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  // top: 6,
                  // bottom: 10,
                )
              : const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  // top: 5,
                ),
        );

        auditPdfItems.add(sectionNameWidget);

        if ((sectionEntity.description ?? "").isNotEmpty) {
          // get the string list by split between the \n
          List<String> descriptionList =
              (sectionEntity.description ?? "").split("\n");
          //  loop for showing the space between line the description text
          for (var description in descriptionList) {
            String descriptionText;

            /// this condit is done because we enable to compare the empty string with empty string
            if (description.isNotEmpty && description.codeUnits.first == 13) {
              // descriptionText = "\n.\n";
              descriptionText = "\n";
            } else {
              descriptionText = description;
            }
            Widget sectionDescriptionWidget = Container(
              // width: AuditPdfDimension.pageWidth - 40,
              // color: PdfColors.amber,
              padding: AuditPdfPaddings.righLeftPadding,
              child: Text(
                descriptionText,
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  color: descriptionText == "\n"
                      ? PdfColors.white
                      : AuditPdfColors.companyDetailsTextColor,
                  // fontSize: 12,
                  fontSize: 12,
                ),
              ),
            );

            auditPdfItems.add(sectionDescriptionWidget);
          }
        }

        if ((sectionEntity.image ?? []).isNotEmpty) {
          List<Widget> listSectionImageRow =
              showSectionImageOnPdfPage(sectionEntity: sectionEntity);

          auditPdfItems.addAll(listSectionImageRow);
        }
      }

      for (QuestionDto questionEntity in questionList) {
        ++count;
        if (questionEntity.isQuestionSelected == 1) {
          if (questionEntity.questionType == QuestionType.statement) {
            // here we are creating a widget for statement
            Widget questionStatementWidget = AuditPdfCustomText(
              // color: PdfColors.amber,
              padding: const EdgeInsets.only(
                left: 50,
                // left: 35,
              ),
              text: "${questionEntity.question}",
              textStyle: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontItalic,
                color: AuditPdfColors.auditBlueLightColor,
                fontSize: 12,
              ),
            );
            auditPdfItems.add(questionStatementWidget);
          } else {
            // adding chain options
            if ((questionEntity.chainOptionsForPdf ?? []).isNotEmpty) {
              Widget chainOptionsForPdf = ChainOptionsForPdfRow(
                chainOptionsForPdf: questionEntity.chainOptionsForPdf,
              );

              auditPdfItems.add(chainOptionsForPdf);
            }

            // this condition is applied to add or create widget only for those
            // question entity in which questionEntity  values is not equal to  null
            if ((questionEntity.values ?? "").isNotEmpty) {
              createQuestionRow(
                questionEntity: questionEntity,
                counter: count,
              );
            }
          }

          addQuestionImageWithComments(
            questionEntity: questionEntity,
            context: context,
          );

          addWidgetForQuestionDto(
            questionEntity: questionEntity,
            counter: count,
            context: context,
          );
        }
      }
    });
  }
  /* ************************************** */
  //  ADD WIDGET FOR QUESTION ENTITY
  /// in this we are updating the widget to show detial of audit assessment into pdf page
  ///  and add this widget  into list of audit pdf item
  /* ************************************** */

  void addWidgetForQuestionDto({
    required QuestionDto questionEntity,
    required int counter,
    required Context context,
  }) {
    String questionEntityValues = questionEntity.parent?.values ?? "";

    if (questionEntity.answerType == AnswerType.option) {
      if (questionEntity.values != null) {
        // in this  firstly we check the chainOption map is empty
        //we its empty then we add the question values as key count number which equal 0 as
        // as value
        if (chainOptionMap.isEmpty) {
          chainOptionMap.addEntries({questionEntity.values ?? "": 0}.entries);
        } else {
          // this condition is applied to check the question Entity values  is exist  in the map or
          // if it does not exist  then we update question value in map
          if (chainOptionMap.keys.contains(questionEntity.values) == false) {
            chainOptionMap.addEntries({questionEntity.values ?? "": 0}.entries);
          }
        }
      }
      // this condition applied to update the value in ChainOptionMap
      if (questionEntity.values != null) {
        // in this we update value count on basic of  its key in chainOption
        chainOptionMap.update(
            questionEntity.values ?? "", (value) => value + 1);
      }
    }

    // this condition is for Updating or adding only the Selected SubQuestion
    // by comparing parent  Question Entity value to its child Question Entity chainStatus
    if (questionEntityValues == questionEntity.chainStatus) {
      if (questionEntity.questionType == QuestionType.statement) {
        // update Question Statement Widget and adding it into the audit pdf items list
        Widget questionStatementWidget = AuditPdfCustomText(
          text: "${questionEntity.question}",
          // textStyle: auditPdfTextStyle.auditStatementTypeQuestionTextStyle(),
          textStyle: TbPdfHelper().textStyleGenerator(
            font: Theme.of(context).header0.fontItalic,
            color: AuditPdfColors.auditBlueLightColor,
            fontSize: 12,
          ),
          padding: AuditPdfPaddings.statementQuestionPadding,
        );

        auditPdfItems.add(questionStatementWidget);
      } else {
        // this condition is applied to add or create widget only for those
        // question entity in which questionEntity  values is not equal to  null
        if (questionEntity.values != null || questionEntity.values != "") {
          //updating
          createQuestionRow(
            questionEntity: questionEntity,
            counter: counter,
          );
        }
      }

      addQuestionImageWithComments(
        questionEntity: questionEntity,
        context: context,
      );
    }
    // loop for iterating the subQuestionDto from the List of SubQuestion in Question Entity

    for (QuestionDto subQuestionDto in questionEntity.subQuestions ?? []) {
      ++counter;
      addWidgetForQuestionDto(
        questionEntity: subQuestionDto,
        counter: counter,
        context: context,
      );
    }
  }

  /* ************************************** */
  //  SHOW SECTION IMAGE ON PDF PAGE
  /// in this method we passed the section entity to get the Section image and
  /// implement the logic to show only 4 image in a single row and
  /// image which came after the fourth one is show on next row
  /* ************************************** */

  List<Widget> showSectionImageOnPdfPage({
    required SectionDto sectionEntity,
  }) {
    //holds the Section image
    List<SectionImageDto> images = sectionEntity.image ?? [];

    List<Widget> listAuditSectionRow = [];

    /// this holds the    audit section item   widget  and  then this  list is passed to audit section Row widget
    /// to show list of section in row
    List<Widget> listSectionImageItems = [];

    // this loop for iterating the element of list of Section image
    // in this loop we have implement the logic to show only 4 image in a single row
    //and image which came after the fourth one is show on next row
    for (SectionImageDto sectionImageEntity in images) {
      if (sectionImageEntity.memoryImage != null) {
        int imageIndex = images.indexOf(sectionImageEntity) + 1;

        MemoryImage i = sectionImageEntity.memoryImage!;
        listSectionImageItems.add(
          AuditSectionImageItem(
            auditSectionImage: i,
          ),
        );
        // listSectionImageItems.add(Container(
        //   width: 28,
        // ));

        // Check if this is the 4th image in the row
        if (imageIndex % 4 == 0) {
          // Set a different width for the 4th image case
          // listSectionImageItems.add(Container(
          //   // height: 20,
          //   color: PdfColors.red,
          //   width: 20, // Custom width for the 4th image case
          // ));
        } else {
          listSectionImageItems.add(Container(
            width: 27.6, // Default width
          ));
        }
      }

      int imageIndex = images.indexOf(sectionImageEntity) + 1;

      int result = imageIndex % 4;

      if (result == 0) {
        var row = AuditSectionImageRow(listSectionImage: listSectionImageItems);
        listAuditSectionRow.add(row);
        listSectionImageItems = [];
      }
    }

    // if some of images are left then we need to add them too into the next row
    // like there was 5 images, it will create a row and next images will be added
    // to the listSectionImageItems, but it will not be shown without below code
    var row = AuditSectionImageRow(
      listSectionImage: listSectionImageItems,
    );
    listAuditSectionRow.add(row);

    return listAuditSectionRow;
  }

  /* ************************************** */
  //  ADD QUESTION IMAGE AND COMMENT
  /// in this we are adding the widget of comment into the audit pdf items list or
  /// add image into audit image list and  adding the customtext widget
  /// which contains string text as see reference index
  /* ************************************** */

  void addQuestionImageWithComments({
    required QuestionDto questionEntity,
    required Context context,
  }) {
    if ((questionEntity.comment ?? "").isNotEmpty) {
      // updating the widget which show comment on pdf page
      Widget questionCommentWidget = AuditPdfCustomText(
        text: questionEntity.comment,
        padding: AuditPdfPaddings.paddingForQuestionImageAndComment,
        // textStyle: auditPdfTextStyle.questionNameTextStyle(),
        textStyle: TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.font,
          fontSize: 12,
          color: AuditPdfColors.companyDetailsTextColor,
        ),
      );
      // adding into audit pdf items list
      auditPdfItems.add(questionCommentWidget);
    }

    if ((questionEntity.listAuditImageDto ??  []).isNotEmpty) {
      // list of image related to  question entity
      var list = questionEntity.listAuditImageDto;

      for (var image in list ?? []) {
        auditImageList.add(image);

        Widget questionImageIndexWidget = AuditPdfCustomText(
          padding: AuditPdfPaddings.paddingForQuestionImageAndComment,
          text: "See image Reference  Number - ${auditImageList.length}",
          textStyle: TbPdfHelper().textStyleGenerator(
            font: Theme.of(context).header0.font,
            fontSize: 12,
            color: AuditPdfColors.companyDetailsTextColor,
          ),
        );

        auditPdfItems.add(questionImageIndexWidget);
      }
    }
  }

  /* ************************************** */
  //   CREATE QUESTION ROW
  /// in this we are updating the widgets AuditQuestion row and AuditQuestionTextInputAnswerSection
  /// by passing the[QuestionDto] and adding it into  list of audit pdf items
  /* ************************************** */

  void createQuestionRow({
    required QuestionDto questionEntity,
    required int counter,
  }) {
    PdfColor questionRowColor = counter % 2 == 0
        ? AuditPdfColors.questionRowBackgroundDarkGreyColor
        : AuditPdfColors.questionRowBackgroundLightGreyColor;

    Widget questionWidgetRow = AuditQuestionRow(
      localeName: platFormLocaleName,
      pdfHelper: pdfHelper,
      questionColor: questionRowColor,
      questionEntity: questionEntity,
    );
    // auditPdfItems.add(Container(
    //   height: 2,
    //   // color: PdfColors.amber,
    // ));
    auditPdfItems.add(questionWidgetRow);

    if (questionEntity.answerType == AnswerType.textInput) {
      Widget widget = AuditQuestionTextInputAnswerSection(
        questionEntityValues: questionEntity.values,
        color: questionRowColor,
      );

      auditPdfItems.add(widget);
    }
  }

  static void findQuestionNumber(QuestionDto questionEntity) {
    if (questionEntity.parent != null) {
      var filteredQuestions = questionEntity.parent?.subQuestions
          ?.where(
              (element) => element.chainStatus == questionEntity.chainStatus)
          .toList();

      int index = filteredQuestions?.indexOf(questionEntity) ?? 0;
      index++;

      String qNo = questionEntity.parent?.questionNumber ?? "";

      if (qNo.contains(".")) {
        // if it is not an immediate subquestion
        // we check if index == 1 (as we have already incremented it in above lines)
        if (index == 1) {
          var newQNo = "$qNo.1";
          questionEntity.questionNumber = newQNo;
        } else {
          var newQNo = "$qNo.$index";
          questionEntity.questionNumber = newQNo;
        }
      } else {
        // if this is immediate subquestion then we add .index (.1 or .2)
        var newQNo = "$qNo.$index";
        questionEntity.questionNumber = newQNo;
      }
    }
  }

  Future<AuditAssessmentDto> preparePdfs(
      AuditAssessmentDto auditAssessmentEntity) async {
    // auditAssessmentEntity.companyDto?.companyLogoMemoryImage =
    //     await TbPdfHelper().image(
    //         imagePath: auditAssessmentEntity.companyDto?.companyLogo ?? "");

    auditAssessmentEntity.companyDto?.companyLogoMemoryImage =
        await TbPdfHelper().generateMemoryImageForPath(
            auditAssessmentEntity.companyDto?.imagePath ?? "");

    auditAssessmentEntity.userDto?.signatureMemoryImage = await TbPdfHelper()
        .generateMemoryImageForPath(
            auditAssessmentEntity.userDto?.imagePath ?? "");

    // Section Images
    await Future.forEach(
        auditAssessmentEntity.auditTemplateDto?.sectionsDto ?? [],
        (element) async {
      SectionDto sectionEntity = element;
      await Future.forEach(
        sectionEntity.image ?? [],
        (imageEntity) async {
          SectionImageDto sectionImageDto = imageEntity;

          sectionImageDto.memoryImage = await TbPdfHelper()
              .generateMemoryImageForPath(sectionImageDto.imagePath ?? "");

          // String sectionImagePath = .auditSectionImagePath(
          //     sectionImageUrl: sectionImageEntity.imagePath ?? '');

          // sectionImageEntity.memoryImage =
          //     await PdfHelper().image(sectionImagePath);
        },
      );
    });

    // question images
    await Future.forEach(
        auditAssessmentEntity.listAuditAssessmentQuestionDto ?? [],
        (question) async {
      AuditAssessmentQuestionDto qe = question;
      await Future.forEach(qe.listAuditImageDto, (imageEntity) async {
        if ((imageEntity.imagePath ?? "").isNotEmpty) {
          imageEntity.memoryImage = await TbPdfHelper()
              .generateMemoryImageForPath(imageEntity.imagePath ?? "");
        }
      });
    });

    return auditAssessmentEntity;
  }
}
