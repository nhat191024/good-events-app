import 'package:intl/intl.dart';

class FormatUtils {
  static String formatCurrency(int value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}Tỷ Đ';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}Tr Đ';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}k Đ';
    }
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'Đ').format(value);
  }

  /// Format currency with comma every 3 digits and with currency symbol at the end
  static String formatCurrencyToDoule(int value) {
    return '${NumberFormat('#,##0', 'vi_VN').format(value)} Đ';
  }
}
