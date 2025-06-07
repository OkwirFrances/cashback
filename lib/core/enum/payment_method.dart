enum PaymentMethod {
  mtn,
  airtel,
  card,
  cash,
}

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.mtn:
        return 'MTN Mobile Money';
      case PaymentMethod.airtel:
        return 'Airtel Money';
      case PaymentMethod.card:
        return 'Credit/Debit Card';
      case PaymentMethod.cash:
        return 'Cash';
    }
  }

  String get value {
    return toString().split('.').last;
  }

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PaymentMethod.mtn,
    );
  }
}
