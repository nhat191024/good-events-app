import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:dio_log/dio_log.dart';

class DevOverlay extends StatefulWidget {
  final Widget child;

  const DevOverlay({super.key, required this.child});

  @override
  State<DevOverlay> createState() => _DevOverlayState();
}

class _DevOverlayState extends State<DevOverlay> {
  Offset _offset = const Offset(20, 100);

  @override
  Widget build(BuildContext context) {
    // Chỉ hiển thị trong debug mode
    if (!kDebugMode) return widget.child;

    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        widget.child,
        Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                final size = MediaQuery.of(context).size;
                double dx = _offset.dx + details.delta.dx;
                double dy = _offset.dy + details.delta.dy;

                // Giới hạn trong màn hình
                dx = dx.clamp(0.0, size.width - 56);
                dy = dy.clamp(0.0, size.height - 56);

                _offset = Offset(dx, dy);
              });
            },
            onTap: () {
              _showDevMenu();
            },
            child: Material(
              elevation: 4,
              shape: const CircleBorder(),
              color: Colors.transparent,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: FTheme.of(context).colors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(Icons.bug_report, color: FTheme.of(context).colors.primaryForeground),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDevMenu() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FTheme.of(context).colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dev Tools",
              style: FTheme.of(context).typography.xl2.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              icon: Icons.palette_outlined,
              title: "Toggle Theme",
              onTap: () {
                if (Get.isDarkMode) {
                  Get.changeThemeMode(ThemeMode.light);
                } else {
                  Get.changeThemeMode(ThemeMode.dark);
                }
                Get.back();
              },
            ),
            _buildMenuItem(
              icon: Icons.delete_outline,
              title: "Clear Local Storage",
              onTap: () async {
                StorageService.clearAllData();
                Get.snackbar("Success", "Storage cleared");
                Get.back();
              },
            ),
            _buildMenuItem(
              icon: Icons.wifi_tethering_outlined,
              title: "Dio Log",
              onTap: () {
                Get.back();
                Get.to(() => HttpLogListWidget());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: FTheme.of(context).colors.foreground),
      title: Text(
        title,
        style: FTheme.of(
          context,
        ).typography.base.copyWith(color: FTheme.of(context).colors.foreground),
      ),
      onTap: onTap,
    );
  }
}
