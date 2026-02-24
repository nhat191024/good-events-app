import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

import 'widget/wallet_header.dart';

import 'package:sukientotapp/features/components/common/language_switch/language_switch.dart';
import 'package:sukientotapp/features/components/common/notification_button/notification_button.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          FScaffold(
            childPad: false,
            resizeToAvoidBottomInset: false,
            header: Container(
              padding: EdgeInsets.only(top: context.statusBarHeight, left: 16, right: 16),
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
                          FBadge(
                            child: Text(
                              'verified'.tr,
                              style: context.typography.xs.copyWith(
                                color: context.fTheme.colors.primaryForeground,
                              ),
                            ),
                          ),
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
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullDown: true,
              enablePullUp: false,
              header: const ClassicHeader(),
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoadMore,
              child: Stack(
                children: [
                  WalletHeader(controller: controller),
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: Get.width,
                          margin: EdgeInsets.only(top: 100),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Text(
                                    'general_setting'.tr,
                                    style: TextStyle(
                                      color: context.fTheme.colors.mutedForeground,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                _buildListItem(context, 'my_profile'.tr, FIcons.user, () {
                                  // Get.toNamed(Routes.profileScreen);
                                }),
                                _buildListItem(context, 'show_calendar'.tr, FIcons.calendar1, () {
                                  // Get.toNamed(Routes.profileScreen);
                                }),
                                _buildListItem(context, 'my_services'.tr, FIcons.briefcase, () {
                                  // Get.toNamed(Routes.profileScreen);
                                }),
                                _buildListItem(
                                  context,
                                  'revenue_statistics'.tr,
                                  FIcons.chartArea,
                                  () {
                                    // Get.toNamed(Routes.profileScreen);
                                  },
                                ),
                                _buildListItem(
                                  context,
                                  'change_password'.tr,
                                  FIcons.lockKeyholeOpen,
                                  () {},
                                ),
                                const Divider(color: AppColors.dividers, thickness: 1),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Text(
                                    'more_setting'.tr,
                                    style: TextStyle(
                                      color: context.fTheme.colors.mutedForeground,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                _buildListItem(context, 'notification_setting'.tr, FIcons.bell, () {
                                  // Get.toNamed(Routes.notificationsSettingScreen);
                                }),
                                _buildListItem(
                                  context,
                                  'message_setting'.tr,
                                  FIcons.messagesSquare,
                                  () {
                                    // Get.toNamed(Routes.messageSettingScreen);
                                  },
                                ),
                                _buildListItem(
                                  context,
                                  'support'.tr,
                                  FIcons.circleQuestionMark,
                                  () {
                                    // Get.toNamed(Routes.supportScreen);
                                  },
                                ),
                                _buildListItem(
                                  context,
                                  'report_problem'.tr,
                                  FIcons.flag,
                                  () {},
                                ),
                                _buildListItem(
                                  context,
                                  'privacy_policy'.tr,
                                  FIcons.shieldCheck,
                                  () {},
                                ),
                                const Divider(color: AppColors.dividers, thickness: 1),
                                _buildListItem(
                                  context,
                                  'logout'.tr,
                                  FIcons.logOut,
                                  iconColor: context.fTheme.colors.error,
                                  () {
                                    // Get.toNamed(Routes.logoutScreen);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Loading overlay
                  if (controller.isLoading.value)
                    Container(
                      color: Colors.black.withValues(alpha: 0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(context.fTheme.colors.primary),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDisabled = false,
    Color? iconColor,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              icon,
              color: isDisabled
                  ? context.fTheme.colors.muted
                  : (iconColor ?? context.fTheme.colors.foreground),
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isDisabled ? context.fTheme.colors.muted : context.fTheme.colors.foreground,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
