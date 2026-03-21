import 'package:sukientotapp/core/utils/import/global.dart';

class OrderStatusConfig {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const OrderStatusConfig({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  factory OrderStatusConfig.fromStatus(String? status, BuildContext context) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return OrderStatusConfig(
          text: 'status_pending'.tr,
          backgroundColor: Colors.yellow[100]!,
          textColor: Colors.yellow[800]!,
          borderColor: Colors.yellow[200]!,
        );
      case 'confirmed':
        return OrderStatusConfig(
          text: 'status_confirmed'.tr,
          backgroundColor: Colors.blue[100]!,
          textColor: Colors.blue[800]!,
          borderColor: Colors.blue[200]!,
        );
      case 'expired':
        return OrderStatusConfig(
          text: 'expired'.tr,
          backgroundColor: Colors.orange[100]!,
          textColor: Colors.orange[800]!,
          borderColor: Colors.orange[200]!,
        );
      case 'in_job':
        return OrderStatusConfig(
          text: 'status_in_job'.tr,
          backgroundColor: FTheme.of(context).colors.primary.withValues(alpha: 0.1),
          textColor: FTheme.of(context).colors.primary,
          borderColor: FTheme.of(context).colors.primary.withValues(alpha: 0.2),
        );
      case 'completed':
        return OrderStatusConfig(
          text: 'status_completed'.tr,
          backgroundColor: Colors.green[100]!,
          textColor: Colors.green[800]!,
          borderColor: Colors.green[200]!,
        );
      case 'cancelled':
        return OrderStatusConfig(
          text: 'status_cancelled'.tr,
          backgroundColor: Colors.red[100]!,
          textColor: Colors.red[800]!,
          borderColor: Colors.red[200]!,
        );
      default:
        return OrderStatusConfig(
          text: status?.isEmpty == true ? 'Không rõ' : (status ?? 'unknown'.tr),
          backgroundColor: Colors.grey[100]!,
          textColor: Colors.grey[800]!,
          borderColor: Colors.grey[200]!,
        );
    }
  }
}

class OrderStatusBadge extends StatelessWidget {
  final String? status;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final bool upperCaseText;

  const OrderStatusBadge({
    super.key,
    required this.status,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.upperCaseText = false,
  });

  @override
  Widget build(BuildContext context) {
    final config = OrderStatusConfig.fromStatus(status, context);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: config.backgroundColor,
        border: Border.all(color: config.borderColor),
        borderRadius: borderRadius,
      ),
      child: Text(
        upperCaseText ? config.text.toUpperCase() : config.text,
        style: context.typography.xs.copyWith(
          color: config.textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
