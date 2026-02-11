import 'package:sukientotapp/core/utils/import/global.dart';

class BookingSelectField extends StatelessWidget {
  const BookingSelectField({
    super.key,
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onTap,
    this.leading,
    this.trailing,
  });

  final String label;
  final String value;
  final String placeholder;
  final VoidCallback onTap;
  final IconData? leading;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.typography.sm.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        FTappable(
          onPress: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.fTheme.colors.border),
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  Icon(leading, size: 18, color: context.fTheme.colors.mutedForeground),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    hasValue ? value : placeholder,
                    style: context.typography.base.copyWith(
                      color: hasValue
                          ? context.fTheme.colors.foreground
                          : context.fTheme.colors.mutedForeground,
                    ),
                  ),
                ),
                Icon(
                  trailing ?? FIcons.chevronDown,
                  size: 18,
                  color: context.fTheme.colors.mutedForeground,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BookingTextField extends StatelessWidget {
  const BookingTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.typography.sm.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        FTextFormField(
          control: FTextFieldControl.managed(controller: controller),
          hint: hint,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
