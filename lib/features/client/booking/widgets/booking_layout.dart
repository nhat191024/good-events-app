import 'package:sukientotapp/core/utils/import/global.dart';

class BookingTwoColumnRow extends StatelessWidget {
  const BookingTwoColumnRow({
    super.key,
    required this.left,
    required this.right,
    this.spacing = 10,
  });

  final Widget left;
  final Widget right;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 600;
        if (isWide) {
          return Row(
            children: [
              Expanded(child: left),
              SizedBox(width: spacing),
              Expanded(child: right),
            ],
          );
        }
        return Column(
          children: [
            left,
            SizedBox(height: spacing),
            right,
          ],
        );
      },
    );
  }
}
