class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.isEmail) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!value.isPhoneNumber) {
      return 'Enter a valid phone number (e.g. 772123456)';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Enter a valid amount';
    }
    if (amount <= 0) {
      return 'Amount must be greater than 0';
    }
    if (amount > AppConstants.maxWithdrawalAmount) {
      return 'Amount exceeds maximum withdrawal limit';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }
}
