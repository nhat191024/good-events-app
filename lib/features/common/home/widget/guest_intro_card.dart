import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';

class GuestIntroCard extends GetView<GuestHomeController> {
  const GuestIntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 214, 81, 57), // primary-400 equivalent
            Color.fromARGB(255, 232, 115, 92), // primary-300 equivalent
            Color.fromARGB(255, 255, 115, 145), // pink-300
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3), // shadow-indigo-500/30
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Sukientot'.toUpperCase(),
          //   style: const TextStyle(
          //     fontSize: 14,
          //     fontWeight: FontWeight.w600,
          //     letterSpacing: 1.5,
          //     color: Color(0xCCFFFFFF), // white/80
          //   ),
          // ),
          const SizedBox(height: 8),
          const Text(
            'Đặt show biểu diễn chỉ với một cú nhấp',
            style: TextStyle(
              fontSize: 24, // 2xl
              fontWeight: FontWeight.bold,
              height: 1.375, // leading-snug
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tìm hiểu cách chúng tôi kết nối chú hề, MC, ảo thuật gia, workshop và mascot cho mọi sự kiện trong 30 giây.',
            style: TextStyle(
              fontSize: 14, // sm
              color: Color(0xE6FFFFFF), // white/90
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.registerScreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueGrey[900], // text-slate-900
                  elevation: 1, // shadow-sm
                  shadowColor: Colors.black.withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // rounded-2xl
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // px-6 py-3
                  textStyle: const TextStyle(
                    fontSize: 16, // text-base
                    fontWeight: FontWeight.w600, // font-semibold
                  ),
                ),
                child: Obx(
                  () => Text(controller.userType.value ? 'register_now'.tr : 'become_partner'.tr),
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.loginScreen),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 16, // text-base
                    fontWeight: FontWeight.w600, // font-semibold
                  ),
                ),
                child: Text('login'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
