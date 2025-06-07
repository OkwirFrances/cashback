import 'package:firebase_database/firebase_database.dart';
import '../../../core/services/momo_service.dart';
import '../../../core/exceptions/payment_exceptions.dart';

class FirebaseMomoService implements MomoService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Future<String> initiatePayment({
    required String phoneNumber,
    required double amount,
    required String network,
    String? description,
  }) async {
    try {
      if (!['MTN', 'Airtel'].contains(network)) {
        throw NetworkNotSupportedException();
      }

      final transactionRef = _database.child('payments').push();
      await transactionRef.set({
        'phoneNumber': phoneNumber,
        'amount': amount,
        'network': network,
        'description': description ?? 'Cashback withdrawal',
        'status': 'pending',
        'timestamp': ServerValue.timestamp,
      });

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      await transactionRef.update({
        'status': 'completed',
        'reference': '${network}_${DateTime.now().millisecondsSinceEpoch}',
      });

      return transactionRef.key!;
    } catch (e) {
      throw PaymentException('Payment initiation failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> verifyPayment(String transactionId) async {
    final snapshot = await _database.child('payments/$transactionId').get();
    if (!snapshot.exists) {
      throw TransactionFailedException();
    }
    final data = snapshot.value as Map<dynamic, dynamic>;
    return data['status'] == 'completed';
  }

  @override
  Future<double> checkBalance(String phoneNumber, String network) async {
    // In a real app, this would call the mobile money API
    // For demo purposes, we return a mock balance
    return 100000.0;
  }

  @override
  Future<String> requestPayment({
    required String payerPhoneNumber,
    required double amount,
    required String network,
    String? reason,
  }) async {
    try {
      final transactionRef = _database.child('paymentRequests').push();
      await transactionRef.set({
        'payerPhone': payerPhoneNumber,
        'amount': amount,
        'network': network,
        'reason': reason ?? 'Cashback payment',
        'status': 'pending',
        'timestamp': ServerValue.timestamp,
      });

      // Simulate payment request
      await Future.delayed(const Duration(seconds: 2));

      await transactionRef.update({
        'status': 'completed',
        'reference': 'REQ_${network}_${DateTime.now().millisecondsSinceEpoch}',
      });

      return transactionRef.key!;
    } catch (e) {
      throw PaymentException('Payment request failed: ${e.toString()}');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getTransactionHistory(
    String phoneNumber,
    String network,
  ) async {
    final snapshot = await _database
        .child('payments')
        .orderByChild('phoneNumber')
        .equalTo(phoneNumber)
        .get();

    if (!snapshot.exists) return [];

    final transactions = <Map<String, dynamic>>[];
    final data = snapshot.value as Map<dynamic, dynamic>;
    data.forEach((key, value) {
      final txData = Map<String, dynamic>.from(value);
      if (txData['network'] == network) {
        transactions.add(txData);
      }
    });
    return transactions;
  }
}
