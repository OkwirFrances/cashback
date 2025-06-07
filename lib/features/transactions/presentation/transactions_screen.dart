import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/providers/wallet_provider.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: RefreshIndicator(
        onRefresh: () async {
          await walletProvider.loadWalletData('currentUserId');
        },
        child: ListView.builder(
          itemCount: walletProvider.transactions.length,
          itemBuilder: (context, index) {
            final transaction = walletProvider.transactions[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
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
                    color: transaction.amount > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
