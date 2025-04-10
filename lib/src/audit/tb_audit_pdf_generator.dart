import 'dart:typed_data';

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/audit/audit_pdf_widgets/audit_project_details_section.dart';
import 'package:dart_pdf_package/src/audit/audit_pdf_widgets/audit_question_row.dart';
import 'package:dart_pdf_package/src/audit/audit_pdf_widgets/audit_question_textinput_answer_section.dart';
import 'package:dart_pdf_package/src/audit/audit_pdf_widgets/chain_options_for_row.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_assessment_image_box.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_assessment_image_row.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_border.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_footer_section.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_header_row.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_review_signature_section.dart';
import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/enums/audit_enum.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'audit_pdf_constants.dart';

/// A class that generates PDF documents for audit assessments.
class TbAuditPdfGenerator {
  /// The data required for generating the PDF.
  final AuditPdfData pdfData;

  /// PDF helper utility for styling and image processing
  final TbPdfHelper pdfHelper;

  /// Holds options of the pdf to show on the last page report
  /// which one used how many times
  final Map<String, int> chainOptionMap = {};

  /// List of images to be included in a separate page
  final List<MemoryImage> auditImageList = [];

  /// Creates a new [AuditPdfGenerator] instance.
  TbAuditPdfGenerator({
    required this.pdfData,
    required this.pdfHelper,
  });
  final auditPdfItems = <pw.Widget>[];

  /// Generates a PDF document from the provided [pdfData].
  Future<Uint8List> generatePDF() async {
    final pdf = pw.Document();

    // Add company details section

    // Add project details section
    auditPdfItems.add(AuditProjectDetailSection(
      auditAssessmentEntity: pdfData,
    ));
    auditPdfItems.add(MsBorder());

    // Create the main PDF page
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pdfHelper.returnPageTheme(
          waterMarkImage: pdfHelper.msWaterMarkImage,
          isSubscribed: pdfData.isSubscribed,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
          themeData: pdfHelper.auditTheme,
        ),
        build: (context) {
          createSectionRows(context, auditPdfItems);

          // Add user signature if available
          showUserDetails(pdfData: pdfData, context: context);
          return auditPdfItems;
        },
        header: (context) {
          return MsHeaderRow(
            pagesNo: context.pageNumber,
            companyDetails: pdfData.companyDetails,
            companyPhoneEmail: pdfData.companyPhoneEmail ?? "",
            titleForPdf: pdfData.titleForPDF,
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

    // // Add images page if there are images
    // if (auditImageList.isNotEmpty) {
    //   await _addImagesPage(pdf);
    // }

    // Add summary table if needed (based on collected chain option data)
    if (pdfData.tableStatus == 1) {
      _addSummaryTable(pdf);
    }

    return await pdf.save();
  }

  void showUserDetails({
    required AuditPdfData pdfData,
    required Context context,
  }) {
    Widget widget = MsReviewSignatureSection(
      userName: pdfData.userSignature.name,
      userAssessmentDate: pdfData.userSignature.date,
      userSignature: pdfData.userSignature.signatureMemoryImage,
      userPosition: pdfData.userSignature.position,
    );
    auditPdfItems.add(widget);
  }

  /// Builds the content for each section
  void createSectionRows(Context context, List<Widget> auditPdfItems) {
    int questionCount = 0;

    // Process each section
    for (final section in pdfData.sectionsData) {
      // Add section header

      var col = pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          Container(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Text(
              section.name!.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AuditPdfColors.black,
              ),
            ),
          ),

          // Add section description if available
          if (section.description != null && section.description!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                section.description!,
                style: TextStyle(fontSize: 10),
              ),
            ),

          Container(height: 5),
        ],
      );
      auditPdfItems.add(col);
      // auditPdfItems.add(Container(height: 20));

      // if (section.name != null) {
      //   auditPdfItems.add(
      //     Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      //       child: Text(
      //         section.name!.toUpperCase(),
      //         style: TextStyle(
      //           fontSize: 11,
      //           fontWeight: FontWeight.bold,
      //           color: AuditPdfColors.black,
      //         ),
      //       ),
      //     ),
      //   );
      // }

