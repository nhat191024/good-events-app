import 'package:intl/intl.dart';

class FormatUtils {
  static String formatCurrency(int value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}B đ';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}M đ';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}k đ';
    }
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(value);
  }
}
