import 'package:dart_pdf_package/src/audit/dto/audit_answer_field_dto.dart';
import 'package:dart_pdf_package/src/audit/dto/audit_assessment_dto.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/widgets.dart';

import '../audit_pdf_constants.dart';
import 'audit_project_detials_table_cell.dart';

/// this widget is use to show the project details related to audit on pdf
class AuditProjectDetailSection extends StatelessWidget {
  final AuditAssessmentDto? auditAssessmentEntity;

  final String localeName;

  final auditPdfTextStyles = AuditPdfTextStyles();

  AuditProjectDetailSection({
    this.auditAssessmentEntity,
    required this.localeName,
  });

  @override
  Widget build(Context context) {
    AuditAnswerFieldDto auditReference = AuditAnswerFieldDto(
      name: "Audit Reference",
      value: auditAssessmentEntity?.refName,
    );

    AuditAnswerFieldDto dateEntity = AuditAnswerFieldDto(
      name: "Date",
      value: auditAssessmentEntity?.date,
    );

    List<AuditAnswerFieldDto> listAuditAnswerField =
        auditAssessmentEntity?.listAuditAnswerFieldDto ?? [];

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
            fieldName: "${dateEntity.name} :",
            fieldValue: auditAssessmentEntity?.isSubscribed == 0
                ? "Upgrade to Unlock"
                // : dateEntity.value ?? "",
                : TbPdfHelper.dateStringForLocaleInPdf(
                    date: dateEntity.value ?? ""),
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
            fieldName: "${auditReference.name}:",
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
            // heightid: 5.5,
            height: 4.5,
          ),
          Column(
            children: returnAuditProjectDetialsTableCell(
              listAuditAnswerField: listAuditAnswerField,
            ),
          ),
          // for (var auditAnswerField in listAuditAnswerField)
          //   AuditProjectDetailsTableCell(
          //     fieldName: "${auditAnswerField.name?.replaceAll(":", "")} :",
          //     fieldValue: auditAnswerField.value ?? "",
          //   ),
        ],
      ),
    );
  }

  List<Widget> returnAuditProjectDetialsTableCell({
    required List<AuditAnswerFieldDto> listAuditAnswerField,
  }) {
    List<Widget> listChildren = [];

    for (var auditAnswerField in listAuditAnswerField) {
      listChildren.add(AuditProjectDetailsTableCell(
        fieldName: "${auditAnswerField.name?.replaceAll(":", "")}:",
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
