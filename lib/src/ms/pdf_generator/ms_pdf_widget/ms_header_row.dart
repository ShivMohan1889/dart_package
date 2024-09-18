

import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_widget/ms_title_row.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

import '../../../audit/pdf_generator/audit_pdf_constants.dart';
import '../../dto/ms_assessment_dto.dart';
import '../tb_ms_pdf_constants.dart';

/// this widget is use to show  header   of the pdf
class MsHeaderRow extends StatelessWidget {
  /// holds the ms assessment entity
  final MsAssessmentDto? msAssessmentDto;

  /// holds the pages number
  final int? pagesNo;

  final MemoryImage? companyLogo;
  final String localeName;

  MsHeaderRow({
    this.msAssessmentDto,
    this.pagesNo,
    this.companyLogo,
    required this.localeName,
  });

  @override
  Widget build(Context context) {
    return Container(
      child: Column(
        children: [
          Container(
              width: TbMsPdfWidth.pageWidth,
              color: MsPdfColors.white,
              height: MsPdfHeights.blankSpaceContainerHeight,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    companyLogo != null
                        ? Container(
                            margin: const  EdgeInsets.only(right: 20),
                            // color: RaPdfColors.black,
                            height: 80,
                            width: 80,
                            child: Image(
                              companyLogo!,
                              height: 60,
                              width: 80,
                            ),
                          )
                        : Container()
                  ])),
          MsTitleRow(
            localeName: localeName,
            msAssessmentDto: msAssessmentDto,
            pageNumber: pagesNo,
          ),
        ],
      ),
    );
  }
}
