import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/providers/wallet_provider.dart';
import '../../../shared/widgets/momo_payment_button.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet')),
      body: RefreshIndicator(
        onRefresh: () async {
          await walletProvider.loadWalletData('currentUserId');
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('Available Balance'),
                      Text(
                        'UGX ${walletProvider.balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/payout');
                              },
                              child: const Text('Withdraw'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to deposit screen
                              },
                              child: const Text('Deposit'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: walletProvider.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = walletProvider.transactions[index];
                  return ListTile(
                    leading: Icon(
                      transaction.amount > 0
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transaction.amount > 0 ? Colors.green : Colors.red,
                    ),
                    title: Text(transaction.description),
                    subtitle: Text(transaction.date.toString()),
                    trailing: Text(
                      'UGX ${transaction.amount.abs().toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            transaction.amount > 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
