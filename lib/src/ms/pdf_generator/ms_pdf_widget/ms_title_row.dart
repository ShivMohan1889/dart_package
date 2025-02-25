import 'package:dart_pdf_package/src/ms/pdf_generator/ms_pdf_data.dart';
import 'package:dart_pdf_package/src/ms/pdf_generator/tb_ms_pdf_constants.dart';

import 'package:pdf/widgets.dart';

import '../../../utils/pdf/tb_pdf_helper.dart';

class MsTitleRow extends StatelessWidget {
  final MsPdfData? pdfData;

  final int? pageNumber;
  final String localeName;

  MsTitleRow({
    this.pdfData,
    this.pageNumber,
    required this.localeName,
  });

  @override
  Widget build(Context context) {
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
              child: Text(pdfData?.titleForPDF ?? "",
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.fontBold,
                    color: TbMsPdfColors.white,
                    fontSize: 14,
                  )),
            ),
          ),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }
}
