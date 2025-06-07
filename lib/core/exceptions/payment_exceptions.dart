class PaymentException implements Exception {
  final String message;
  final String code;

  PaymentException(this.message, {this.code = 'unknown'});

  @override
  String toString() => 'PaymentException: $message (code: $code)';
}

class InsufficientBalanceException extends PaymentException {
  InsufficientBalanceException()
      : super('Insufficient balance', code: 'insufficient-balance');
}

class InvalidPhoneNumberException extends PaymentException {
  InvalidPhoneNumberException()
      : super('Invalid phone number', code: 'invalid-phone-number');
}

class TransactionFailedException extends PaymentException {
  TransactionFailedException()
      : super('Transaction failed', code: 'transaction-failed');
}

class NetworkNotSupportedException extends PaymentException {
  NetworkNotSupportedException()
      : super('Network not supported', code: 'network-not-supported');
}
