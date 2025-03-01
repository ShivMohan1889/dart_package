import 'package:pdf/widgets.dart';

/// this widget is used to show icon image and icon name
class MsStatementHazardIconItem extends StatelessWidget {
  /// holds the ms statement hazard icon image
  final MemoryImage iconImage;

  MsStatementHazardIconItem({
    required this.iconImage,
  });
  @override
  Widget build(Context context) {
    // return Container(
    //   // color: PdfColors.red,
    //   // padding: const EdgeInsets.only(
    //   //   left: 10,
    //   //   right: 10,
    //   // ),
    //   color: PdfColors.amber,
    //   margin: const EdgeInsets.all(5),
    //   child: Center(
    //     child: Image(
    //       iconImage,
    //       height: 90,
    //       width: 90,
    //     ),
    //   ),
    // );

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            alignment: Alignment.center,
            iconImage,
            height: 90,
            width: 80,

            // height: 90,
            // width: 100,
          ),
          Container(
            width: 10,
          ),
        ],
      ),
    );
  }
}
