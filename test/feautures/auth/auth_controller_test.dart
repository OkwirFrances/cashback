import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cashback_app/core/services/auth_service.dart';
import 'package:cashback_app/data/providers/auth_provider.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthProvider authProvider;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authProvider = AuthProvider(mockAuthService);
  });

  test('login success', () async {
    when(mockAuthService.signInWithEmailAndPassword(
            'test@test.com', 'password'))
        .thenAnswer((_) async => 'user123');

    final result = await authProvider.login('test@test.com', 'password');

    expect(result, true);
    expect(authProvider.user?.id, 'user123');
    expect(authProvider.error, isNull);
  });

  test('login failure', () async {
    when(mockAuthService.signInWithEmailAndPassword('test@test.com', 'wrong'))
        .thenThrow(Exception('Invalid credentials'));

    final result = await authProvider.login('test@test.com', 'wrong');

    expect(result, false);
    expect(authProvider.user, isNull);
    expect(authProvider.error, isNotNull);
  });
}
