import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/widgets.dart';

class TbIncidentReportPdfImageItem extends StatelessWidget {
  final MemoryImage? image;

  TbIncidentReportPdfImageItem({this.image});

  @override
  Widget build(Context context) {
    return Container(
      height: 176,
      width: 255,
      decoration: BoxDecoration(
        color: TbIncidentReportPdfColor.incidentReportImageBackGroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
        //
      ),
      child: Center(
        child: image == null
            ? Container()
            : Image(
                image!,
              ),
      ),
    );
  }
}
