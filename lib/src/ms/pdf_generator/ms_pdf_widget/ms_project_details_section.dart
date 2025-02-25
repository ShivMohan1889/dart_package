import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_data.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_project_details_table_cell.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/tb_ms_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/widgets.dart';

class MsProjectDetailsSection extends StatelessWidget {
  List<ProjectDetailsData> projectDetailsSideLeft;
  List<ProjectDetailsData> projectDetailsSideRight;
  MsProjectDetailsSection({
    required this.projectDetailsSideLeft,
    required this.projectDetailsSideRight,
  });

  @override
  Widget build(Context context) {
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
            child: drawFieldList(projectDetailsSideLeft, context),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 20,
              left: 4,
              top: 8,
              bottom: 8,
            ),
            child: drawFieldList(projectDetailsSideRight, context),
          ),
        ],
      ),
    );
  }

  Widget drawFieldList(
    List<ProjectDetailsData> list,
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
      {required List<ProjectDetailsData> list, required Context context}) {
    List<Widget> childrenList = [];

    for (ProjectDetailsData templateValues in list) {
      Widget w = MsProjectDetailsTableCell(
        templateFieldName: templateValues.key,
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        textStyleForFieldName: TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.fontBold,
          color: TbMsPdfColors.black,
          fontSize: 9,
        ),
        textStyleForFieldValues: TbPdfHelper().textStyleGenerator(
          font: Theme.of(context).header0.fontNormal,
          color: TbMsPdfColors.black,
          fontSize: 10,
        ),
        templateFieldValues: templateValues.value,
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
}
