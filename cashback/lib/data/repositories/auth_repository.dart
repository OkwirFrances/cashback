import 'package:flutter/foundation.dart';
import '../../core/models/user_model.dart';
import '../../core/services/auth_service.dart';
import '../../core/exceptions/auth_exceptions.dart';

class AuthRepository {
  final AuthService _authService;
  final LocalStorage _localStorage;

  AuthRepository(this._authService, this._localStorage);

  Future<UserModel> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userId =
          await _authService.signInWithEmailAndPassword(email, password);
      if (userId == null) throw AuthException('Login failed');

      final user = await _authService.getUserData(userId);
      await _localStorage.saveAuthToken('token_$userId');
      await _localStorage.saveUserData(user.toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Login failed', code: e.code);
    }
  }

  Future<UserModel> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final userId =
          await _authService.registerWithEmailAndPassword(email, password);
      if (userId == null) throw AuthException('Registration failed');

      final user = UserModel(
        id: userId,
        name: name,
        email: email,
        phone: phone,
        walletBalance: 0.0,
        createdAt: DateTime.now(),
      );

      await _authService.updateUserProfile(user.toMap());
      await _localStorage.saveAuthToken('token_$userId');
      await _localStorage.saveUserData(user.toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Registration failed', code: e.code);
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    await _localStorage.clearAuthToken();
    await _localStorage.clearUserData();
  }

  Future<UserModel?> getCurrentUser() async {
    final userId = _authService.getCurrentUserId();
    if (userId == null) return null;

    try {
      final localData = _localStorage.getUserData();
      if (localData != null) {
        return UserModel.fromMap(localData);
      }

      return await _authService.getUserData(userId);
    } catch (e) {
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }
}
