import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/exceptions/auth_exceptions.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'too-many-requests':
          throw TooManyRequestsException();
        default:
          throw AuthException(e.message ?? 'Login failed', code: e.code);
      }
    }
  }

  @override
  Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        case 'weak-password':
          throw WeakPasswordException();
        case 'invalid-email':
          throw InvalidEmailException();
        default:
          throw AuthException(e.message ?? 'Registration failed', code: e.code);
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<String?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  @override
  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<String?> signInWithPhone(String phone, String verificationId) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: phone,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Phone login failed', code: e.code);
    }
  }

  @override
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(Exception) onError,
  ) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        onError(
            AuthException(e.message ?? 'Verification failed', code: e.code));
      },
      codeSent: (verificationId, _) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }
}
