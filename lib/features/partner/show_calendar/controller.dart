import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/show_bill_model.dart';
import 'package:sukientotapp/domain/repositories/partner/show_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ShowCalendarController extends GetxController {
  final ShowRepository _repository;
  ShowCalendarController(this._repository);

  final isLoading = false.obs;
  final bills = <ShowBill>[].obs;
  final calendarController = CalendarController();
  final currentView = CalendarView.month.obs;

  @override
  void onInit() {
    super.onInit();
    fetchConfirmedBills();
  }

  Future<void> fetchConfirmedBills() async {
    isLoading.value = true;
    try {
      int page = 1;
      int lastPage = 1;
      final allBills = <ShowBill>[];
      do {
        final response = await _repository.getBills(
          status: 'confirmed',
          page: page,
          perPage: 100,
        );
        allBills.addAll(response.bills);
        lastPage = response.meta.lastPage;
        page++;
      } while (page <= lastPage);
      bills.assignAll(allBills);
    } catch (e) {
      AppSnackbar.showError(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggleView() {
    if (currentView.value == CalendarView.month) {
      currentView.value = CalendarView.week;
      calendarController.view = CalendarView.week;
    } else {
      currentView.value = CalendarView.month;
      calendarController.view = CalendarView.month;
    }
  }

  List<Appointment> get appointments {
    return bills.map((bill) {
      final date = DateTime.tryParse(bill.date) ?? DateTime.now();
      final startParts = bill.startTime.split(':');
      final endParts = bill.endTime.split(':');
      final startHour = startParts.isNotEmpty ? int.tryParse(startParts[0]) ?? 8 : 8;
      final startMin = startParts.length > 1 ? int.tryParse(startParts[1]) ?? 0 : 0;
      final endHour = endParts.isNotEmpty ? int.tryParse(endParts[0]) ?? 9 : 9;
      final endMin = endParts.length > 1 ? int.tryParse(endParts[1]) ?? 0 : 0;

      return Appointment(
        startTime: DateTime(date.year, date.month, date.day, startHour, startMin),
        endTime: DateTime(date.year, date.month, date.day, endHour, endMin),
        subject: bill.event,
        notes: '${bill.clientName}|${bill.address}|${bill.code}|${bill.id}',
        color: const Color(0xFF4CAF50),
      );
    }).toList();
  }

  ShowBill? getBillById(int id) {
    return bills.firstWhereOrNull((b) => b.id == id);
  }
}