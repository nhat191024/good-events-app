import 'package:flutter_animate/flutter_animate.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class NotificationButton extends StatelessWidget {
  final bool hasNotification;
  final VoidCallback? onTap;
  const NotificationButton({super.key, this.hasNotification = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(color: context.fTheme.colors.muted, shape: BoxShape.circle),
        padding: const EdgeInsets.all(12),
        width: 50,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            hasNotification
                ? Icon(FIcons.bell, color: context.primary)
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .shake(rotation: 0.3, hz: 2)
                : Icon(FIcons.bell, color: context.primary),
            if (hasNotification)
              Positioned(
                top: 5,
                right: 4,
                child: CircleAvatar(backgroundColor: Colors.red[900], radius: 4),
              ),
          ],
        ),
      ),
    );
  }
}
