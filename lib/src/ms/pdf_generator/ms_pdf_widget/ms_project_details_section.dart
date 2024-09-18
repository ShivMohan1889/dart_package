

import 'package:dart_pdf_package/src/ms/dto/ms_assessment_dto.dart';
import 'package:dart_pdf_package/src/ms/dto/ms_template_value_dto.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_project_details_table_cell.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/tb_ms_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class MsProjectDetailsSection extends StatelessWidget {
  final MsAssessmentDto? msAssessmentDto;
  final String localeName;

  MsProjectDetailsSection({
    this.msAssessmentDto,
    required this.localeName,
  });

  @override
  Widget build(Context context) {
    List<MsTemplateValueDto> list1;

    List<MsTemplateValueDto> list2;

    List<MsTemplateValueDto> listTemplateValues =
        msAssessmentDto?.listMsTemplateValues ?? [];

    // here we are going to split our list into two parts
    // for that we need find mid of the list
    int index = (listTemplateValues.length / 2).round();

    // first list
    list1 = listTemplateValues.getRange(0, index).toList();

    // second list
    list2 =
        listTemplateValues.getRange(index, listTemplateValues.length).toList();

    return Container(
      width: TbMsPdfWidth.pageWidth,
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            // color: PdfColors.red,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 8,
              bottom: 8,
            ),
            child: drawFieldList(
              list1,
              context,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 20,
              left: 4,
              top: 8,
              bottom: 8,
            ),
            child: drawFieldList(list2, context),
          ),
        ],
      ),
    );
  }

  Widget drawFieldList(
    List<MsTemplateValueDto> list,
    Context context,
  ) {
    return Container(
      width: TbMsPdfWidth.pageWidth / 2 - 20,
      child: Column(
        children: children(
          list: list,
          context: context,
        ),
      ),
    );
  }

  /* ************************************* / 
    // CHILDREN 
    
    /// 
   / ************************************* */

  List<Widget> children(
      {required List<MsTemplateValueDto> list, required Context context}) {
    List<Widget> childrenList = [];
    String? fieldValue;
    TextStyle? fieldValueTextStyle;

    for (MsTemplateValueDto templateValues in list) {
      if (templateValues.dbKeyName == "project_name") {
        fieldValue = fieldValue = msAssessmentDto?.isSubscribed == 0
            ? "Upgrade to Unlock"
            : templateValues.values ?? "";
        fieldValueTextStyle = msAssessmentDto?.isSubscribed == 1
            ? TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbMsPdfColors.companyDetailsTextColor,
                fontSize: 10,
              )
            : TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbMsPdfColors.upgradeToUnlockColor,
                fontSize: 10,
              );
      } else if (templateValues.keyName == "Created On") {
        fieldValue = fieldValue = msAssessmentDto?.isSubscribed == 0
            ? "Upgrade to Unlock"
            : (templateValues.values ?? "").isNotEmpty
                ? TbPdfHelper.dateStringForLocaleInPdf(
                    date: templateValues.values ?? "", localeName: localeName)
                : "NA";
        fieldValueTextStyle = msAssessmentDto?.isSubscribed == 1
            ? TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbMsPdfColors.companyDetailsTextColor,
                fontSize: 10,
              )
            : TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbMsPdfColors.upgradeToUnlockColor,
                fontSize: 10,
              );
      } else {
        fieldValue = (templateValues.values ?? "").isEmpty
            ? "NA"
            : returnDateTypeValue(valueDto: templateValues);

        fieldValueTextStyle = TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.font,
          color: TbMsPdfColors.companyDetailsTextColor,
          fontSize: 10,
        );
      }

      Widget w = MsProjectDetailsTableCell(
        templateFieldName: templateValues.keyName,
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        textStyleForFieldName: TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.fontBold,
          color: TbMsPdfColors.companyDetailsTextColor,
          fontSize: 10,
        ),
        textStyleForFieldValues: fieldValueTextStyle,
        templateFieldValues: fieldValue,
      );
      childrenList.add(w);
      childrenList.add(
        Container(
          height: 1.3,
        ),
      );
    }
    return childrenList;
  }

  /* ************************************* / 
   //  RETURN DATE TYPE VALUE1111 
   
   /// 
  / ************************************* */

  String returnDateTypeValue({
    required MsTemplateValueDto valueDto,
  }) {
    if (valueDto.type == "date") {
      return TbPdfHelper.dateStringForLocaleInPdf(
          date: valueDto.values ?? "", localeName: localeName);
    } else {
      return valueDto.values ?? "NA";
    }
  }
}
