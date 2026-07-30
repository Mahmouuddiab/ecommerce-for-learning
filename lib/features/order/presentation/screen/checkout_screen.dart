import 'package:ecommerce/core/params/review_params.dart';
import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';
import 'package:ecommerce/features/adresses/presentation/providers/address_providers.dart';
import 'package:ecommerce/features/order/domain/entity/order_entity.dart';
import 'package:ecommerce/features/order/presentation/riverpod/order_providers.dart';
import 'package:ecommerce/features/reviews/presentation/riverpod/review_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

final selectedAddressIdProvider = StateProvider<String?>((ref) => null);

class CheckoutScreen extends ConsumerWidget {
  final String cartId;

  const CheckoutScreen({super.key, required this.cartId});

  void _showAddReviewDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AddReviewDialog(productId: orderId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<OrderEntity?>>(orderControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (order) {
          if (order != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order Created Successfully! ID: ${order.id}'),
                backgroundColor: Colors.green,
              ),
            );
            // Open review dialog on successful order
            _showAddReviewDialog(context, order.id);
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    final addressesAsync = ref.watch(getSavedAddressesProvider);
    final orderState = ref.watch(orderControllerProvider);
    final selectedAddressId = ref.watch(selectedAddressIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: addressesAsync.when(
        data: (rawAddresses) {
          final List<SavedAddressEntity> addresses =
          rawAddresses.cast<SavedAddressEntity>();
          if (addresses.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_off_outlined,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'No saved addresses found.\nPlease add an address before placing an order.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/add-address'),
                      icon: const Icon(Icons.add),
                      label: const Text('Add New Address'),
                    ),
                  ],
                ),
              ),
            );
          }

          final String activeSelectedId = selectedAddressId ?? addresses.first.id;

          final SavedAddressEntity selectedAddress = addresses.firstWhere(
                (addr) => addr.id == activeSelectedId,
            orElse: () => addresses.first,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: addresses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                  itemBuilder: (context, index) {
                    final address = addresses[index];
                    final isSelected = address.id == activeSelectedId;

                    return Card(
                      elevation: isSelected ? 3 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: RadioListTile<String>(
                        value: address.id,
                        groupValue: activeSelectedId,
                        onChanged: (val) {
                          if (val != null) {
                            ref.read(selectedAddressIdProvider.notifier).state = val;
                          }
                        },
                        title: Text(
                          address.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${address.details}, ${address.city}'),
                              const SizedBox(height: 4),
                              Text(
                                address.phone,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Checkout Button Section
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: orderState.isLoading
                          ? null
                          : () {
                        ref
                            .read(orderControllerProvider.notifier)
                            .createCashOrder(
                          cartId: cartId,
                          details: selectedAddress.details,
                          phone: selectedAddress.phone,
                          city: selectedAddress.city,
                        );
                      },
                      child: orderState.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Place Cash Order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading addresses: $error'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.invalidate(getSavedAddressesProvider),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// ADD REVIEW DIALOG WIDGET
// =============================================================================


class AddReviewDialog extends ConsumerStatefulWidget {
  final String productId;

  const AddReviewDialog({super.key, required this.productId});

  @override
  ConsumerState<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends ConsumerState<AddReviewDialog> {
  final _commentController = TextEditingController();
  int _selectedRating = 5;

  final List<String> _ratingLabels = [
    'Terrible',
    'Bad',
    'Okay',
    'Good',
    'Excellent!'
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewState = ref.watch(addReviewNotifierProvider);
    final theme = Theme.of(context);

    // Listen for submission errors
    ref.listen(addReviewNotifierProvider, (prev, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text(next.error.toString())),
              ],
            ),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      elevation: 8,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Header Icon & Title
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.rate_review_rounded,
                  size: 36,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'How was your experience?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Your rating helps us improve our products.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),

              // 2. Rating Stars Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final ratingValue = index + 1;
                  final isSelected = ratingValue <= _selectedRating;

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        _selectedRating = ratingValue;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(
                        isSelected
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: isSelected
                            ? Colors.amber.shade600
                            : Colors.grey.shade300,
                        size: 38,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 6),

              // Dynamic Rating Label Text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  _ratingLabels[_selectedRating - 1],
                  key: ValueKey(_selectedRating),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade800,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 3. Custom Review TextField
              TextField(
                controller: _commentController,
                maxLines: 3,
                maxLength: 250,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Write your review here (optional)...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: const EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: theme.primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 4. Action Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: reviewState.isLoading
                          ? null
                          : () {
                        Navigator.of(context).pop();
                        if (context.canPop()) context.pop();
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: reviewState.isLoading
                          ? null
                          : () async {
                        final params = ReviewParams(
                          productId: widget.productId,
                          review: _commentController.text.trim(),
                          rating: _selectedRating,
                        );

                        final success = await ref
                            .read(addReviewNotifierProvider.notifier)
                            .addReview(params);

                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Review added successfully!'),
                                ],
                              ),
                              backgroundColor: Colors.green.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                          if (context.canPop()) context.pop();
                        }
                      },
                      child: reviewState.isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}