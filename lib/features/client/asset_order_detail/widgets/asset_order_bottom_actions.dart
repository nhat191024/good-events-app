import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';

class AssetOrderBottomActions extends GetView<ClientAssetOrderDetailController> {
  const AssetOrderBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (controller.canRepay)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh),
                  label: Text('repay'.tr),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: FTheme.of(context).colors.primary,
                    side: BorderSide(color: FTheme.of(context).colors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            if (controller.canRepay) const SizedBox(width: 12),
            if (controller.canDownload)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: trigger ZIP download via URL launcher
                    Get.snackbar(
                      'download'.tr,
                      'download_starting'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green[100],
                      colorText: Colors.green[900],
                      duration: const Duration(seconds: 3),
                    );
                  },
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: Text(
                    'download_zip'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FTheme.of(context).colors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            if (!controller.canDownload && !controller.canRepay)
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[800],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('back_to_list'.tr),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
