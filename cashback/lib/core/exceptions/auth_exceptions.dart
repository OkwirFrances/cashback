class AuthException implements Exception {
  final String message;
  final String code;

  AuthException(this.message, {this.code = 'unknown'});

  @override
  String toString() => 'AuthException: $message (code: $code)';
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException()
      : super('Email already in use', code: 'email-already-in-use');
}

class InvalidEmailException extends AuthException {
  InvalidEmailException()
      : super('Invalid email address', code: 'invalid-email');
}

class WrongPasswordException extends AuthException {
  WrongPasswordException() : super('Wrong password', code: 'wrong-password');
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super('User not found', code: 'user-not-found');
}

class WeakPasswordException extends AuthException {
  WeakPasswordException()
      : super('Password is too weak', code: 'weak-password');
}

class TooManyRequestsException extends AuthException {
  TooManyRequestsException()
      : super('Too many requests', code: 'too-many-requests');
}
