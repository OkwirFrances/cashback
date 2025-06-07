extension StringExtensions on String {
  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
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
}

extension DateTimeExtensions on DateTime {
  String get formattedDate {
    return Helpers.formatDate(this);
  }

  String get formattedDateTime {
    return Helpers.formatDateTime(this);
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}

extension DoubleExtensions on double {
  String get currencyFormat {
    return Helpers.formatCurrency(this);
  }
}
