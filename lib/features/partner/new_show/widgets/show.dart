import 'package:flutter/gestures.dart';
import 'package:sukientotapp/core/utils/import/global.dart  ';

import 'package:sukientotapp/features/components/button/plus.dart';
import '../widgets/accept.dart';

class Show extends StatelessWidget {
  const Show({
    super.key,
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
    this.note = 'unknown',
  });

  final String code;
  final String timestamp;
  final String price;
  final String clientName;
  final String category;
  final String event;
  final String date;
  final String startTime;
  final String endTime;
  final String address;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 16, bottom: 10, left: 16, right: 16),
      decoration: BoxDecoration(
        color: context.fTheme.colors.muted,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'code'.tr} #$code',
                style: context.typography.base.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.fTheme.colors.foreground,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '10 VND',
                    style: context.typography.base.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.fTheme.colors.foreground,
                    ),
                  ),
                  Text(
                    'time_ago'.trParams({'time': timestamp}),
                    style: context.typography.xs.copyWith(
                      color: context.fTheme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildLineItem(
            context,
            FIcons.userRound,
            'customer'.tr,
            clientName,
            onTap: () => logger.i('Client user tapped'), //TODO: View client details
          ),
          _buildLineItem(context, FIcons.tag, 'needs'.tr, 'Chú hề'),
          _buildLineItem(context, FIcons.ticket, 'event'.tr, 'Sinh nhật'),
          _buildLineItem(context, FIcons.calendarDays, 'date'.tr, '16/2/2026'),
          Row(
            children: [
              Expanded(
                child: _buildLineItem(context, FIcons.clockArrowUp, 'start_time'.tr, '14:00'),
              ),
              Expanded(
                child: _buildLineItem(context, FIcons.clockArrowDown, 'end_time'.tr, '17:00'),
              ),
            ],
          ),
          _buildLineItem(context, FIcons.mapPin, 'address'.tr, 'Hà Nội'),
          _buildLineItem(context, FIcons.notepadText, 'note'.tr, 'Hãy đến đúng giờ nhé!'),

          const SizedBox(height: 10),
          CustomButtonPlus(
            onTap: () => Get.bottomSheet(Accept(code: code)),
            btnText: 'apply_for_show'.tr,
            textSize: 14,
            fontWeight: FontWeight.w600,
            width: double.infinity,
            height: 38,
            borderRadius: 10,
            borderColor: Colors.transparent,
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
                  recognizer: onTap != null ? (TapGestureRecognizer()..onTap = onTap) : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
