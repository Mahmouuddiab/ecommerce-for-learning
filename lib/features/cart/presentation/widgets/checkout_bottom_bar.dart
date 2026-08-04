import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/localization/translation_keys.dart';
import 'package:flutter/material.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double totalAmount;
  final VoidCallback? onCheckout;

  const CheckoutBottomBar({
    super.key,
    required this.totalAmount,
    this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF004182);

    // Formats numbers with commas (e.g., 3500 -> 3,500)
    final formattedPrice = totalAmount
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Total Price Section
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationKeys.cart.totalPrice.tr(),
                  style: const TextStyle(
                    color: Color(0xFF6E7489),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  TranslationKeys.cart.currencyEgp.tr(args: [formattedPrice]),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ],
            ),

            // Check Out Button
            ElevatedButton(
              onPressed: onCheckout ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TranslationKeys.cart.checkOut.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 24),
                  const Icon(
                    Icons.arrow_forward_sharp,
                    size: 20,
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