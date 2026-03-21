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
      header: Container(
        padding: EdgeInsets.only(
          top: context.statusBarHeight + 8,
          left: 16,
          right: 16,
          bottom: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.lightForeground,
                    size: 24,
                  ),
                ),
              ),
            ),
            Text(
              'show_calendar'.tr,
              style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: controller.toggleView,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: AppColors.dividers),
                  ),
                  child: Center(
                    child: Icon(
                      controller.currentView.value == CalendarView.month
                          ? FIcons.calendar1
                          : FIcons.layoutGrid,
                      size: 18,
                      color: AppColors.lightForeground,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                context.fTheme.colors.primary,
              ),
            ),
          );
        }

        return SfCalendar(
          controller: controller.calendarController,
          view: CalendarView.month,
          dataSource: BillDataSource(controller.appointments),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true,
            agendaViewHeight: 180,
          ),
          appointmentTextStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          headerStyle: const CalendarHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onTap: (CalendarTapDetails details) {
            if (details.appointments != null &&
                details.appointments!.isNotEmpty) {
              _showBillDetails(
                context,
                details.appointments!.first as Appointment,
              );
            }
          },
        );
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
    final dateFormat = DateFormat('EEEE, dd/MM/yyyy');

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  appointment.subject,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _DetailRow(
            icon: FIcons.hash,
            label: 'bill_code'.tr,
            value: code,
          ),
          _DetailRow(
            icon: FIcons.user,
            label: 'client'.tr,
            value: clientName,
          ),
          _DetailRow(
            icon: FIcons.calendar1,
            label: 'date'.tr,
            value: dateFormat.format(appointment.startTime),
          ),
          _DetailRow(
            icon: FIcons.clock,
            label: 'time'.tr,
            value:
                '${timeFormat.format(appointment.startTime)} - ${timeFormat.format(appointment.endTime)}',
          ),
          _DetailRow(
            icon: FIcons.mapPin,
            label: 'address'.tr,
            value: address,
          ),
          if (bill != null) ...[
            _DetailRow(
              icon: FIcons.briefcase,
              label: 'category'.tr,
              value: bill!.category,
            ),
            _DetailRow(
              icon: FIcons.dollarSign,
              label: 'total'.tr,
              value: NumberFormat.currency(
                locale: 'vi_VN',
                symbol: '₫',
                decimalDigits: 0,
              ).format(bill!.finalTotal),
            ),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: context.fTheme.colors.mutedForeground),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: context.fTheme.colors.mutedForeground,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
