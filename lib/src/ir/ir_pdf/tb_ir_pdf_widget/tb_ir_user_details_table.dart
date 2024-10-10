
import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_contants.dart';
import 'package:dart_pdf_package/src/ir/ir_pdf/tb_ir_pdf_widget/tb_ir_table_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

/// this widget is used for the details like user or person or witness details
class TbIrUserDetailsTable extends StatelessWidget {
  /// heading of the section(table)
  String heading;
  String name;
  String jobTitle;
  String addressLine1;
  String addressLine2;
  String postcode;
  String email;
  String telephone;

  EdgeInsets? padding;

  final incidentReportTextStyle = TbIncidentReportPdfTextStyle();

  TbIrUserDetailsTable({
    required this.heading,
    required this.name,
    required this.jobTitle,
    required this.addressLine1,
    required this.addressLine2,
    required this.postcode,
    required this.email,
    required this.telephone,
    this.padding,
  });

  @override
  Widget build(Context context) {
    return Row(
      children: [
        Container(
          padding: padding ??
              // const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 0),
              TbIrPadding.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 19.8,
                width: TbIrPdfDimension.pageWidth -
                    TbIrPdfDimension.spaceUsedForPadding,
                decoration: BoxDecoration(
                  color: TbIncidentReportPdfColor.incidentReportThemeColor,
                  border: Border.all(
                    width: 1,
                    color: TbIncidentReportPdfColor.incidentReportThemeColor,
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 7,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  heading.toUpperCase(),
                  // style: incidentReportTextStyle
                  //     .incidentReportTextStyleWhiteNormal(),
                  style: TbPdfHelper().textStyleGenerator(
                    font: Theme.of(context).header0.font,
                    color: PdfColors.white,
                    fontSize: 10,
                  ),
                ),
              ),
              TbIrTableRow(
                firstTitle: "Name:",
                firstValue: " $name",
                secondTitle: "Job Title:",
                secondValue: " $jobTitle",
                // secondContainerWidth: 300,
                secondContainerWidth: TbIrPdfDimension.irUserNameHeadingWidth,
                valueWidth: TbIrPdfDimension.irUserNameValueWidth,
                secondContainerValueWidth: TbIrPdfDimension.irJobTitleWidth,
              ),
             TbIrTableRow(
                  firstTitle: "Address Line 1:",
                  firstValue: " $addressLine1",
                  // valueWidth: 300,
                  valueWidth: TbIrPdfDimension.irAddress1Width),
              TbIrTableRow(
                firstTitle: "Address Line 2:",
                firstValue: " $addressLine2",
                secondContainerValueWidth: TbIrPdfDimension.irAddress2Width,
                secondTitle: "Post Code:",
                secondValue: postcode,
                secondContainerWidth: TbIrPdfDimension.irPostCodeWidth,
                valueWidth: TbIrPdfDimension.irPostCodeValueWidth,
              ),
              TbIrTableRow(
                firstTitle: "Email:",
                firstValue: " $email",
                secondTitle: "Tel :",
                secondValue: " $telephone",
                secondContainerWidth: TbIrPdfDimension.irTelePhoneWidth,
                valueWidth: TbIrPdfDimension.irEmailValueWidth,
                secondContainerValueWidth: TbIrPdfDimension.irEmailWidth,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
