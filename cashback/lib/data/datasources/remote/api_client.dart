import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/merchant_model.dart';
import '../../../core/models/offer_model.dart';
import '../../../core/models/transaction_model.dart';
import '../../../core/exceptions/auth_exceptions.dart';
import '../../../core/exceptions/payment_exceptions.dart';

class ApiClient {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User Operations
  Future<UserModel> getUserData(String userId) async {
    final snapshot = await _database.ref('users/$userId').get();
    if (!snapshot.exists) {
      throw UserNotFoundException();
    }
    return UserModel.fromMap(Map<String, dynamic>.from(snapshot.value as Map));
  }

  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> updates) async {
    await _database.ref('users/$userId').update(updates);
  }

  // Merchant Operations
  Future<List<MerchantModel>> getFeaturedMerchants() async {
    final snapshot = await _database
        .ref('merchants')
        .orderByChild('isFeatured')
        .equalTo(true)
        .limitToFirst(10)
        .get();

    if (!snapshot.exists) return [];

    final merchants = <MerchantModel>[];
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    data.forEach((key, value) {
      merchants.add(MerchantModel.fromMap(Map<String, dynamic>.from(value)));
    });
    return merchants;
  }

  // Offer Operations
  Future<List<OfferModel>> getActiveOffers() async {
    final now = DateTime.now().toIso8601String();
    final snapshot = await _database
        .ref('offers')
        .orderByChild('endDate')
        .startAt(now)
        .get();

    if (!snapshot.exists) return [];

    final offers = <OfferModel>[];
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    data.forEach((key, value) {
      offers.add(OfferModel.fromMap(Map<String, dynamic>.from(value)));
    });
    return offers;
  }

  // Transaction Operations
  Future<List<TransactionModel>> getUserTransactions(String userId) async {
    final snapshot = await _database
        .ref('transactions')
        .orderByChild('userId')
        .equalTo(userId)
        .limitToLast(50)
        .get();

    if (!snapshot.exists) return [];

    final transactions = <TransactionModel>[];
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    data.forEach((key, value) {
      transactions
          .add(TransactionModel.fromMap(Map<String, dynamic>.from(value)));
    });
    return transactions..sort((a, b) => b.date.compareTo(a.date));
  }

  // Wallet Operations
  Future<double> getUserWalletBalance(String userId) async {
    final snapshot = await _database.ref('users/$userId/walletBalance').get();
    return snapshot.value?.toDouble() ?? 0.0;
  }

  Future<void> updateWalletBalance(String userId, double amount) async {
    await _database.ref('users/$userId/walletBalance').set(amount);
  }

  // Payment Operations
  Future<String> initiateMomoPayment({
    required String userId,
    required String phone,
    required double amount,
    required String network,
  }) async {
    final transactionRef = _database.ref('transactions').push();

    final transaction = TransactionModel(
      id: transactionRef.key!,
      userId: userId,
      type: 'withdrawal',
      amount: -amount,
      date: DateTime.now(),
      description: 'Withdrawal to $network',
      reference:
          '${network.toUpperCase()}${DateTime.now().millisecondsSinceEpoch}',
      status: 'pending',
    );

    await transactionRef.set(transaction.toMap());

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    await transactionRef.update({'status': 'completed'});
    return transactionRef.key!;
  }
}
