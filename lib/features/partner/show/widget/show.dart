import 'package:flutter/gestures.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/components/widget/badge.dart';
import 'package:sukientotapp/features/components/button/plus.dart';
import 'detail.dart';
import 'upload_arrived_photo.dart';

class Show extends StatelessWidget {
  Show({
    super.key,
    required this.billId,
    required this.code,
    required this.timestamp,
    required this.price,
    required this.clientName,
    required this.category,
    required this.event,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.note,
    required this.currentStatus,
  });

  final int billId;
  final String code;
  final String timestamp;
  final int price;
  final String clientName;
  final String category;
  final String event;
  final String date;
  final String startTime;
  final String endTime;
  final String address;
  final String note;
  final String currentStatus;

  final Map<String, Map<String, dynamic>> statusStyles = {
    'pending': {
      'label': 'wait_for_process'.tr,
      'bg': const Color(0xFFFFF7ED),
      'text': const Color(0xFFC2410C),
    },
    'confirmed': {
      'label': 'confirmed'.tr,
      'bg': const Color(0xFFEFF6FF),
      'text': const Color(0xFF1D4ED8),
    },
    'completed': {
      'label': 'completed'.tr,
      'bg': const Color(0xFFF0FDF4),
      'text': const Color(0xFF15803D),
    },
    'expired': {
      'label': 'expired'.tr,
      'bg': const Color(0xFFF9FAFB),
      'text': const Color(0xFF374151),
    },
    'in_job': {
      'label': 'in_job'.tr,
      'bg': const Color(0xFFFAF5FF),
      'text': const Color(0xFF7E22CE),
    },
    'cancelled': {
      'label': 'cancelled'.tr,
      'bg': const Color(0xFFFEF2F2),
      'text': const Color(0xFFB91C1C),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: context.fTheme.colors.muted,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          code,
                          style: context.typography.base.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.fTheme.colors.foreground,
                          ),
                        ),
                        Text(
                          category,
                          style: context.typography.xs.copyWith(
                            fontWeight: FontWeight.w400,
                            color: context.fTheme.colors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                    CustomBadge(
                      text: statusStyles[currentStatus]?['label'],
                      backgroundColor:
                          statusStyles[currentStatus]?['bg'] ??
                          const Color(0xFFF3F4F6),
                      textColor:
                          statusStyles[currentStatus]?['text'] ??
                          const Color(0xFF374151),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildLineItem(
                  context,
                  FIcons.userRound,
                  'customer'.tr,
                  clientName,
                  onTap: () => Get.snackbar('info'.tr, 'in_dev'.tr),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildLineItem(
                        context,
                        FIcons.calendarDays,
                        'date'.tr,
                        '16/2/2026',
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            FIcons.clock,
                            size: 12,
                            color: context.fTheme.colors.foreground,
                          ),
                          const SizedBox(width: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: startTime,
                                  style: context.typography.xs.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: context.fTheme.colors.foreground,
                                  ),
                                ),
                                TextSpan(
                                  text: ' - ',
                                  style: context.typography.xs.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: context.fTheme.colors.foreground,
                                  ),
                                ),
                                TextSpan(
                                  text: endTime,
                                  style: context.typography.xs.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: context.fTheme.colors.foreground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildLineItem(context, FIcons.mapPin, 'address'.tr, 'Hà Nội'),

                if (currentStatus != 'completed' &&
                    currentStatus != 'expired' &&
                    currentStatus != 'cancelled') ...[
                  Divider(color: context.fTheme.colors.border, height: 16),
                  Row(
                    children: [
                      Text(
                        'your_price'.tr,
                        style: context.typography.xs.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.fTheme.colors.foreground,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        FormatUtils.formatCurrencyToDoule(price),
                        style: context.typography.base.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.fTheme.colors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (currentStatus != 'completed' &&
              currentStatus != 'expired' &&
              currentStatus != 'cancelled')
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  Detail(
                    code: code,
                    status:
                        statusStyles[currentStatus]?['label'] ?? currentStatus,
                    statusColor:
                        statusStyles[currentStatus]?['bg'] ??
                        const Color(0xFFF3F4F6),
                    statusTextColor:
                        statusStyles[currentStatus]?['text'] ??
                        const Color(0xFF374151),
                    clientName: clientName,
                    event: event,
                    startTime: startTime,
                    endTime: endTime,
                    date: date,
                    address: address,
                    note: note,
                    total: price,
                  ),
                  isScrollControlled: true,
                  backgroundColor: context.fTheme.colors.background,
                  enterBottomSheetDuration: const Duration(milliseconds: 400),
                  exitBottomSheetDuration: const Duration(milliseconds: 300),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,

                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: context.fTheme.colors.border.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    if (currentStatus == 'confirmed' ||
                        currentStatus == 'in_job')
                      Row(
                        children: [
                          Expanded(
                            child: CustomButtonPlus(
                              onTap: () {
                                if (currentStatus == 'in_job') {
                                  Get.snackbar('info'.tr, 'in_dev'.tr);
                                } else {
                                  Get.bottomSheet(
                                    UploadArrivedPhoto(
                                      code: code,
                                      billId: billId,
                                    ),
                                    isScrollControlled: true,
                                    backgroundColor:
                                        context.fTheme.colors.background,
                                    enterBottomSheetDuration: const Duration(
                                      milliseconds: 400,
                                    ),
                                    exitBottomSheetDuration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: currentStatus == 'in_job'
                                  ? FIcons.checkCheck
                                  : FIcons.mapPinCheck,
                              iconSize: 16,
                              btnText: currentStatus == 'in_job'
                                  ? 'completed_show'.tr
                                  : 'arrived'.tr,
                              textSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 34,
                              borderRadius: 10,
                              borderColor: Colors.transparent,
                            ),
                          ),
                          const SizedBox(width: 12),
                          CustomButtonPlus(
                            onTap: () => Get.snackbar('info'.tr, 'in_dev'.tr),
                            icon: FIcons.messageCircleMore,
                            iconSize: 16,
                            textSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 34,
                            borderRadius: 10,
                            borderColor: Colors.transparent,
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          timestamp,
                          style: context.typography.xs.copyWith(
                            color: context.fTheme.colors.mutedForeground,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          FIcons.arrowRight,
                          color: context.fTheme.colors.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLineItem(
    BuildContext context,
    IconData icon,
    String firstText,
    String secondText, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 12, color: context.fTheme.colors.mutedForeground),
          const SizedBox(width: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$firstText:  ',
                  style: context.typography.xs.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.fTheme.colors.mutedForeground,
                  ),
                ),
                TextSpan(
                  text: secondText,
                  style: context.typography.xs.copyWith(
                    color: onTap != null
                        ? context.fTheme.colors.primary
                        : context.fTheme.colors.foreground,
                  ),
                  recognizer: onTap != null
                      ? (TapGestureRecognizer()..onTap = onTap)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
