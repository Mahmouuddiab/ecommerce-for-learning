import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Wishlist', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Header Counter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saved Items',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '3 Items',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Wishlist Item 1: MacBook Pro
              Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      // Simulated product image block
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.laptop, size: 36, color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MacBook Pro 14"',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'M3 Chip / 16GB RAM',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '\$1,999.00',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      // Actions Column
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart, color: Theme.of(context).colorScheme.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Wishlist Item 2: Leather Jacket
              Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.checkroom, size: 36, color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Classic Leather Jacket',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Size: L / Black',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '\$249.00',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart, color: Theme.of(context).colorScheme.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Wishlist Item 3: Wireless Headphones
              Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.headset, size: 36, color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Wireless ANC Headphones',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Matte Black Edition',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '\$349.99',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart, color: Theme.of(context).colorScheme.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
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