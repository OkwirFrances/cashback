import 'package:flutter/material.dart';
import '../../core/models/merchant_model.dart';
import '../../shared/styles/text_styles.dart';

class MerchantCard extends StatelessWidget {
  final MerchantModel merchant;
  final VoidCallback onTap;

  const MerchantCard({
    Key? key,
    required this.merchant,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  merchant.logoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    merchant.name,
                    style: AppTextStyles.subtitle1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${merchant.cashbackRate.toStringAsFixed(1)}% cashback',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
