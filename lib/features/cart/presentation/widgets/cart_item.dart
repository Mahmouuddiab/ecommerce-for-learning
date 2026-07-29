import 'package:ecommerce/features/cart/domain/entities/product_cart_entity.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final ProductCartEntity item;
  final VoidCallback? onDelete;
  final ValueChanged<int>? onQuantityChanged;

  const CartItem({super.key,
    required this.item,
    this.onDelete,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF004182); // RouteMisr / App Primary Blue

    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // 1. Product Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            child: Container(
              width: 120,
              height: double.infinity,
              color: Colors.grey.shade100,
              child: item.imageCover != null && item.imageCover!.isNotEmpty
                  ? Image.network(
                item.imageCover!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, color: Colors.grey),
              )
                  : const Icon(Icons.shopping_bag, color: Colors.grey),
            ),
          ),

          // 2. Details & Controls
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title + Delete Icon Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title.isNotEmpty ? item.title : 'Product',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onDelete,
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 22,
                        ),
                      ),
                    ],
                  ),

                  // Brand / Category Subtitle
                  Text(
                    item.brand?.name ?? item.category?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  // Price + Oval Quantity Controls Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Price
                      Text(
                        'EGP ${item.price}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}