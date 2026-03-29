import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/home/controller.dart';
import 'package:sukientotapp/features/components/common/language_switch/language_switch.dart';
import 'package:sukientotapp/features/components/common/notification_button/notification_button.dart';

class ClientHomeHeader extends StatelessWidget {
  const ClientHomeHeader({super.key, required this.controller});

  final ClientHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
                  ),
                  child: FAvatar(
                    image: NetworkImage(controller.avatar.value),
                    size: 44.0,
                    semanticsLabel: 'User avatar',
                    fallback: const Text('ST'),
                  ),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
              NotificationButton(
                hasNotification: controller.summary.value?.isHasNewNoti ?? false,
                onTap: () => Get.toNamed(Routes.notification),
              ),
            ],
          ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
        ],
      ),
    );
  }
}
