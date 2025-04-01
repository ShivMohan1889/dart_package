import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ms/ms_pdf_widget/ms_pdf_custom_text.dart';
import 'package:dart_pdf_package/src/ms/tb_ms_pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class HeaderRow extends StatelessWidget {
  final String? text;
  final TbHeaderRowModel? tbHeaderRowModel;
  int rowType;
  final PdfColor? color;
  final double? height;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final TextAlign? textAlign;
  HeaderRow({
    this.text,
    this.rowType = 0,
    this.height,
    this.padding,
    this.textAlign,
    this.textStyle,
    this.color,
    this.tbHeaderRowModel,
  });

  @override
  Widget build(Context context) {
    return MsPdfCustomText(
      text: tbHeaderRowModel?.headerName,
      padding: tbHeaderRowModel?.headerLevel == 0
          ? TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelZero
          : TbMsPdfPaddings.paddingForTbMsHeaderEntityHeaderLevelNotZero,
      textStyle: tbHeaderRowModel?.headerLevel == 0
          ? TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbMsPdfColors.black,
              fontSize: 12,
            )
          : TbPdfHelper().textStyleGenerator(
              font: Theme.of(context).header0.fontBold,
              color: TbMsPdfColors.black,
              fontSize: 11,
            ),
      rowType: 1,
    );
  }
}
