import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/components/widget/badge.dart';
import 'package:sukientotapp/features/components/widget/confirm_dialog.dart';
import 'package:sukientotapp/features/partner/show/controller.dart';

class Detail extends StatelessWidget {
  const Detail({
    super.key,
    required this.billId,
    required this.billStatus,
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

  final int billId;
  final String billStatus;
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
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: context.fTheme.colors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'detail_info'.tr,
                        style: context.typography.xl.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.fTheme.colors.foreground,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        code,
                        style: context.typography.sm.copyWith(
                          color: context.fTheme.colors.mutedForeground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomBadge(
                      text: status,
                      backgroundColor: statusColor,
                      textColor: statusTextColor,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: context.fTheme.colors.muted,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          FIcons.x,
                          size: 14,
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Divider(height: 1, color: context.fTheme.colors.border),

          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                children: [
                  // Info grid section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.fTheme.colors.muted,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        _buildRow(
                          context,
                          FIcons.userRound,
                          'customer'.tr,
                          clientName,
                        ),
                        _buildDivider(context),
                        _buildRow(
                          context,
                          FIcons.ticket,
                          'event'.tr,
                          event,
                        ),
                        _buildDivider(context),
                        _buildRow(
                          context,
                          FIcons.calendarDays,
                          'date'.tr,
                          date,
                        ),
                        _buildDivider(context),
                        _buildRow(
                          context,
                          FIcons.clock,
                          'time'.tr,
                          '$startTime – $endTime',
                        ),
                        _buildDivider(context),
                        _buildRow(
                          context,
                          FIcons.mapPin,
                          'location'.tr,
                          address,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Note section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: context.fTheme.colors.muted,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FIcons.notepadText,
                              size: 13,
                              color: context.fTheme.colors.mutedForeground,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'note'.tr,
                              style: context.typography.xs.copyWith(
                                color: context.fTheme.colors.mutedForeground,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          note.isEmpty ? 'no_note'.tr : note,
                          style: context.typography.sm.copyWith(
                            color: note.isEmpty
                                ? context.fTheme.colors.mutedForeground
                                : context.fTheme.colors.foreground,
                            fontWeight: FontWeight.w400,
                            fontStyle: note.isEmpty ? FontStyle.italic : FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Total price highlight
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          statusTextColor.withValues(alpha: 0.12),
                          statusTextColor.withValues(alpha: 0.04),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: statusTextColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FIcons.dollarSign,
                          size: 16,
                          color: statusTextColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'total_price'.tr,
                          style: context.typography.sm.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          FormatUtils.formatCurrencyToDoule(total),
                          style: context.typography.lg.copyWith(
                            fontWeight: FontWeight.w700,
                            color: statusTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Action buttons
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              MediaQuery.of(context).padding.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    if (billStatus != 'pending') {
                      AppSnackbar.showError(
                        message: 'cancel_book_show_not_allowed'.tr,
                      );
                      return;
                    }
                    ConfirmDialog.show(
                      title: 'confirm_cancel_book_show_title'.tr,
                      message: 'confirm_cancel_book_show_desc'.tr,
                      confirmText: 'cancel_book_show_yes_btn'.tr,
                      cancelText: 'cancel_book_show_no_btn'.tr,
                      icon: FIcons.circleX,
                      iconColor: context.fTheme.colors.error,
                      confirmColor: context.fTheme.colors.error,
                      onConfirm: () {
                        Get.find<ShowController>().cancelAcceptBill(billId);
                      },
                    );
                  },
                  child: Container(
                    height: 46,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.fTheme.colors.error.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.fTheme.colors.error.withValues(
                          alpha: 0.35,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'cancel_book_show'.tr,
                        style: context.typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.fTheme.colors.error,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 46,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.fTheme.colors.muted,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: context.fTheme.colors.border),
                    ),
                    child: Center(
                      child: Text(
                        'close'.tr,
                        style: context.typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.fTheme.colors.foreground,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: context.fTheme.colors.mutedForeground),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: context.typography.xs.copyWith(
                color: context.fTheme.colors.mutedForeground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.typography.sm.copyWith(
                color: context.fTheme.colors.foreground,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.fTheme.colors.border.withValues(alpha: 0.6),
    );
  }
}
