import 'package:dart_pdf_package/src/ms/dto/ms_assessment_dto.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/tb_ms_pdf_constants.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import '../../../utils/pdf/tb_pdf_helper.dart';

class MsTitleRow extends StatelessWidget {
  final MsAssessmentDto? msAssessmentDto;

  final int? pageNumber;
  final String localeName;

  MsTitleRow({
    this.msAssessmentDto,
    this.pageNumber,
    required this.localeName,
  });

  @override
  Widget build(Context context) {
    String userName = [
      "${msAssessmentDto?.projectName}",
      "/",
      (TbPdfHelper.dateStringForLocaleInPdf(
          date: msAssessmentDto?.date ?? "", localeName: localeName))
    ].join("");

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 27,
            margin: TbMsPdfPaddings.marginForTbMsTitleRow,
            decoration: TbMsPdfBoxDecorations.boxDecorationForTbMsTitleRow,
            padding: TbMsPdfPaddings.paddingForTbMsTitleRow,
            child: Align(
              alignment: Alignment.topLeft,
              child:
                  Text(msAssessmentDto?.templateDto?.templateHeaderName ?? "",
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.fontBold,
                        color: TbMsPdfColors.white,
                        fontSize: 14,
                      )),
            ),
          ),
          (((msAssessmentDto?.raUniqueKey == null && (pageNumber ?? 0) > 1) ||
                  (msAssessmentDto?.raUniqueKey != null &&
                      (pageNumber ?? 0) > 2)))
              ? Container(
                  color: PdfColors.white,
                  margin:
                      TbMsPdfPaddings.marginForProjectNameAndDateInTbMsTitleRow,
                  child: Text(
                    msAssessmentDto?.isSubscribed == 0
                        ? "Upgrade to Unlock"
                        : userName,
                    style: msAssessmentDto?.isSubscribed == 0
                        // ? raPdfTextStyles.notUpgradeTextStyle()
                        ? TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.font,
                            fontSize: 9,
                            color: TbMsPdfColors.upgradeToUnlockColor,
                          )
                        : TbPdfHelper().textStyleGenerator(
                            font: Theme.of(context).header0.font,
                            color: TbMsPdfColors.msBlueThemeColor,
                            fontSize: 9,
                          ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
