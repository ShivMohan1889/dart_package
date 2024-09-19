
import 'package:dart_pdf_package/src/ra/dto/hazard_dto.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../utils/enums/enum/ra_pdf_title_type.dart';
import '../../../utils/utils.dart';
import '../../dto/risk_assessment_dto.dart';
import 'ra_company_details_row.dart';
import 'ra_logo_row.dart';

class AssessmentImageSection extends StatelessWidget {
  final MemoryImage image;
  final int? index;
  final RaPdfPageTitleType raPdfPageTitleType;
  final int? isSelected;
  final MemoryImage? logoImage;

  final RiskAssessmentDto riskAssessmentEntity;

  double height = 400;
  double width = 570;
  double numberRowSize = 30;
  AssessmentImageSection({
    this.isSelected,
    required this.image,
    required this.riskAssessmentEntity,
    this.index,
    required this.raPdfPageTitleType,
    this.logoImage,
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
            riskAssessmentEntity: riskAssessmentEntity,
            index: index,
            pageTitleType: raPdfPageTitleType,
          ),
          RaCompanyDetailsRow(riskAssessmentEntity: riskAssessmentEntity),
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
    List<HazardDto > listHazards = (riskAssessmentEntity.listHazards ??  []);
    List<Widget> listWidget = [];
    for (var i = 0; i < 13 * 8; i++) {
      var identifier = Utils.hazardGridCellIdentifier(i);

      List<HazardDto> filtered = listHazards
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
        HazardDto entity = filtered.first;
        MemoryImage? iconImage = entity.memoryImage;
        Widget w = Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.25,
              color: PdfColors.black,
            ),
            color: PdfColors.grey300,
          ),
          child: Stack(children: [
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
                  child: Text((entity.cellRiskNumber ?? 0).toString(),
                      style: const TextStyle(color: PdfColors.white)),
                ),
              ),
            ),
          ]),
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
