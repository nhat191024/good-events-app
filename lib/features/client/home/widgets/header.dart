import 'package:flutter_animate/flutter_animate.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/home/controller.dart';
import 'package:sukientotapp/features/components/common/language_switch/language_switch.dart';
import 'package:sukientotapp/features/components/common/notification_button/notification_button.dart';

class ClientHomeHeader extends StatelessWidget {
  const ClientHomeHeader({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    ).animate(delay: 600.ms).slideY(begin: -1, end: 0, duration: 500.ms);
  }
}
