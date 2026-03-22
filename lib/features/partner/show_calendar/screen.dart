import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/show_bill_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'controller.dart';
import 'widgets/bill_data_source.dart';

class ShowCalendarScreen extends GetView<ShowCalendarController> {
  const ShowCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      header: _CalendarHeader(controller: controller),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const _LoadingState();
        }

        return SfCalendar(
          controller: controller.calendarController,
          view: CalendarView.month,
          dataSource: BillDataSource(controller.appointments),
          todayHighlightColor: AppColors.primary,
          selectionDecoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true,
            agendaViewHeight: 200,
            agendaItemHeight: 60,
          ),
          appointmentTextStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          headerStyle: const CalendarHeaderStyle(
            textAlign: TextAlign.center,
            backgroundColor: Colors.transparent,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.lightForeground,
              letterSpacing: 0.3,
            ),
          ),
          viewHeaderStyle: const ViewHeaderStyle(
            backgroundColor: Colors.transparent,
            dayTextStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.lightMutedForeground,
              letterSpacing: 0.5,
            ),
          ),
          cellBorderColor: AppColors.dividers,
          onTap: (CalendarTapDetails details) {
            if (details.appointments != null &&
                details.appointments!.isNotEmpty) {
              _showBillDetails(
                context,
                details.appointments!.first as Appointment,
              );
            }
          },
        ).animate().fadeIn(duration: 350.ms);
      }),
    );
  }

  void _showBillDetails(BuildContext context, Appointment appointment) {
    final notes = appointment.notes?.split('|') ?? [];
    if (notes.length < 4) return;

    final clientName = notes[0];
    final address = notes[1];
    final code = notes[2];
    final billId = int.tryParse(notes[3]);
    final bill = billId != null ? controller.getBillById(billId) : null;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _BillDetailSheet(
        appointment: appointment,
        bill: bill,
        clientName: clientName,
        address: address,
        code: code,
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _CalendarHeader extends StatelessWidget {
  final ShowCalendarController controller;
  const _CalendarHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.statusBarHeight + 6,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.dividers, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _HeaderIconButton(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.lightForeground,
              size: 17,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'show_calendar'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.lightForeground,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'confirmed_bookings'.tr,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.lightMutedForeground,
                ),
              ),
            ],
          ),
          Obx(
            () => _HeaderIconButton(
              onTap: controller.toggleView,
              child: Icon(
                controller.currentView.value == CalendarView.month
                    ? FIcons.calendar1
                    : FIcons.layoutGrid,
                size: 17,
                color: AppColors.lightForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const _HeaderIconButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.lightBackground,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.dividers),
        ),
        child: Center(child: child),
      ),
    );
  }
}

// ─── Loading State ────────────────────────────────────────────────────────────

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Loading...',
            style: TextStyle(
              color: AppColors.lightMutedForeground,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bill Detail Bottom Sheet ─────────────────────────────────────────────────

class _BillDetailSheet extends StatelessWidget {
  final Appointment appointment;
  final ShowBill? bill;
  final String clientName;
  final String address;
  final String code;

  const _BillDetailSheet({
    required this.appointment,
    required this.bill,
    required this.clientName,
    required this.address,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.dividers,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          // Gradient event header card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.red600, AppColors.red700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'confirmed'.tr.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    appointment.subject,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white70,
                        size: 12,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DateFormat('EEE, dd MMM yyyy').format(
                          appointment.startTime,
                        ),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.access_time_rounded,
                        color: Colors.white70,
                        size: 13,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${timeFormat.format(appointment.startTime)} – ${timeFormat.format(appointment.endTime)}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Detail cards
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Column(
              children: [
                _InfoCard(
                  items: [
                    _DetailItem(
                      iconBg: const Color(0xFFEFF6FF),
                      icon: FIcons.hash,
                      iconColor: const Color(0xFF3B82F6),
                      label: 'bill_code'.tr,
                      value: code,
                    ),
                    _DetailItem(
                      iconBg: const Color(0xFFF0FDF4),
                      icon: FIcons.user,
                      iconColor: const Color(0xFF22C55E),
                      label: 'client'.tr,
                      value: clientName,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _InfoCard(
                  items: [
                    _DetailItem(
                      iconBg: const Color(0xFFFFF7ED),
                      icon: FIcons.mapPin,
                      iconColor: const Color(0xFFF97316),
                      label: 'address'.tr,
                      value: address,
                    ),
                  ],
                ),
                if (bill != null) ...[
                  const SizedBox(height: 10),
                  _InfoCard(
                    items: [
                      _DetailItem(
                        iconBg: const Color(0xFFFDF4FF),
                        icon: FIcons.briefcase,
                        iconColor: const Color(0xFFA855F7),
                        label: 'category'.tr,
                        value: bill!.category,
                      ),
                      _DetailItem(
                        iconBg: const Color(0xFFFEF3C7),
                        icon: FIcons.dollarSign,
                        iconColor: AppColors.amber600,
                        label: 'total'.tr,
                        value: NumberFormat.currency(
                          locale: 'vi_VN',
                          symbol: '₫',
                          decimalDigits: 0,
                        ).format(bill!.finalTotal),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(
            height: 16 + MediaQuery.of(context).viewPadding.bottom,
          ),
        ],
      ),
    ).animate().slideY(
          begin: 0.1,
          end: 0,
          duration: 320.ms,
          curve: Curves.easeOutCubic,
        ).fadeIn(duration: 250.ms);
  }
}

// ─── Info Card ────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final List<_DetailItem> items;
  const _InfoCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dividers),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              _DetailRow(item: item),
              if (index < items.length - 1)
                const Divider(
                  height: 1,
                  indent: 54,
                  endIndent: 16,
                  color: AppColors.dividers,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ─── Detail Row ───────────────────────────────────────────────────────────────

class _DetailItem {
  final Color iconBg;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _DetailItem({
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });
}

class _DetailRow extends StatelessWidget {
  final _DetailItem item;
  const _DetailRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: item.iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(item.icon, size: 15, color: item.iconColor),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.lightMutedForeground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightForeground,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
