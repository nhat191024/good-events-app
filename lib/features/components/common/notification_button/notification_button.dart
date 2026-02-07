import 'package:sukientotapp/core/utils/import/global.dart';

class NotificationButton extends StatelessWidget {
  final bool hasNotification;
  const NotificationButton({super.key, this.hasNotification = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(color: context.fTheme.colors.muted, shape: BoxShape.circle),
        padding: const EdgeInsets.all(12),
        width: 50,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(FIcons.bell, color: context.primary),
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
