import 'package:sukientotapp/core/utils/import/global.dart';

class BookingOptionSheet extends StatelessWidget {
  const BookingOptionSheet({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelect,
    this.labelBuilder,
  });

  final String title;
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onSelect;
  final String Function(String value)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: context.typography.lg.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  FTappable(
                    onPress: () => Get.back(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: options.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: Colors.black.withValues(alpha: 0.08),
                ),
                itemBuilder: (context, index) {
                  final option = options[index];
                  final label = labelBuilder?.call(option) ?? option;
                  final bool isSelected = option == selectedValue;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    title: Text(label),
                    trailing: isSelected
                        ? Icon(Icons.check, color: context.fTheme.colors.primary)
                        : null,
                    onTap: () {
                      onSelect(option);
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
