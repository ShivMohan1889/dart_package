import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ra/ra_pdf_data.dart';
import 'package:dart_pdf_package/src/ra/tb_ra_pdf_constants.dart';
import 'package:pdf/widgets.dart';

class RaProjectRow extends StatelessWidget {
  final RaPdfData pdfData;
  final raPdfTextStyles = TbRaPdfTextStyles();

  final TbPdfHelper pdfHelper;

  /// height of the checkbox images
  final double checkBoxSize = 9;

  /// space between checkbox and text
  final double checkboxPadding = 5;

  /// space between multiple checkboxes vertically
  final double verticalPaddingBetweenFurtherAssessmentRows = 3.5;

  /// Padding of further assessment block and others
  final double paddingOfFurtherAssessmentRequiredBlock = 4;

  RaProjectRow({
    required this.pdfData,
    required this.pdfHelper,
  });

  @override
  Widget build(Context context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Container(
        height: TbRaPdfSectionHeights.PROJECT_DETAILS,
        width: double.infinity,
        child: Row(
          children: [
            projectDetils(
              context: context,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    checkBoxContainer(
                      context: context,
                    ),
                    Container(
                      height: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Row(
                        children: [
                          Text(
                            "Work Start Date: ",
                            // style: raPdfTextStyles.hazardTableHeading(),
                            style: TbPdfHelper().textStyleGenerator(
                              font: Theme.of(context).header0.fontBold,
                              color: TbRaPdfColors.black,
                              fontSize: 9,
                            ),
                          ),
                          Text(
                            pdfData.isSubscribed == 0
                                ? "Upgrade to Unlock"
                                : pdfData.workStartDate ?? "",

                            style: pdfData.isSubscribed == 0
                                // ? raPdfTextStyles.notUpgradeTextStyle()
                                ? TbPdfHelper().textStyleGenerator(
                                    font: Theme.of(context).header0.font,
                                    color: TbRaPdfColors.upgradeToUnlockColor,
                                    fontSize: 9,
                                  )
                                : TbPdfHelper().textStyleGenerator(
                                    font: Theme.of(context).header0.font,
                                    color: TbRaPdfColors.black,
                                    fontSize: 9,
                                  ),

                            // : raPdfTextStyles.normalBlack9(),
                          ),
                          SizedBox(width: 170.0),
                          Text(
                            "Est Completion Date: ",
                            // style: raPdfTextStyles.hazardTableHeading(),
                            style: TbPdfHelper().textStyleGenerator(
                              font: Theme.of(context).header0.fontBold,
                              color: TbRaPdfColors.black,
                              fontSize: 9,
                            ),
                          ),
                          Text(
                            pdfData.workEndDate ?? "",

                            // style: raPdfTextStyles.normalBlack9(),
                            style: TbPdfHelper().textStyleGenerator(
                              font: Theme.of(context).header0.font,
                              color: TbRaPdfColors.black,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                    keyStaff(
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ************************************** */
  // PROJECT DETAILS
  /// draw project name and project description
  /* ************************************** */
  Widget projectDetils({
    required Context context,
  }) {
    print("${pdfData.name}");
    return Container(
      width: 245,
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      decoration: TbRaPdfBoxDecorations.borderBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
            height: 13,
            child: Text(
              "Project Name:",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 9,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
            height: 27,
            child: Text(
              pdfData.isSubscribed == 0
                  ? "Upgrade to Unlock"
                  : pdfData.name ?? "",

              style: pdfData.isSubscribed == 0
                  // ? raPdfTextStyles.notUpgradeTextStyle()
                  // : raPdfTextStyles.normalBlack9(),
                  ? TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.upgradeToUnlockColor,
                      fontSize: 9,
                    )
                  : TbPdfHelper().textStyleGenerator(
                      font: Theme.of(context).header0.font,
                      color: TbRaPdfColors.black,
                      fontSize: 9,
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
            height: 13,
            child: Text(
              "Description of Work:",
              // style: raPdfTextStyles.hazardTableHeading(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 9,
              ),
            ),
          ),
          Container(
            // color: PdfColors.amber,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
            // height:   50,
            height: 120,

            child: Text(
              pdfData.description ?? "",
              // style: raPdfTextStyles.normalBlack9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.black,
                // fontSize: 9,
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ************************************** */
  // FURTHER ASSESSMENT DETAILS
  /// draw further assessment details in the header part
  /* ************************************** */
  Widget checkBoxContainer({
    required Context context,
  }) {

    return Container(
      height: 93,
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      decoration: TbRaPdfBoxDecorations.boxDecorationKeyStaff,
      child: Row(
        children: [
          Expanded(
              child: furtherAssessmentRequired(
            context: context,
          )),
          Expanded(
              child: personsInvolved(
            context: context,
          )),
          Expanded(
              child: individualAssessmentRequired(
            context: context,
          ))
        ],
      ),
    );
  }

  Widget furtherAssessmentRequired({
    required Context context,
  }) {
    return Container(
      padding: EdgeInsets.all(paddingOfFurtherAssessmentRequiredBlock),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Further assessments required:",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 9,
            ),
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Fire",
            isChecked: pdfData.fire ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "COSHH / OSHA",
            isChecked: pdfData.coshh ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Manual Handling",
            isChecked: pdfData.manualHandling ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Display Handling",
            isChecked: pdfData.displayHandling ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Young Persons",
            isChecked: pdfData.youngPerson ?? 0,
          ),
        ],
      ),
    );
  }

  Widget personsInvolved({
    required Context context,
  }) {
    return Container(
      padding: EdgeInsets.all(paddingOfFurtherAssessmentRequiredBlock),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Persons involved in or affected:",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 9,
            ),
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Employees (Emp)",
            isChecked: pdfData.employees ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Visitors (Vis)",
            isChecked: pdfData.visitors ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Contractors (Con)",
            isChecked: pdfData.contractors ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Members of public (MoP)",
            isChecked: pdfData.membersOfPublic ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Others",
            isChecked: pdfData.others ?? 0,
          ),
        ],
      ),
    );
  }

  Widget individualAssessmentRequired({
    required Context context,
  }) {
    return Container(
      padding: EdgeInsets.all(paddingOfFurtherAssessmentRequiredBlock),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Individual Assessment req'd for:",
            // style: raPdfTextStyles.hazardTableHeading(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 9,
            ),
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Nursing and Expectant Mums (NeM)",
            isChecked: pdfData.nursingExpectantMums ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Young persons (YoP)",
            isChecked: pdfData.youngPerson2 ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Disabled (Dis)",
            isChecked: pdfData.disabled ?? 0,
          ),
          seperator(),
          checkBox(
            context: context,
            text: "Service Users (SeU)",
            isChecked: pdfData.serviceUsers ?? 0,
          ),
        ],
      ),
    );
  }

  Widget seperator() {
    return Container(
      height: verticalPaddingBetweenFurtherAssessmentRows,
      width: verticalPaddingBetweenFurtherAssessmentRows,
    );
  }

  Widget checkBox({
    required String text,
    required int isChecked,
    required Context context,
  }) {
    return Container(
      child: Row(
        children: [
          (isChecked == 1)
              ? Image(pdfHelper.checkImage,
                  height: checkBoxSize, width: checkBoxSize)
              : Image(pdfHelper.uncheckImage,
                  height: checkBoxSize, width: checkBoxSize),
          Container(
            height: checkboxPadding,
            width: checkboxPadding,
          ),
          Text(
            text,
            // style: raPdfTextStyles.normalBlack9(),
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.font,
              color: TbRaPdfColors.black,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  /* ************************************** */
  // KEY STAFF
  /// draw key staff section
  /* ************************************** */
  Widget keyStaff({
    required Context context,
  }) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      decoration: TbRaPdfBoxDecorations.boxDecorationKeyStaff,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Key People / Groups in area",
            style: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbRaPdfColors.black,
              fontSize: 9,
            ),
          ),
          SizedBox(height: 5.0),
          keyStaffName(
            start: 1,
            end: 3,
            context: context,
          ),
          SizedBox(height: 8.0),
          keyStaffName(
            start: 4,
            end: 6,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget keyStaffName({
    required int start,
    required int end,
    required Context context,
  }) {
    List<Widget> children = [];
    for (int i = start; i <= end; i++) {
      if ((pdfData.keyStaff ??  []).length >= i) {
        String entity = (pdfData.keyStaff ??  [])[i - 1];

        children.add(Expanded(
          child: Row(
            children: [
              Text(
                "$i. ",
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  color: TbRaPdfColors.black,
                  fontSize: 10,
                ),
              ),
              Text(
                entity,
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.font,
                  color: TbRaPdfColors.black,
                  fontSize: 9,
                ),
              ),
              Spacer(),
            ],
          ),
        ));
      } else {
        children.add(Expanded(
          child: Row(
            children: [
              Text(
                "$i. ",
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  color: TbRaPdfColors.black,
                  fontSize: 10,
                ),
              ),
              Spacer(),
            ],
          ),
        ));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
