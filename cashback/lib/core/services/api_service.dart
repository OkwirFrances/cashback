abstract class ApiService {
  Future<UserModel> getUserData(String userId);
  Future<List<MerchantModel>> getFeaturedMerchants();
  Future<List<OfferModel>> getActiveOffers();
  Future<List<TransactionModel>> getUserTransactions(String userId);
  Future<double> getUserWalletBalance(String userId);
  Future<void> updateUserProfile(String userId, Map<String, dynamic> updates);
}
