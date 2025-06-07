import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cashback_app/core/services/momo_service.dart';
import 'package:cashback_app/data/providers/wallet_provider.dart';

class MockMomoService extends Mock implements MomoService {}

void main() {
  late WalletProvider walletProvider;
  late MockMomoService mockMomoService;

  setUp(() {
    mockMomoService = MockMomoService();
    walletProvider = WalletProvider(mockMomoService);
  });

  test('withdraw success', () async {
    when(mockMomoService.initiatePayment(
      phoneNumber: '772123456',
      amount: 5000,
      network: 'MTN',
    )).thenAnswer((_) async => 'txn123');

    when(mockMomoService.verifyPayment('txn123')).thenAnswer((_) async => true);

    final result = await walletProvider.withdraw(5000, '772123456', 'MTN');

    expect(result, true);
    expect(
        walletProvider.balance, 7500.0); // Assuming initial balance was 12500
    expect(walletProvider.transactions.length, 1);
  });
}
