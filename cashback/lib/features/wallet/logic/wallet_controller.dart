import 'package:flutter/foundation.dart';
import '../../../../core/models/transaction_model.dart';
import '../../../../data/repositories/cashback_repository.dart';

class WalletController with ChangeNotifier {
  final CashbackRepository _repository;
  double _balance = 0.0;
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _error;

  WalletController(this._repository);

  double get balance => _balance;
  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadWalletData(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _balance = await _repository.getWalletBalance(userId);
      _transactions = await _repository.getUserTransactions(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> withdrawFunds({
    required String userId,
    required double amount,
    required String phone,
    required String network,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.withdrawFunds(
        userId: userId,
        amount: amount,
        phone: phone,
        network: network,
      );
      await loadWalletData(userId);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
