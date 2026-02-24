import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/bottom_navigation/controller.dart';

class QickActionsPanel extends StatelessWidget {
  QickActionsPanel({super.key});

  final PartnerBottomNavigationController _navController =
      Get.find<PartnerBottomNavigationController>();

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
            children: [
              _buildButtonItem(context, FIcons.calendars, 'calendar', null),
              _buildButtonItem(context, FIcons.calendarPlus, 'take_order', () {
                _navController.setIndex(2);
              }),
              _buildButtonItem(context, FIcons.calendarRange, 'waiting', () {
                _navController.setIndex(1, setTab: 0);
              }),
              _buildButtonItem(context, FIcons.calendarCheck2, 'confirmed', () {
                _navController.setIndex(1, setTab: 1);
              }),
            ],
          ),
        ],
      ),
    );
  }

  FTappable _buildButtonItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onTap,
  ) {
    return FTappable(
      onPress: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.fTheme.colors.muted,
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
              child: Icon(icon, color: context.fTheme.colors.primary, size: 24),
            ),
            SizedBox(height: 4),
            Text(
              label.tr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: context.typography.sm.copyWith(
                color: context.fTheme.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
