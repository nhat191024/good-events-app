import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import 'package:sukientotapp/features/client/partner_detail/controller.dart';

class PartnerActionButtons extends StatelessWidget {
  const PartnerActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.transparent),
      child: SafeArea(
        // Ensure buttons don't overlap with home indicator on iOS
        child: Row(
          children: [
            Expanded(
              child: CustomButtonPlus(
                onTap: () {
                  // TODO: Implement contact logic
                  Get.snackbar('support'.tr, 'in_dev'.tr);
                },
                btnText: 'support'.tr,
                color: Colors.white,
                textColor: AppColors.red600,
                borderColor: AppColors.red600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButtonPlus(
                onTap: () {
                  if (StorageService.readData(key: LocalStorageKeys.token) == null) {
                    Get.snackbar('info'.tr, 'login_required'.tr);
                    Get.offAllNamed(Routes.guestHomeScreen);
                    return;
                  }

                  final catIdStr = Get.find<PartnerDetailController>().partnerId.value;
                  final catId = int.tryParse(catIdStr);

                  Get.toNamed(
                    Routes.clientBooking,
                    arguments: catId != null ? {'category_id': catId} : null,
                  );
                },
                btnText: 'book_now'.tr,
                color: AppColors.red600, // Primary red
                textColor: Colors.white,
                borderColor: Colors.transparent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
