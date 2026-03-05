import 'dart:ui';
import 'package:sukientotapp/core/utils/import/global.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white.withAlpha(128),
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBackground, 
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_back, color: AppColors.lightForeground),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'conversation'.tr,
                    style: const TextStyle(
                      color: AppColors.lightMutedForeground,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text(
                    'Stanley Cohen',
                    style: TextStyle(
                      color: AppColors.lightForeground,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/placeholder.png'),
          ),
        ],
      ),
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }
}
