import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/home/home_controller.dart';

import 'package:sukientotapp/features/components/common/language_switch/language_switch.dart';
import 'package:sukientotapp/features/components/common/notification_button/notification_button.dart';

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
        padding: EdgeInsets.only(top: statusBarHeight),
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
            Row(children: [LanguageSwitch(), const SizedBox(width: 10), const NotificationButton(isHaveNoti: true)]),
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const IncomePanel(),
          const SizedBox(height: 16),
          const QickActionsPanel(),
          const SizedBox(height: 16),
          const BillCountPanel(),
          const SizedBox(height: 16),
          const NewReviewPanel(),
        ],
      ),
    );
  }
}
