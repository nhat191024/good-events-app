import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import 'package:sukientotapp/features/client/partner_detail/controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerActionButtons extends StatelessWidget {
  const PartnerActionButtons({super.key});

  void _showContactModal(BuildContext context) {
    final settings = StorageService.readMapData(key: LocalStorageKeys.settings);
    final hotline = (settings?['hotline'] as String?) ?? '';
    final zalo = (settings?['zalo'] as String?) ?? '';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'support'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'contact_via'.tr,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              if (hotline.isNotEmpty)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.red600.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      FIcons.phoneCall,
                      color: AppColors.red600,
                      size: 22,
                    ),
                  ),
                  title: Text(
                    'call_hotline'.tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(hotline),
                  onTap: () async {
                    Navigator.pop(context);
                    final uri = Uri(scheme: 'tel', path: hotline);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                ),
              if (hotline.isNotEmpty && zalo.isNotEmpty)
                const Divider(height: 1),
              if (zalo.isNotEmpty)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0068FF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      FIcons.messageCircleReply,
                      color: Color(0xFF0068FF),
                      size: 22,
                    ),
                  ),
                  title: Text(
                    'open_zalo'.tr,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(zalo),
                  onTap: () async {
                    Navigator.pop(context);
                    final uri = Uri.parse('https://zalo.me/$zalo');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                ),
              if (hotline.isEmpty && zalo.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('no_contact_info'.tr),
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

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
                onTap: () => _showContactModal(context),
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
                  if (StorageService.readData(key: LocalStorageKeys.token) ==
                      null) {
                    Get.snackbar('info'.tr, 'login_required'.tr);
                    Get.offAllNamed(Routes.guestHomeScreen);
                    return;
                  }

                  final catIdStr =
                      Get.find<PartnerDetailController>().partnerId.value;
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
