import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/components/button/plus.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.confirmColor = AppColors.red600,
    this.icon,
    this.iconColor,
  });

  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color confirmColor;
  final IconData? icon;
  final Color? iconColor;

  static Future<void> show({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    Color confirmColor = AppColors.red600,
    IconData? icon,
    Color? iconColor,
  }) {
    return Get.dialog(
      ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmColor: confirmColor,
        icon: icon,
        iconColor: iconColor,
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.fTheme.colors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: (iconColor ?? confirmColor).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: iconColor ?? confirmColor,
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.typography.lg.copyWith(
                fontWeight: FontWeight.bold,
                color: context.fTheme.colors.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.typography.sm.copyWith(
                color: context.fTheme.colors.mutedForeground,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButtonPlus(
                    onTap: () {
                      Get.back();
                      onCancel?.call();
                    },
                    btnText: cancelText ?? 'cancel'.tr,
                    color: context.fTheme.colors.muted,
                    textColor: context.fTheme.colors.foreground,
                    borderColor: context.fTheme.colors.border,
                    height: 44,
                    borderRadius: 12,
                    fontWeight: FontWeight.w600,
                    textSize: 14,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButtonPlus(
                    onTap: () {
                      Get.back();
                      onConfirm();
                    },
                    btnText: confirmText ?? 'confirm'.tr,
                    color: confirmColor,
                    borderColor: Colors.transparent,
                    height: 44,
                    borderRadius: 12,
                    fontWeight: FontWeight.w600,
                    textSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
