import 'package:intl/intl.dart';

class Helpers {
  static String formatCurrency(double amount, {String symbol = 'UGX '}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: amount.truncateToDouble() == amount ? 0 : 2,
    ).format(amount);
  }

  static String formatDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  static String truncateWithEllipsis(String text, int maxLength) {
    return (text.length <= maxLength)
        ? text
        : '${text.substring(0, maxLength)}...';
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String formatPhoneNumber(String phone) {
    if (phone.startsWith('256')) {
      return '+$phone';
    }
    if (phone.startsWith('0')) {
      return '+256${phone.substring(1)}';
    }
    return phone;
  }
}
