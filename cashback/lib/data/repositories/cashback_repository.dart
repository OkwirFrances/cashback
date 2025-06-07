import 'package:flutter/foundation.dart';
import '../../core/models/merchant_model.dart';
import '../../core/models/offer_model.dart';
import '../../core/models/transaction_model.dart';
import '../../core/exceptions/payment_exceptions.dart';

class CashbackRepository {
  final ApiClient _apiClient;
  final MomoService _momoService;

  CashbackRepository(this._apiClient, this._momoService);

  // Merchant Operations
  Future<List<MerchantModel>> getFeaturedMerchants() async {
    return await _apiClient.getFeaturedMerchants();
  }

  Future<List<MerchantModel>> getNearbyMerchants(double lat, double lng) async {
    // In a real app, this would query based on location
    final allMerchants = await _apiClient.getFeaturedMerchants();
    return allMerchants.take(5).toList();
  }

  // Offer Operations
  Future<List<OfferModel>> getActiveOffers() async {
    return await _apiClient.getActiveOffers();
  }

  Future<List<OfferModel>> getMerchantOffers(String merchantId) async {
    final allOffers = await _apiClient.getActiveOffers();
    return allOffers.where((offer) => offer.merchantId == merchantId).toList();
  }

  // Transaction Operations
  Future<List<TransactionModel>> getUserTransactions(String userId) async {
    return await _apiClient.getUserTransactions(userId);
  }

  Future<void> addCashbackTransaction({
    required String userId,
    required String merchantId,
    required double amount,
    required double cashbackPercentage,
  }) async {
    final cashbackAmount = amount * (cashbackPercentage / 100);

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      type: 'cashback',
      amount: cashbackAmount,
      date: DateTime.now(),
      description: 'Cashback from purchase',
      merchantId: merchantId,
    );

    await _apiClient.addTransaction(transaction);
    await _apiClient.updateWalletBalance(userId, cashbackAmount);
  }

  // Wallet Operations
  Future<double> getWalletBalance(String userId) async {
    return await _apiClient.getUserWalletBalance(userId);
  }

  Future<String> withdrawFunds({
    required String userId,
    required double amount,
    required String phone,
    required String network,
  }) async {
    final balance = await getWalletBalance(userId);
    if (balance < amount) {
      throw InsufficientBalanceException();
    }

    final transactionId = await _momoService.initiatePayment(
      phoneNumber: phone,
      amount: amount,
      network: network,
    );

    final isVerified = await _momoService.verifyPayment(transactionId);
    if (!isVerified) {
      throw TransactionFailedException();
    }

    await _apiClient.updateWalletBalance(userId, -amount);
    return transactionId;
  }
}
