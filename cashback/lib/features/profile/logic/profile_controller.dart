import 'package:flutter/foundation.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/cashback_repository.dart';

class ProfileController with ChangeNotifier {
  final AuthRepository _authRepository;
  final CashbackRepository _cashbackRepository;

  ProfileController(this._authRepository, this._cashbackRepository);

  Future<void> updateProfile(
      String userId, Map<String, dynamic> updates) async {
    try {
      await _authRepository.updateUserProfile(userId, updates);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(String userId, String newPassword) async {
    try {
      await _authRepository.changePassword(userId, newPassword);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getUserTransactions(String userId) async {
    try {
      return await _cashbackRepository.getUserTransactions(userId);
    } catch (e) {
      rethrow;
    }
  }
}
