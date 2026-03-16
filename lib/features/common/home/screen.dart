import 'package:sukientotapp/features/common/home/controller.dart';
import 'package:sukientotapp/features/common/home/widget/user_switch.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/components/button/plus.dart';

import 'package:sukientotapp/features/common/home/widget/guest_intro_card.dart';
import 'package:sukientotapp/features/client/home/widgets/blogs_panel.dart';
import 'package:sukientotapp/features/client/home/widgets/fake_search_bar.dart';
import 'package:sukientotapp/features/client/home/widgets/popup_search_sheet.dart';

class GuestHomeScreen extends GetView<GuestHomeController> {
  const GuestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchController = TextEditingController();

    return FScaffold(
      header: Obx(
        () => Container(
          padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: controller.userType.value
                  ? [Colors.yellow[800]!, Colors.yellow[500]!]
                  : [Colors.red[900]!, Colors.red[500]!],
            ),
          ),
          child: Column(
            children: [
              //first row: title and user switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.userType.value ? 'customer'.tr : 'partner'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      UserRoleSwitch(
                        rxValue: controller.userType,
                        activeBackgroundColor: Colors.yellow[900]!,
                        inactiveBackgroundColor: Colors.red[900]!,
                        activeImageWidget: Icon(
                          Icons.person_rounded,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 22,
                        ),
                        inactiveImageWidget: Icon(
                          Icons.business_center_rounded,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              //second row: CTA register
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //CTA register
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.4,
                        child: Text(
                          'dont_have_account'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: Text(
                          controller.userType.value
                              ? 'partner_register_now'.tr
                              : 'customer_register_now'.tr,
                          softWrap: true,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Image.asset(AppImages.placeHolder, width: 80),
                ],
              ),
            ],
          ),
        ),
      ),
      footer: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonPlus(
                  btnText: 'register'.tr,
                  onTap: () => Get.toNamed(Routes.registerScreen),
                  width: Get.width * 0.4,
                  color: Colors.white,
                  textColor: controller.userType.value ? AppColors.amber500 : AppColors.primary,
                  borderColor: controller.userType.value ? AppColors.amber500 : AppColors.primary,
                ),
                CustomButtonPlus(
                  btnText: 'login'.tr,
                  onTap: () => Get.toNamed(Routes.loginScreen),
                  width: Get.width * 0.4,
                  color: controller.userType.value ? AppColors.amber500 : AppColors.primary,
                  borderColor: controller.userType.value ? AppColors.amber500 : AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => controller.userType.value
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: FakeSearchBar(
                        onTap: () {
                          searchController.clear();
                          controller.ensurePartnersLoaded();
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => PopupPartnerSearchSheet(
                              partnerCategories: controller.partnerList,
                              isLoadingPartners: controller.isLoadingPartners,
                            ),
                            isScrollControlled: true,
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: GuestIntroCard(),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'news_and_blogs'.tr,
                    style: context.typography.lg.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              if (controller.isLoadingBlogs.value && controller.blogs.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (controller.blogs.isEmpty) {
                return SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'no_blogs'.tr,
                      style: context.typography.sm.copyWith(color: Colors.grey),
                    ),
                  ),
                );
              }

              return ClientBlogPanel(blogs: controller.blogs);
            }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
