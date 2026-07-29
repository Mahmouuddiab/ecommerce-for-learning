import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';
import 'package:ecommerce/features/adresses/presentation/providers/address_providers.dart';
import 'package:ecommerce/features/order/domain/entity/order_entity.dart';
import 'package:ecommerce/features/order/presentation/riverpod/order_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

final selectedAddressIdProvider = StateProvider<String?>((ref) => null);

class CheckoutScreen extends ConsumerWidget {
  final String cartId;

  const CheckoutScreen({super.key, required this.cartId});

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

              // 2. Checkout Button Section
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