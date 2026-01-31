import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/home/home_controller.dart';

import 'package:sukientotapp/features/components/common/language_switch/language_switch.dart';
import 'package:sukientotapp/features/components/common/notification_button/notification_button.dart';

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
              children: [
                FAvatar(
                  image: NetworkImage(controller.avatar.value),
                  size: 40.0,
                  semanticsLabel: 'User avatar',
                  fallback: const Text('ST'),
                ),
                const SizedBox(width: 10),
                Text(
                  controller.name.value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(children: [LanguageSwitch(), NotificationButton(isHaveNoti: true,)]),
          ],
        ),
      ),
      child: Center(
        child: Text('partner_home'.tr),
      ),
    );
  }
}
