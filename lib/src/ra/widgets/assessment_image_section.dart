import 'package:dart_pdf_package/src/ra/ra_pdf_data.dart';
import 'package:dart_pdf_package/src/ra/tb_ra_pdf_constants.dart';
import 'package:dart_pdf_package/src/utils/enums/ra_pdf_title_type.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../utils/utils.dart';
import 'ra_company_details_row.dart';
import 'ra_logo_row.dart';

class AssessmentImageSection extends StatelessWidget {
  final MemoryImage image;
  final int? index;
  final RaPdfPageTitleType raPdfPageTitleType;
  final int? isSelected;
  final MemoryImage? logoImage;
  final int? opacity;

  final RaPdfData pdfData;

  double height = 400;
  double width = 570;
  double numberRowSize = 30;
  AssessmentImageSection({
    this.isSelected,
    required this.image,
    required this.pdfData,
    this.index,
    required this.raPdfPageTitleType,
    this.logoImage,
    required this.opacity,
  });

  @override
  Widget build(Context context) {
    return Container(
      padding: const EdgeInsets.only(
          // top: 35,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaLogoRow(
            logoImage: logoImage,
            index: index,
            pageTitleType: raPdfPageTitleType,
          ),
          RaCompanyDetailsRow(
            companyDetails: pdfData.companyDetails,
            companyPhoneEmail: pdfData.companyPhoneEmail ?? "",
          ),
          Container(
            height: 35,
          ),
          Container(
            height: height,
            width: width,
            child: Center(
              child: renderDragDropScreen(),
            ),
          )
        ],
      ),
    );
  }

  Widget renderDragDropScreen() {
    if (isSelected == 0 || isSelected == null) {
      return Container(
        child: Image(
          image,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return _gridArea();
    }
  }

  Widget _gridArea() {
    return Container(
        height: height,
        width: width,
        child: Row(
          children: [
            _gridAlphabets(),
            Container(
              width: width - numberRowSize,
              height: height,
              child: Column(
                children: [
                  _gridNumbers(),
                  Stack(children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      child: Container(
                        height: height - numberRowSize,
                        width: width - numberRowSize,
                        child: Center(
                          child: Image(
                            image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    _createGridWithHazards(),
                  ])
                ],
              ),
            )
          ],
        ));
  }

  Container _createGridWithHazards() {
    List<HazardPdfModel> listHazards = (pdfData.hazards);
    List<Widget> listWidget = [];
    for (var i = 0; i < 13 * 8; i++) {
      var identifier = TbUtils.hazardGridCellIdentifier(i);

      List<HazardPdfModel> filtered = listHazards
          .where((element) => element.cellPosition == identifier)
          .toList();

      if (filtered.isEmpty) {
        Widget w = Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.25,
              color: PdfColors.white,
            ),
          ),
        );
        listWidget.add(w);
      } else {
        HazardPdfModel entity = filtered.first;
        MemoryImage? iconImage = entity.memoryImage;
        Widget w = Opacity(
          opacity: TbUtils.convertToOpacity(opacity ?? 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.25,
                color: PdfColors.black,
              ),
              // color: PdfColors.grey300,
              color: TbRaPdfColors.gridHazardBackground,
            ),
            child:
             Stack(children: [
              (iconImage != null)
                  ? Center(
                      child: Image(
                        iconImage,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Container(),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15 / 2),
                    color: PdfColors.black,
                  ),
                  height: 15,
                  width: 15,
                  child: Center(
                    child: Text(
                      (entity.cellRiskNumber ?? 0).toString(),
                      style: const TextStyle(
                        color: PdfColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );

        listWidget.add(w);
      }
    }

    return Container(
      height: height - numberRowSize,
      width: width - numberRowSize,
      child: GridView(
        crossAxisCount: 13,
        children: listWidget,
        childAspectRatio: (width - numberRowSize) / height,
      ),
    );
  }

  Widget _gridAlphabets() {
    List<Widget> arr = [];
    var c = Container(
      height: numberRowSize,
    );
    arr.add(c);
    for (var i = 1; i <= 8; i++) {
      String columnLetter = String.fromCharCode(64 + i);

      var widget = Container(
        decoration: BoxDecoration(
          border: Border(
            top: columnLetter == "A"
                ? const BorderSide(width: 0, color: PdfColors.amber)
                : const BorderSide(width: 0.25),
            bottom: columnLetter == "A"
                ? const BorderSide(width: 0)
                : const BorderSide(width: 0.25),
          ),
        ),
        height: (height - numberRowSize) / 8,
        child: Center(child: Text(columnLetter)),
      );
      arr.add(widget);
    }

    return Container(
      width: numberRowSize,
      height: height,
      color: PdfColors.amber,
      child: Column(
        children: arr,
      ),
    );
  }

  Container _gridNumbers() {
    List<Widget> arr = [];
    for (var i = 1; i <= 13; i++) {
      var widget = Container(
        decoration: BoxDecoration(
          border: Border(
            left: "$i" == "1"
                ? const BorderSide(width: 0.25, color: PdfColors.amber)
                : const BorderSide(width: 0.25),
            right: const BorderSide(width: 0.25),
          ),
        ),
        width: (width - numberRowSize) / 13,
        child: Center(child: Text("$i")),
      );
      arr.add(widget);
    }
    return Container(
      color: PdfColors.amber,
      width: width - numberRowSize,
      height: numberRowSize,
      child: Row(
        children: arr,
      ),
    );
  }
}
