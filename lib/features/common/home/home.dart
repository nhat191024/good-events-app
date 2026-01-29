import 'package:sukientotapp/features/common/home/home_controller.dart';
import 'package:sukientotapp/features/common/home/widget/user_switch.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/components/button/plus.dart';

class GuestHomeScreen extends GetView<GuestHomeController> {
  const GuestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double screenWidth = MediaQuery.of(context).size.width;

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
                  onTap: () {
                    Get.snackbar('notification'.tr, 'in_dev'.tr);
                  },
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
      child: Center(
        child: Text(
          'guest_home_welcome'.tr,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
