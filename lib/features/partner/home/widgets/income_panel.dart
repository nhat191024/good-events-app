import 'package:sukientotapp/core/utils/import/global.dart';

class IncomePanel extends StatelessWidget {
  const IncomePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.fTheme.colors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.fTheme.colors.primaryForeground,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(FIcons.wallet, color: context.fTheme.colors.primary, size: 24),
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'wallet'.tr,
                          style: context.typography.sm.copyWith(
                            color: context.fTheme.colors.primaryForeground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '200k VND',
                          style: context.typography.lg.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.fTheme.colors.primaryForeground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'income'.tr,
                          style: context.typography.sm.copyWith(
                            color: context.fTheme.colors.primaryForeground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '200k VND',
                          style: context.typography.lg.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.fTheme.colors.primaryForeground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.fTheme.colors.primaryForeground,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        FIcons.chartColumnIncreasing,
                        color: context.fTheme.colors.primary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FTappable(
            onPress: () {},
            child: Container(
              width: double.infinity,
              height: 34,
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                color: context.fTheme.colors.foreground.withValues(alpha: 0.2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'view_details'.tr,
                    style: context.typography.sm.copyWith(
                      color: context.fTheme.colors.primaryForeground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(FIcons.arrowRight, color: context.fTheme.colors.primaryForeground, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
