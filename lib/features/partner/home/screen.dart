import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/home/controller.dart';

import 'package:sukientotapp/features/components/common/language_switch/language_switch.dart';
import 'package:sukientotapp/features/components/common/notification_button/notification_button.dart';
import 'package:sukientotapp/features/components/common/partner_chart/income_chart.dart';

import 'widgets/qick_actions_panel.dart';
import 'widgets/income_panel.dart';
import 'widgets/bill_count_panel.dart';
import 'widgets/new_review_panel.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return FScaffold(
      header: Container(
        padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FAvatar(
                    image: NetworkImage(controller.avatar.value),
                    size: 46.0,
                    semanticsLabel: 'User avatar',
                    fallback: const Text('ST'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.name.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FBadge(
                          child: Text(
                            'verified'.tr,
                            style: context.typography.xs.copyWith(
                              color: context.fTheme.colors.foreground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
            ),
            Row(
              children: [
                LanguageSwitch(),
                const SizedBox(width: 10),
                Obx(
                  () => NotificationButton(
                    hasNotification:
                        controller.dashboardData.value?.hasNotification ??
                        false,
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
          ],
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.dashboardData.value;
        if (data == null) {
          return Center(child: Text('no_data'.tr));
        }

        final revenueData = data.quarterlyRevenue;
        final revenueSpots = revenueData.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value.toDouble());
        }).toList();

        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IncomePanel(balance: data.balance, revenue: data.revenue)
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.1, end: 0),
                    QickActionsPanel()
                        .animate(delay: 100.ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.1, end: 0),
                    BillCountPanel(
                          newShows: data.showData.newShows,
                          waitingConfirmation:
                              data.showData.waitingConfirmation,
                        )
                        .animate(delay: 200.ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.1, end: 0),
                    NewReviewPanel(
                          recentReviewsCount: data.recentReviewsCount,
                          recentReviewsAvatars: data.recentReviewsAvatars,
                        )
                        .animate(delay: 300.ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.1, end: 0),
                    IncomeChart(
                          spots: revenueSpots.isNotEmpty
                              ? revenueSpots
                              : [
                                  FlSpot(0, 0),
                                  FlSpot(1, 0),
                                  FlSpot(2, 0),
                                  FlSpot(3, 0),
                                ],
                          unit: '₫',
                        )
                        .animate(delay: 400.ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
