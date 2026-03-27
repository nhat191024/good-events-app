import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/bottom_navigation/controller.dart';

class QickActionsPanel extends StatelessWidget {
  QickActionsPanel({super.key});

  final PartnerBottomNavigationController _navController =
      Get.find<PartnerBottomNavigationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(FIcons.zap, size: 13, color: AppColors.primary),
              const SizedBox(width: 5),
              Text(
                'quick_actions'.tr,
                style: context.typography.sm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.fTheme.colors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButtonItem(context, FIcons.calendars, 'calendar', () {
                Get.toNamed(Routes.partnerShowCalendar);
              }, const Color(0xFF3B82F6)),
              _buildButtonItem(context, FIcons.calendarPlus, 'take_order', () {
                _navController.setIndex(2);
              }, const Color(0xFF10B981)),
              _buildButtonItem(context, FIcons.calendarRange, 'waiting', () {
                _navController.setIndex(1, setTab: 0);
              }, const Color(0xFFF59E0B)),
              _buildButtonItem(context, FIcons.calendarCheck2, 'confirmed', () {
                _navController.setIndex(1, setTab: 1);
              }, const Color(0xFF8B5CF6)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onTap,
    Color color,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 62,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              label.tr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: context.typography.xs.copyWith(
                color: context.fTheme.colors.foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
