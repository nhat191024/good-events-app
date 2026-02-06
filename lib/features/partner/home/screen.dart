import 'package:fl_chart/fl_chart.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FAvatar(
                  image: NetworkImage(controller.avatar.value),
                  size: 46.0,
                  semanticsLabel: 'User avatar',
                  fallback: const Text('ST'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.name.value,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    FBadge(child: Text('verified'.tr)),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                LanguageSwitch(),
                const SizedBox(width: 10),
                const NotificationButton(hasNotification: true),
              ],
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const IncomePanel(),
              const SizedBox(height: 4),
              const QickActionsPanel(),
              const BillCountPanel(),
              const SizedBox(height: 8),
              const NewReviewPanel(),
              const SizedBox(height: 4),
              IncomeChart(
                spots: [FlSpot(0, 300000), FlSpot(1, 450000), FlSpot(2, 300000), FlSpot(3, 600000)],
                unit: '₫',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
