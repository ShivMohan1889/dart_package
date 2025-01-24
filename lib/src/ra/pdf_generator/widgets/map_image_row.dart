

import 'package:dart_pdf_package/src/ra/pdf_generator/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/pdf/tb_pdf_helper.dart';
import 'package:pdf/widgets.dart';

import '../../dto/risk_assessment_dto.dart';

/// creates heading of the hazards table
class MapImageRow extends StatelessWidget {
  final raPdfTextStyles = TbRaPdfTextStyles();
  final RiskAssessmentDto riskAssessmentEntity;
  final MemoryImage image;
  MapImageRow({
    required this.riskAssessmentEntity,
    required this.image,
  });

  @override
  Widget build(Context context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(children: [
        Row(children: [
          Container(
            width: 256,
            height: 20,
          ),
          SizedBox(width: 30 - 11),
          Container(
            width: 500,
            height: 20,
            // color: RaPdfColors.blue,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                riskAssessmentEntity.location ?? "",
                style: TbPdfHelper().textStyleGenerator(
                  font: Theme.of(context).header0.fontBold,
                  color: TbRaPdfColors.black,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ]),
        Container(
          height: TbRaPdfSectionHeights.PROJECT_DETAILS + 95,
          width: double.infinity,
          child: Row(
            children: [
              projectDetails(
                context: context,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 4),
              // ),

              SizedBox(width: 30),
              Container(
                width: TbRaPdfWidth.pageWidth - 245 - 30 - 30,
                decoration: TbRaPdfBoxDecorations.borderBoxDecoration,
                child: Center(
                  child: Image(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  /* ************************************** */
  // PROJECT DETAILS
  /// draw project name and project description
  /* ************************************** */
  Widget projectDetails({
    required Context context,
  }) {
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
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.fontBold,
                color: TbRaPdfColors.black,
                fontSize: 10,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
            height: 27,
            child: Text(
                riskAssessmentEntity.isSubscribed == 0
                    ? "Upgrade to Unlock"
                    : riskAssessmentEntity.name ?? "",
                style: riskAssessmentEntity.isSubscribed == 0
                    // ? raPdfTextStyles.notUpgradeTextStyle()
                    ? TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        fontSize: 9,
                        color: TbRaPdfColors.upgradeToUnlockColor,
                      )
                    : TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.font,
                        color: TbRaPdfColors.black,
                        fontSize: 9,
                      )
                // : raPdfTextStyles.normalBlack9(),
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
                fontSize: 10,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
            height: 27,
            child: Text(
              riskAssessmentEntity.description ?? "",
              // style: raPdfTextStyles.normalBlack9(),
              style: TbPdfHelper().textStyleGenerator(
                font: Theme.of(context).header0.font,
                color: TbRaPdfColors.black,
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
