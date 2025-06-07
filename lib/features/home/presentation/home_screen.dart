import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/providers/auth_provider.dart';
import '../../../../data/providers/deals_provider.dart';
import '../../../shared/widgets/cashback_card.dart';
import '../../../shared/widgets/offer_banner.dart';
import '../../../shared/widgets/merchant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final dealsProvider = Provider.of<DealsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashback Rewards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () {
              Navigator.pushNamed(context, '/wallet');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await dealsProvider.loadInitialData();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (authProvider.user != null)
                CashbackCard(
                  balance: authProvider.user!.walletBalance,
                  onTap: () {
                    Navigator.pushNamed(context, '/wallet');
                  },
                ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Special Offers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dealsProvider.activeOffers.length,
                  itemBuilder: (context, index) {
                    final offer = dealsProvider.activeOffers[index];
                    return OfferBanner(
                      offer: offer,
                      onTap: () {
                        // Navigate to offer details
                      },
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Featured Merchants',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: dealsProvider.featuredMerchants.length,
                itemBuilder: (context, index) {
                  final merchant = dealsProvider.featuredMerchants[index];
                  return MerchantCard(
                    merchant: merchant,
                    onTap: () {
                      // Navigate to merchant details
                    },
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
