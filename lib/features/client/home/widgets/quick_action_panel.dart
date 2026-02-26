// this will import the QuickActionPanel with a warpper ClientQuickActionPanel

import 'package:flutter_animate/flutter_animate.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class ClientQuickActionPanel extends StatelessWidget {
  const ClientQuickActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: _QuickActionPanel(
        items: [
          _QuickActionItem(
            icon: FIcons.accessibility,
            label: 'partner'.tr,
            animationDelayMs: 700,
            onPress: () {},
          ),
          _QuickActionItem(
            icon: FIcons.speaker,
            label: 'rent_product'.tr,
            animationDelayMs: 720,
            onPress: () {},
          ),
          _QuickActionItem(
            icon: FIcons.bookImage,
            label: 'file_product'.tr,
            animationDelayMs: 740,
            onPress: () {},
          ),
          _QuickActionItem(
            icon: FIcons.bookOpenText,
            label: 'news_and_blogs'.tr,
            animationDelayMs: 760,
            onPress: () {},
          ),
        ],
      ),
    );
  }
}

class _QuickActionPanel extends StatelessWidget {
  const _QuickActionPanel({super.key, required this.items});

  final List<_QuickActionItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map(
                  (item) => _buildButtonItem(
                    context,
                    item.icon,
                    item.label,
                    item.onPress,
                    item.animationDelayMs,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  FTappable _buildButtonItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPress,
    int animationDelayMs,
  ) {
    return FTappable(
      onPress: () => onPress(),
      child: SizedBox(
        width: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: FTheme.of(context).colors.primary, size: 24),
            ),
            SizedBox(height: 4),
            Text(
              label.tr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ).animate(delay: animationDelayMs.ms).fadeIn(duration: 200.ms),
    );
  }
}

class _QuickActionItem {
  final IconData icon;
  final String label;
  final VoidCallback onPress;
  final int animationDelayMs;

  _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onPress,
    required this.animationDelayMs,
  });
}