      // // Add section description if available
      // if (section.description != null && section.description!.isNotEmpty) {
      //   auditPdfItems.add(
      //     Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 20),
      //       child: Text(
      //         section.description!,
      //         style: TextStyle(fontSize: 10),
      //       ),
      //     ),
      //   );
      // }
      // auditPdfItems.add(Container(height: 5));

      // Add section images if available
      if ((section.memoryImages?.isNotEmpty ?? false)) {
        auditPdfItems.add(_buildSectionImagesRow(section.memoryImages!));
      }

      // Variables to track chain options
      String? previousChainOptions;

      // Process questions in this section
      for (final question in section.questions) {
        questionCount++;

        // Process based on question type
        if (question.questionType == QuestionType.statement) {
          // Handle statement-type questions
          auditPdfItems.add(
            Container(
              padding:
                  const EdgeInsets.only(left: 50, right: 20, top: 5, bottom: 5),
              child: Text(
                question.question,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: AuditPdfColors.black,
                ),
              ),
            ),
          );
        } else {
          // Handle regular questions

          // Check if chain options string is available and needs to be displayed
          // Display chain options only if:
          // 1. This is the first question with chain options, OR
          // 2. The chain options are different from the previous question
          if (question.chainOptionsString != null &&
              question.chainOptionsString!.isNotEmpty &&
              (previousChainOptions == null ||
                  previousChainOptions != question.chainOptionsString)) {
            // Add the chain options row

            Widget chainOptionsForPdf = ChainOptionsForPdfRow(
              chainOptionsForPdf: question.listChainOption,
            );

            auditPdfItems.add(chainOptionsForPdf);

            // Update the previous chain options to the current one
            previousChainOptions = question.chainOptionsString;
          }

          if ((question.listChainOption ?? []).isNotEmpty) {
            if (chainOptionMap.isEmpty) {
              chainOptionMap.addEntries({question.answer ?? "": 0}.entries);
            } else {
              // this condition is applied to check the question Entity values  is exist  in the map or
              // if it does not exist  then we update question value in map
              if (chainOptionMap.keys.contains(question.answer) == false) {
                chainOptionMap.addEntries({question.answer ?? "": 0}.entries);
              }
            }

            // this condition applied to update the value in ChainOptionMap
            if (question.answer != null) {
              // in this we update value count on basic of  its key in chainOption
              chainOptionMap.update(
                  question.answer ?? "", (value) => value + 1);
            }
          }

          // Add question row
          createQuestionRow(counter: questionCount, questionEntity: question);
        }

        // Add comment if available
        if (question.comment != null && question.comment!.isNotEmpty) {
          auditPdfItems.add(
            Container(
              padding: const EdgeInsets.only(left: 40, right: 20),
              child: Text(
                question.comment!,
                style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
              ),
            ),
          );
        }

