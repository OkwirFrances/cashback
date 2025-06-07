enum TransactionStatus {
  pending,
  completed,
  failed,
  refunded,
}

extension TransactionStatusExtension on TransactionStatus {
  String get name {
    switch (this) {
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.completed:
        return 'Completed';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.refunded:
        return 'Refunded';
    }
  }

  String get value {
    return toString().split('.').last;
  }

  static TransactionStatus fromString(String value) {
    return TransactionStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TransactionStatus.pending,
    );
  }
}
