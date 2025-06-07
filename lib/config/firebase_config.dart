import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
    if (kDebugMode) {
      // Enable Firebase emulator in debug mode
      await _setupEmulators();
    }
  }

  static Future<void> _setupEmulators() async {
    try {
      // Uncomment these lines if you're using Firebase emulators
      // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      // FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
    } catch (e) {
      debugPrint('Failed to setup Firebase emulators: $e');
    }
  }

  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseDatabase get database => FirebaseDatabase.instance;

  static DatabaseReference get usersRef => database.ref('users');
  static DatabaseReference get merchantsRef => database.ref('merchants');
  static DatabaseReference get offersRef => database.ref('offers');
  static DatabaseReference get transactionsRef => database.ref('transactions');
  static DatabaseReference get paymentsRef => database.ref('payments');

  static Future<void> configurePersistence() async {
    await database.setPersistenceEnabled(true);
    await database.setPersistenceCacheSizeBytes(10000000); // 10MB
  }
}
