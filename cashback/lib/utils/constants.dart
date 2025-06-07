
class AppConstants {
  static const String appName = 'UG Cashback';
  static const String apiUrl = 'https://api.ugcashback.com/v1';
  static const String apiKey = 'your_api_key_here';
  
  // MTN Mobile Money API Constants
  static const String mtnApiKey = 'mtn_api_key';
  static const String mtnApiUrl = 'https://sandbox.momodeveloper.mtn.com';
  
  // Airtel Money API Constants
  static const String airtelApiKey = 'airtel_api_key';
  static const String airtelApiUrl = 'https://openapi.airtel.africa';
  
  static const List<String> ugandaNetworkPrefixes = [
    '70', '71', '72', '74', '75', '76', '77', '78', '79', // MTN
    '39', '41', '43', '58', '66', '67', '68', '69', // Airtel
    '31', '33', '34', '35', '36', '37', '38', // Africell
    '20', '21', '22', '23', '24', '25', '26', '27', '28', '29' // Uganda Telecom
  ];
}