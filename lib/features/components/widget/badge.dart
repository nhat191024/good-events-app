import 'package:sukientotapp/core/utils/import/global.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key, required this.text, this.backgroundColor, this.textColor});

  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.fTheme.colors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: context.typography.xs.copyWith(
          color: textColor ?? context.fTheme.colors.foreground,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
