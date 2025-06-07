import 'package:flutter/material.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/text_styles.dart';

class CashbackCard extends StatelessWidget {
  final double balance;
  final VoidCallback onTap;

  const CashbackCard({
    Key? key,
    required this.balance,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Balance',
                style: AppTextStyles.subtitle1.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                'UGX ${balance.toStringAsFixed(2)}',
                style: AppTextStyles.headline4.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'View Transactions',
                    style: AppTextStyles.caption.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
