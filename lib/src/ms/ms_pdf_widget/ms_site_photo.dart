import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/audit/pdf_generator/audit_pdf_constants.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_pdf_custom_text.dart';
import 'package:pdf/widgets.dart';

class MsSitePhoto extends StatelessWidget {
  final MemoryImage? memoryImage;
  MsSitePhoto({
    required this.memoryImage,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: MsPdfCustomText(
            text: "Site Photo:",
            textStyle: TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: MsPdfColors.black,
              fontSize: 12,
            ),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
            // height: 400,
            width: 570 - 20,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    // maxWidth:  300
                    // maxHeight: 280,
                    maxHeight: 250),
                child: Image(
                  memoryImage!,
                  fit: BoxFit.contain,

                  // fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
