import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/widgets.dart';

import '../audit_pdf_constants.dart';
import 'audit_project_detials_table_cell.dart';

/// this widget is use to show the project details related to audit on pdf
class AuditProjectDetailSection extends StatelessWidget {
  final AuditPdfData? auditAssessmentEntity;

  final auditPdfTextStyles = AuditPdfTextStyles();

  // final String localeName;

  AuditProjectDetailSection({
    this.auditAssessmentEntity,
    // required this.localeName,
  });

  @override
  Widget build(Context context) {
    ProjectDetailsData auditReference = ProjectDetailsData(
      key: "Audit Reference",
      value: auditAssessmentEntity?.refName ?? "",
    );

    ProjectDetailsData dateEntity = ProjectDetailsData(
      key: "Date",
      value: auditAssessmentEntity?.date ?? "",
    );

    List<ProjectDetailsData> listAuditAnswerField =
        auditAssessmentEntity!.projectDetails;

    return Container(
      // padding: AuditPdfPaddings.projectDetailsSectionPadding,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 7,
      ),
      child: Column(
        children: [
          AuditProjectDetailsTableCell(
            fieldName: "${dateEntity.key} :",
            fieldValue: auditAssessmentEntity?.isSubscribed == 0
                ? "Upgrade to Unlock"
                // : dateEntity.value ?? "",
                : dateEntity.value ?? "",
            fieldValueTextStyle: auditAssessmentEntity?.isSubscribed == 0
                ? TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBoldItalic,
                    fontSize: 10,
                    color: AuditPdfColors.upgradeToUnlockColor,
                  )
                : null,
          ),
          Container(
            // height: 5,
            height: 4.5,
          ),
          AuditProjectDetailsTableCell(
            fieldName: "${auditReference.key}:",
            fieldValue: auditAssessmentEntity?.isSubscribed == 0
                ? "Upgrade to Unlock"
                : auditReference.value ?? "",
            fieldValueTextStyle: auditAssessmentEntity?.isSubscribed == 0
                // ? auditPdfTextStyles.notUpgradeTextStyle()
                ? TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBoldItalic,
                    fontSize: 10,
                    color: AuditPdfColors.upgradeToUnlockColor,
                  )
                : null,
          ),
          Container(
            height: 4.5,
          ),
          Column(
            children: returnAuditProjectDetialsTableCell(
              listAuditAnswerField: listAuditAnswerField,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> returnAuditProjectDetialsTableCell({
    required List<ProjectDetailsData> listAuditAnswerField,
  }) {
    List<Widget> listChildren = [];

    for (var auditAnswerField in listAuditAnswerField) {
      listChildren.add(AuditProjectDetailsTableCell(
        fieldName: "${auditAnswerField.key?.replaceAll(":", "")}:",
        fieldValue: auditAnswerField.value ?? "",
      ));
      if (auditAnswerField != listAuditAnswerField.last) {
        listChildren.add(
          Container(
            height: 5,
          ),
        );
      } else {
        listChildren.add(
          Container(
            height: 4,
          ),
        );
      }
    }
    return listChildren;
  }
}
