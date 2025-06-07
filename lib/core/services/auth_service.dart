abstract class AuthService {
  Future<String?> signInWithEmailAndPassword(String email, String password);
  Future<String?> registerWithEmailAndPassword(String email, String password);
  Future<String?> signInWithPhone(String phone, String verificationId);
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(Exception) onError,
  );
  Future<void> signOut();
  Stream<String?> get authStateChanges;
  String? getCurrentUserId();
  Future<void> sendPasswordResetEmail(String email);
}
