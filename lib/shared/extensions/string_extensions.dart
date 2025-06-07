import 'package:intl/intl.dart';

extension StringExtensions on String {
  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  String get capitalizeEachWord {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalizeFirst).join(' ');
  }

  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool get isPhoneNumber {
    return RegExp(r'^[0-9]{9,15}$').hasMatch(this);
  }

  String formatCurrency({String symbol = 'UGX '}) {
    final number = double.tryParse(this);
    if (number == null) return this;
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: number.truncateToDouble() == number ? 0 : 2,
    ).format(number);
  }

  String truncateWithEllipsis(int maxLength) {
    return length <= maxLength ? this : '${substring(0, maxLength)}...';
  }
}
