import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/message/controller.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white.withAlpha(128),
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.lightForeground,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Obx(() {
                final thread =
                    Get.find<MessageController>().selectedThread.value;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thread!.subject,
                      style: const TextStyle(
                        color: AppColors.lightForeground,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${'bill_info'.tr}: ',
                      style: const TextStyle(
                        color: AppColors.lightMutedForeground,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${'event'.tr}: ${thread.bill.eventName}',
                      style: const TextStyle(
                        color: AppColors.lightMutedForeground,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${'time'.tr}: ${thread.bill.datetime}',
                      style: const TextStyle(
                        color: AppColors.lightMutedForeground,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        '${'address'.tr}: ${thread.bill.address}',
                        style: const TextStyle(
                          color: AppColors.lightMutedForeground,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
