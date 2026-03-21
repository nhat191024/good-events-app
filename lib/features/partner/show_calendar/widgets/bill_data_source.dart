import 'package:syncfusion_flutter_calendar/calendar.dart';

class BillDataSource extends CalendarDataSource {
  BillDataSource(List<Appointment> source) {
    appointments = source;
  }
}
