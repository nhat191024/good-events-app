import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class NotificationButton extends StatefulWidget {
class NotificationButton extends StatefulWidget {
  final bool hasNotification;
  final VoidCallback? onTap;
  const NotificationButton({super.key, this.hasNotification = false, this.onTap});

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  final VoidCallback? onTap;
  const NotificationButton({super.key, this.hasNotification = false, this.onTap});

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // trigger animation
        _controller?.forward().then((_) => _controller?.reverse());
        widget.onTap?.call();
      },
      child:
          Container(
                decoration: BoxDecoration(
                  color: context.fTheme.colors.muted,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    widget.hasNotification
                        ? Icon(FIcons.bell, color: context.primary)
                              .animate(onPlay: (controller) => controller.repeat(reverse: true))
                              .shake(rotation: 0.3, hz: 2)
                        : Icon(FIcons.bell, color: context.primary),
                    if (widget.hasNotification)
                      Positioned(
                        top: 5,
                        right: 4,
                        child: CircleAvatar(backgroundColor: Colors.red[900], radius: 4),
                      ),
                  ],
                ),
              )
              .animate(autoPlay: false, onInit: (controller) => _controller = controller)
              .scaleXY(end: 0.85, duration: 100.ms, curve: Curves.easeInOut),
    );
  }
}
