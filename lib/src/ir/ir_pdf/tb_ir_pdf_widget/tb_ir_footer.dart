import 'package:dart_pdf_package/src/audit/dto/company_dto.dart';
import 'package:pdf/widgets.dart';
import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/dto/incident_report_dto.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TbIrFooter extends StatelessWidget {
  final int pageNo;
  final CompanyDto? companyEntity;

  final IncidentReportDto? incidentReportEntity;
  final incidentReportPdfTextStyle = TbIncidentReportPdfTextStyle();

  TbIrFooter({
    required this.pageNo,
    required this.companyEntity,
    this.incidentReportEntity,
  });

  @override
  Widget build(Context context) {
    return Container(
      height: TbIrPdfDimension.footerHeight,
      padding: TbIrPadding.defaultPadding,
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 15,
                  // width: 19,
                  child: Text(getReferenceNumber(),
                      style: TbPdfHelper().textStyleGenerator(
                        font: Theme.of(context).header0.fontItalic,
                        color: TbIncidentReportPdfColor.black,
                        fontSize: 8,
                      )),
                ),
              ]),
          Container(
              width:
                  TbIrPdfDimension.pageWidth - TbIrPdfDimension.spaceUsedForPadding,
              height: 1,
              color: TbIncidentReportPdfColor.incidentReportThemeColor),
          Container(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pg  $pageNo',
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    fontSize: 11,
                  )),
              Text("${companyEntity?.name ?? ""} ",
                  // style: incidentReportPdfTextStyle
                  //     .incidentReportCompanyNameTextStyle(),
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    fontSize: 11,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  String getReferenceNumber() {
    if ((incidentReportEntity?.referenceNumber ?? "").isNotEmpty) {
      return "Ref No ${incidentReportEntity?.referenceNumber ?? ''} ";
    } else {
      return "";
    }
  }
}
