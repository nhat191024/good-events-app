import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/components/widget/badge.dart';
import 'package:sukientotapp/features/components/button/plus.dart';

class Detail extends StatelessWidget {
  const Detail({
    super.key,
    required this.code,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
    required this.clientName,
    required this.event,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.address,
    required this.note,
    required this.total,
  });

  final String code;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final String clientName;
  final String event;
  final String startTime;
  final String endTime;
  final String date;
  final String address;
  final String note;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'detail_info'.tr,
                style: context.typography.xl2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.fTheme.colors.foreground,
                ),
              ),
              CustomBadge(
                text: status,
                backgroundColor: statusColor,
                textColor: statusTextColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPlaceholderItem(context, "code".tr, code),
                  _buildPlaceholderItem(context, "customer".tr, clientName),
                  _buildPlaceholderItem(context, "event".tr, event),
                  _buildPlaceholderItem(
                    context,
                    "time".tr,
                    '$startTime - $endTime, $date',
                  ),
                  _buildPlaceholderItem(context, "location".tr, address),
                  _buildPlaceholderItem(
                    context,
                    "note".tr,
                    note.isEmpty ? 'no_note'.tr : note,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.fTheme.colors.muted,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'total_price'.tr,
                          style: context.typography.base.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                        ),
                        Text(
                          FormatUtils.formatCurrencyToDoule(total),
                          style: context.typography.lg.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.fTheme.colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButtonPlus(
                  onTap: () => Get.back(),
                  btnText: 'close'.tr,
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 34,
                  borderRadius: 10,
                  borderColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderItem(
    BuildContext context,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.typography.xs.copyWith(
              color: context.fTheme.colors.mutedForeground,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.typography.base.copyWith(
              color: context.fTheme.colors.foreground,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: context.fTheme.colors.border, height: 1),
        ],
      ),
    );
  }
}
