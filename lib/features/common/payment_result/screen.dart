import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

class PaymentResultScreen extends GetView<PaymentResultController> {
  const PaymentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cfg = _resolveConfig(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: cfg.backgroundColor,
        body: SafeArea(
          child: Obx(() {
            if (controller.isConfirming.value) {
              return _buildConfirmingOverlay(cfg);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  _buildStatusIcon(cfg),
                  const SizedBox(height: 32),
                  _buildTitle(context, cfg),
                  const SizedBox(height: 12),
                  _buildSubtitle(context, cfg),
                  const SizedBox(height: 24),
                  _buildOrderCodeBadge(context),
                  if (controller.isPaid && controller.newBalance.value > 0) ...[
                    const SizedBox(height: 12),
                    _buildNewBalanceBadge(context),
                  ],
                  const Spacer(flex: 3),
                  _buildActionButton(context, cfg),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // ─── Confirming overlay ───────────────────────────────────────────────────

  Widget _buildConfirmingOverlay(_PaymentResultConfig cfg) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: CircularProgressIndicator(
              color: cfg.accentColor,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'payment_confirming'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: cfg.titleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Icon ────────────────────────────────────────────────────────────────

  Widget _buildStatusIcon(_PaymentResultConfig cfg) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (_, value, child) =>
          Transform.scale(scale: value, child: child),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cfg.iconBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: cfg.accentColor.withValues(alpha: 0.25),
              blurRadius: 32,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: cfg.isAnimated
              ? _buildAnimatedIcon(cfg)
              : Icon(cfg.icon, size: 56, color: cfg.accentColor),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon(_PaymentResultConfig cfg) {
    return Icon(cfg.icon, size: 56, color: cfg.accentColor)
        .animate(onPlay: (c) => c.repeat())
        .rotate(duration: const Duration(seconds: 2), curve: Curves.linear);
  }

  // ─── Title ────────────────────────────────────────────────────────────────

  Widget _buildTitle(BuildContext context, _PaymentResultConfig cfg) {
    return Text(
      cfg.title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: cfg.titleColor,
        height: 1.3,
      ),
    );
  }

  // ─── Subtitle ─────────────────────────────────────────────────────────────

  Widget _buildSubtitle(BuildContext context, _PaymentResultConfig cfg) {
    return Text(
      cfg.subtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade600,
        height: 1.5,
      ),
    );
  }

  // ─── Order Code Badge ─────────────────────────────────────────────────────

  Widget _buildOrderCodeBadge(BuildContext context) {
    if (controller.orderCode == 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7E5E4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            FIcons.receipt,
            size: 16,
            color: Color(0xFF78716C),
          ),
          const SizedBox(width: 8),
          Text(
            'payment_order_code'.tr,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF78716C),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '#${controller.orderCode}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1917),
            ),
          ),
        ],
      ),
    );
  }

  // ─── New Balance Badge ────────────────────────────────────────────────────

  Widget _buildNewBalanceBadge(BuildContext context) {
    final formatted = NumberFormat('#,##0', 'vi_VN')
        .format(controller.newBalance.value)
        .replaceAll(',', '.');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FIcons.wallet, size: 16, color: Color(0xFF16A34A)),
          const SizedBox(width: 8),
          Text(
            'payment_new_balance'.tr,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF15803D),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$formatted đ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF14532D),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Action Button ─────────────────────────────────────────────────────────

  Widget _buildActionButton(BuildContext context, _PaymentResultConfig cfg) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: controller.goToHome,
        style: ElevatedButton.styleFrom(
          backgroundColor: cfg.accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          'back_to_home'.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ─── Config resolver ─────────────────────────────────────────────────────

  _PaymentResultConfig _resolveConfig(BuildContext context) {
    switch (controller.status) {
      case PaymentStatus.paid:
        return _PaymentResultConfig(
          backgroundColor: const Color(0xFFF0FDF4),
          accentColor: const Color(0xFF16A34A),
          iconBackgroundColor: const Color(0xFFDCFCE7),
          titleColor: const Color(0xFF14532D),
          icon: FIcons.checkCheck,
          title: 'payment_success_title'.tr,
          subtitle: 'payment_success_subtitle'.tr,
          isAnimated: false,
        );
      case PaymentStatus.pending:
        return _PaymentResultConfig(
          backgroundColor: const Color(0xFFFFFBEB),
          accentColor: const Color(0xFFD97706),
          iconBackgroundColor: const Color(0xFFFEF3C7),
          titleColor: const Color(0xFF78350F),
          icon: FIcons.clock,
          title: 'payment_pending_title'.tr,
          subtitle: 'payment_pending_subtitle'.tr,
          isAnimated: false,
        );
      case PaymentStatus.processing:
        return _PaymentResultConfig(
          backgroundColor: const Color(0xFFEFF6FF),
          accentColor: const Color(0xFF2563EB),
          iconBackgroundColor: const Color(0xFFDBEAFE),
          titleColor: const Color(0xFF1E3A8A),
          icon: FIcons.loader,
          title: 'payment_processing_title'.tr,
          subtitle: 'payment_processing_subtitle'.tr,
          isAnimated: true,
        );
      case PaymentStatus.cancelled:
        return _PaymentResultConfig(
          backgroundColor: const Color(0xFFFFF1F2),
          accentColor: AppColors.red600,
          iconBackgroundColor: const Color(0xFFFFE4E6),
          titleColor: const Color(0xFF7F1D1D),
          icon: FIcons.circleX,
          title: 'payment_cancelled_title'.tr,
          subtitle: 'payment_cancelled_subtitle'.tr,
          isAnimated: false,
        );
    }
  }
}

// ─── Internal config model ────────────────────────────────────────────────────

class _PaymentResultConfig {
  final Color backgroundColor;
  final Color accentColor;
  final Color iconBackgroundColor;
  final Color titleColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isAnimated;

  const _PaymentResultConfig({
    required this.backgroundColor,
    required this.accentColor,
    required this.iconBackgroundColor,
    required this.titleColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isAnimated,
  });
}
