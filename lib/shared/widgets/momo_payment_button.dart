import 'package:flutter/material.dart';
import '../../shared/styles/colors.dart';

class MomoPaymentButton extends StatelessWidget {
  final String network;
  final bool isSelected;
  final VoidCallback onPressed;

  const MomoPaymentButton({
    Key? key,
    required this.network,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = network == 'MTN' ? AppColors.mtnYellow : AppColors.airtelRed;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? color : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor:
            isSelected ? color.withOpacity(0.1) : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/${network.toLowerCase()}.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '$network Mobile Money',
            style: TextStyle(
              color: isSelected ? color : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
