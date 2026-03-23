import 'package:sukientotapp/core/utils/import/global.dart';

import '../widgets/accept.dart';

class Show extends StatelessWidget {
  const Show({
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
    this.note = 'unknown',
  });

  final int billId;
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

  static const _accentColor = Color(0xFF6366F1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.fTheme.colors.muted,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: context.fTheme.colors.foreground.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accent strip
            Container(height: 3, color: _accentColor),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: code + price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              code,
                              style: context.typography.base.copyWith(
                                fontWeight: FontWeight.w700,
                                color: context.fTheme.colors.foreground,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _accentColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                category,
                                style: context.typography.xs.copyWith(
                                  color: _accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            price,
                            style: context.typography.base.copyWith(
                              fontWeight: FontWeight.w700,
                              color: _accentColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                FIcons.clock,
                                size: 10,
                                color: context.fTheme.colors.mutedForeground,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                timestamp,
                                style: context.typography.xs.copyWith(
                                  color: context.fTheme.colors.mutedForeground,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Client
                  GestureDetector(
                    onTap: () => logger.i('Client user tapped'),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Icon(
                            FIcons.userRound,
                            size: 14,
                            color: _accentColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            clientName,
                            style: context.typography.sm.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.fTheme.colors.primary,
                            ),
                          ),
                        ),
                        Icon(
                          FIcons.chevronRight,
                          size: 14,
                          color: context.fTheme.colors.primary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Date + time chips
                  Row(
                    children: [
                      Expanded(
                        child: _buildChip(context, FIcons.calendarDays, date),
                      ),
                      const SizedBox(width: 8),
                      _buildChip(context, FIcons.clockArrowUp, startTime),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text('–'),
                      ),
                      _buildChip(context, FIcons.clockArrowDown, endTime),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Event chip
                  _buildChip(context, FIcons.ticket, event, expand: true),

                  const SizedBox(height: 6),

                  // Address chip
                  _buildChip(context, FIcons.mapPin, address, expand: true),

                  // Note (only if meaningful)
                  if (note.isNotEmpty && note != 'unknown') ...[
                    const SizedBox(height: 6),
                    _buildChip(context, FIcons.notepadText, note, expand: true),
                  ],
                ],
              ),
            ),

            // CTA footer
            GestureDetector(
              onTap: () => Get.bottomSheet(
                Accept(code: code, billId: billId),
                isScrollControlled: true,
                backgroundColor: context.fTheme.colors.background,
                enterBottomSheetDuration: const Duration(milliseconds: 400),
                exitBottomSheetDuration: const Duration(milliseconds: 300),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: _accentColor,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FIcons.badgeCheck,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'apply_for_show'.tr,
                      style: context.typography.sm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    IconData icon,
    String text, {
    bool expand = false,
  }) {
    return Container(
      width: expand ? double.infinity : null,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: expand
          ? Row(
              children: [
                Icon(
                  icon,
                  size: 11,
                  color: context.fTheme.colors.mutedForeground,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.typography.xs.copyWith(
                      color: context.fTheme.colors.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 11,
                  color: context.fTheme.colors.mutedForeground,
                ),
                const SizedBox(width: 5),
                Text(
                  text,
                  style: context.typography.xs.copyWith(
                    color: context.fTheme.colors.foreground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
    );
  }
}
