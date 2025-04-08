import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/audit/audit_pdf_constants.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_pdf_custom_text.dart';
import 'package:pdf/widgets.dart';

class MsAssessmentImageRow extends StatelessWidget {
  final List<Widget> listChildren;
  final String? text;

  MsAssessmentImageRow({
    required this.listChildren,
    this.text,
  });

  @override
  Widget build(Context context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10,
            // bottom: 10,
          ),
          // color: PdfColors.amber,
          // padding: MsPdfPaddings.paddingForMsHeaderEntityHeaderLevelNotZero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (text ?? '').isNotEmpty
                  ? MsPdfCustomText(
                      text: text,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),

                      // padding: MsPdfPaddings.paddingForMsheaderEntity,
                      textStyle: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.fontBold,
                        color: MsPdfColors.black,
                        // fontSize: 12,
                        fontSize: 13,
                      ),
                    )
                  : Container(),
              (text ?? '').isNotEmpty
                  ? Container(
                      height: 10,
                    )
                  : Container(),
              Container(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: listChildren,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
