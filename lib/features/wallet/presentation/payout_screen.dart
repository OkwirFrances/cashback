import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/providers/wallet_provider.dart';
import '../../../shared/widgets/momo_payment_button.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({Key? key}) : super(key: key);

  @override
  _PayoutScreenState createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedNetwork = 'MTN';

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Withdraw Funds')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Network',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MomoPaymentButton(
                      network: 'MTN',
                      isSelected: _selectedNetwork == 'MTN',
                      onPressed: () {
                        setState(() {
                          _selectedNetwork = 'MTN';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MomoPaymentButton(
                      network: 'Airtel',
                      isSelected: _selectedNetwork == 'Airtel',
                      onPressed: () {
                        setState(() {
                          _selectedNetwork = 'Airtel';
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: 'UGX ',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  if (double.parse(value) > walletProvider.balance) {
                    return 'Amount exceeds your balance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: '${_selectedNetwork} Phone Number',
                  hintText: 'e.g. 772123456',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  if (value.length != 9) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: walletProvider.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final success = await walletProvider.withdrawFunds(
                              userId: 'currentUserId',
                              amount: double.parse(_amountController.text),
                              phone: _phoneController.text,
                              network: _selectedNetwork,
                            );
                            if (success && mounted) {
                              Navigator.pop(context);
                            }
                          }
                        },
                  child: walletProvider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Withdraw'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
