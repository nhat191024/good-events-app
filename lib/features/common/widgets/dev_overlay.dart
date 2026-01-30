import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:dio_log/dio_log.dart';
import 'package:dio/dio.dart';
import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/api_url.dart';

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

                _buildMenuGroup(
                  DevMenuItem(
                    icon: Icons.verified_user_outlined,
                    title: "Auth Actions",
                    children: [
                      DevMenuItem(
                        icon: Icons.logout,
                        title: "Logout",
                        onTap: () async {
                          Get.back();

                          try {
                            if (!Get.isRegistered<ApiService>()) {
                              Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
                            }

                            if (StorageService.readData(key: LocalStorageKeys.token) == null) {
                              Get.snackbar("Info", "No user logged in");
                              return;
                            }

                            final api = Get.find<ApiService>();

                            final response = await api.dio.get(AppUrl.logout);

                            if (response.statusCode == 200) {
                              StorageService.clearAllData();
                              Get.snackbar("Success", "Logged out");
                              Get.offAllNamed(Routes.loginScreen);
                            } else {
                              Get.snackbar("Error", "Logout failed");
                            }
                          } on DioException catch (e) {
                            logger.e('[DevOverlay] [logout] DioException: ${e.message}');

                            if (e.response?.statusCode == 401) {
                              StorageService.clearAllData();
                              Get.snackbar("Success", "Logged out");
                              Get.offAllNamed(Routes.loginScreen);
                              return;
                            }

                            Get.snackbar("Error", "Không thể đăng xuất. Vui lòng thử lại.");
                          } catch (e) {
                            logger.e('[DevOverlay] [logout] Unknown error: $e');
                            Get.snackbar("Error", "Đã xảy ra lỗi khi đăng xuất: $e");
                          }
                        },
                      ),
                      DevMenuItem(
                        icon: Icons.supervised_user_circle_outlined,
                        title: "User Login",
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                color: FTheme.of(context).colors.background,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.height * 0.75,
                                ),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildMenuItem(
                                        icon: Icons.supervised_user_circle_outlined,
                                        title: "Partner",
                                        onTap: () {},
                                      ),
                                      _buildMenuItem(
                                        icon: Icons.supervised_user_circle_outlined,
                                        title: "Client",
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                _buildMenuItem(
                  icon: Icons.wifi_tethering_outlined,
                  title: "Open HTTP Log",
                  onTap: () {
                    Get.back();
                    Get.to(() => HttpLogListWidget());
                  },
                ),
              ],
            ),
          ),
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
