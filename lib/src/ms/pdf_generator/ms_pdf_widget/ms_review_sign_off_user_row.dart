import 'package:pdf/widgets.dart';

class MsReviewSignOffUserRow extends StatelessWidget {
  final List<Widget> listOfSignOff;

  MsReviewSignOffUserRow({required this.listOfSignOff});
  @override
  Widget build(Context context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listOfSignOff,
    );
  }
}
