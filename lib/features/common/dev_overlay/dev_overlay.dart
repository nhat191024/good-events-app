import 'package:sukientotapp/core/utils/import/global.dart';

// Local widgets
import 'widgets/toggle_theme_item.dart';
import 'widgets/clear_storage_item.dart';
import 'widgets/auth_actions_group.dart';
import 'widgets/open_http_log_item.dart';

/// A simple structure representing a dev menu item which may contain children.
class DevMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final List<DevMenuItem>? children;

  DevMenuItem({this.icon = Icons.circle, required this.title, this.onTap, this.children});
}

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
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dev Tools",
                  style: FTheme.of(context).typography.xl2.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const ToggleThemeItem(),
                const ClearStorageItem(),
                const AuthActionsGroup(),
                const OpenHttpLogItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
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

  // ignore: unused_element
  Widget _buildMenuGroup(DevMenuItem parent) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(parent.icon, color: FTheme.of(context).colors.foreground),
        title: Text(
          parent.title,
          style: FTheme.of(
            context,
          ).typography.base.copyWith(color: FTheme.of(context).colors.foreground),
        ),
        children:
            parent.children?.map((child) {
              return Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ListTile(
                  leading: Icon(child.icon, color: FTheme.of(context).colors.foreground),
                  title: Text(
                    child.title,
                    style: FTheme.of(
                      context,
                    ).typography.base.copyWith(color: FTheme.of(context).colors.foreground),
                  ),
                  onTap: () {
                    Get.back();
                    if (child.onTap != null) Future.microtask(child.onTap!);
                  },
                ),
              );
            }).toList() ??
            [],
      ),
    );
  }
}