        List<MemoryImage> listQuestionImage = [];
        // Process question images if available
        if (question.memoryImages != null &&
            question.memoryImages!.isNotEmpty) {
          for (final image in question.memoryImages!) {
            // auditImageList.add(image);
            listQuestionImage.add(image);

            // auditPdfItems.add(
            //   Container(
            //     padding: const EdgeInsets.only(left: 40, right: 20),
            //     child: Text(
            //       "See image Reference Number - ${listQuestionImage.length}",
            //       style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // );
          }

          if (listQuestionImage.isNotEmpty) {
            processImages(
              images: listQuestionImage,
            );
            auditPdfItems.add(
              pw.Container(
                height: 10,
              ),
            );
          }
        }
      }
    }
  }

  void processImages({
    required List<MemoryImage> images,
    bool isForHeaderImage = false,
  }) {
    List<Widget> rowChildren = [];

    for (int i = 0; i < images.length; i++) {
      // Create image box widget
      MemoryImage memoryImage = images[i];
      Widget imageBox = MsAssessmentImageBox(
        image: memoryImage,
        index: i + 1,
      );

      rowChildren.add(imageBox);
      rowChildren.add(
        Container(
          width: 10,
        ),
      ); // Add spacing between images

      // Create a row when we have 2 images or at the last image
      if (rowChildren.length == 4 || i == images.length - 1) {
        Widget imageRow;
        // if (isForHeaderImage && (i == 0 || i == 1)) {
        //   imageRow = MsAssessmentImageRow(
        //     text: "Header Reference Images",
        //     listChildren: List.from(rowChildren),
        //   );
        // } else {
        imageRow = MsAssessmentImageRow(
          listChildren: List.from(rowChildren),
        );
        // }

        double imageRowHeight = pdfHelper.calculateHeightOfWidget(
          widget: imageRow,
          width: TbMsPdfWidth.pageWidth,
        );

        // Check if row fits on current page
        // if (imageRowHeight > remainingMainPdfHeight) {

        // }

        // Add image row to current page
        auditPdfItems.add(imageRow);
        // remainingMainPdfHeight -= imageRowHeight;

        // Reset row children for next row
        rowChildren = [];
      }
    }
  }

  /// Builds a row displaying section images
  Widget _buildSectionImagesRow(List<MemoryImage> images) {
    List<Widget> imageWidgets = [];

    for (int i = 0; i < images.length; i++) {
      imageWidgets.add(
        Container(
          height: 120,
          width: 120,
          child: Image(images[i]),
        ),
      );

      // Add spacing between images except for the last one
      if (i < images.length - 1 && i % 4 != 3) {
        imageWidgets.add(SizedBox(width: 15));
      }

      // Create a new row after every 4 images
      if ((i + 1) % 4 == 0 && i < images.length - 1) {
        imageWidgets.add(SizedBox(height: 10));
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        runSpacing: 10,
        children: imageWidgets,
      ),
    );
  }

  /* ************************************** */
  //   CREATE QUESTION ROW
  /// in this we are updating the widgets AuditQuestion row and AuditQuestionTextInputAnswerSection
  /// by passing the[QuestionEntity] and adding it into  list of audit pdf items
  /* ************************************** */

  void createQuestionRow({
    required AuditPdfQuestion questionEntity,
    required int counter,
  }) {
    PdfColor questionRowColor = counter % 2 == 0
        ? AuditPdfColors.questionRowBackgroundDarkGreyColor
        : AuditPdfColors.questionRowBackgroundLightGreyColor;

    Widget questionWidgetRow = AuditQuestionRow(
      pdfHelper: pdfHelper,
      questionColor: questionRowColor,
      questionEntity: questionEntity,
    );

    auditPdfItems.add(questionWidgetRow);

    if (questionEntity.questionType == AnswerType.textInput) {
      Widget widget = AuditQuestionTextInputAnswerSection(
        questionEntityValues: questionEntity.answer,
        color: questionRowColor,
      );

      auditPdfItems.add(widget);
    }
  }

  /// Adds a page with all collected images
  Future<void> _addImagesPage(pw.Document pdf) async {
    if (auditImageList.isEmpty) return;

    final List<Widget> imageWidgets = [];

    for (int i = 0; i < auditImageList.length; i++) {
      imageWidgets.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Image Reference ${i + 1}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                child: Image(auditImageList[i], height: 250),
              ),
              Divider(),
            ],
          ),
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pdfHelper.returnPageTheme(
          waterMarkImage: pdfHelper.msWaterMarkImage,
          isSubscribed: pdfData.isSubscribed,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
          themeData: pdfHelper.auditTheme,
        ),
        build: (context) {
          return imageWidgets;
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
  }

  /// Adds a summary table of all chain options used
  void _addSummaryTable(pw.Document pdf) {
    if (chainOptionMap.isEmpty) return;

    final List<Widget> summaryWidgets = [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          "SUMMARY",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Table(
          border: TableBorder.all(color: PdfColors.grey),
          children: [
            // Table header
            TableRow(
              decoration: BoxDecoration(color: AuditPdfColors.black),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Response",
                    style: TextStyle(
                      color: PdfColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Count",
                    style: TextStyle(
                      color: PdfColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // Table rows for each chain option
            ...chainOptionMap.entries
                .map(
                  (entry) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(entry.key),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          entry.value.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    ];

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pdfHelper.returnPageTheme(
          waterMarkImage: pdfHelper.msWaterMarkImage,
          isSubscribed: pdfData.isSubscribed,
          pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm,
            29.7 * PdfPageFormat.cm,
          ),
          themeData: pdfHelper.auditTheme,
        ),
        build: (context) {
          return summaryWidgets;
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
  }
}
