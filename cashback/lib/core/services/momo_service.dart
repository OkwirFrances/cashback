abstract class MomoService {
  Future<String> initiatePayment({
    required String phoneNumber,
    required double amount,
    required String network, // 'MTN' or 'Airtel'
    String? description,
  });

  Future<bool> verifyPayment(String transactionId);

  Future<double> checkBalance(String phoneNumber, String network);

  Future<String> requestPayment({
    required String payerPhoneNumber,
    required double amount,
    required String network,
    String? reason,
  });

  Future<List<Map<String, dynamic>>> getTransactionHistory(
    String phoneNumber,
    String network,
  );
}
