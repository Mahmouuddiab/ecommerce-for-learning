import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: 4, // Shows 4 phantom loading placeholders across the row
      itemBuilder: (context, index) {
        return Column(
          children: [
            // Shimmer Circle Avatar
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300]!,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Shimmer Text Line
            Container(
              height: 10,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        );
      },
    );
  }
}