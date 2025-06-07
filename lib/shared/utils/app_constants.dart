class AppConstants {
  // API Constants
  static const String apiBaseUrl = 'https://api.cashbackapp.com/v1';
  static const String mtnApiKey = 'mtn_api_key_placeholder';
  static const String airtelApiKey = 'airtel_api_key_placeholder';

  // App Constants
  static const String appName = 'Cashback Rewards';
  static const String appVersion = '1.0.0';
  static const int minPasswordLength = 6;
  static const double maxWithdrawalAmount = 1000000.0;

  // Local Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String darkModeKey = 'dark_mode';

  // Date Formats
  static const String dateFormat = 'dd MMM yyyy';
  static const String dateTimeFormat = 'dd MMM yyyy, hh:mm a';

  // Default Values
  static const String defaultCountryCode = 'UG';
  static const String defaultCurrency = 'UGX';
}
