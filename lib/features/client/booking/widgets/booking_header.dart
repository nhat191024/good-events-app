import 'package:sukientotapp/core/utils/import/global.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.typography.xl2.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: context.typography.base.copyWith(
            color: context.fTheme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
