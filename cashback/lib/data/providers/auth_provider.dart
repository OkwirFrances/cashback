import 'package:flutter/foundation.dart';
import '../../core/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this._authRepository);

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initialize() async {
    _user = await _authRepository.getCurrentUser();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _authRepository.loginWithEmailAndPassword(email, password);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _authRepository.registerWithEmailAndPassword(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _user = null;
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authRepository.sendPasswordResetEmail(email);
  }
}
