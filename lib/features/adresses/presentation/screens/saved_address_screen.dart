import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';
import 'package:ecommerce/features/adresses/presentation/providers/address_providers.dart';
import 'package:go_router/go_router.dart';

class SavedAddressScreen extends ConsumerWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<SavedAddressEntity?>>(
      deleteAddressControllerProvider,
      (previous, next) {
        if (next.hasError && !next.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete address: ${next.error}'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (next.hasValue && next.value != null && !next.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Address deleted successfully!')),
          );
        }
      },
    );

    final addressesAsync = ref.watch(getSavedAddressesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Addresses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(getSavedAddressesProvider),
          ),
        ],
      ),
      body: addressesAsync.when(
        data: (addresses) {
          if (addresses.isEmpty) {
            return const _EmptyAddressView();
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(getSavedAddressesProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: addresses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                final address = addresses[index];
                return _AddressCard(address: address);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _ErrorView(
          errorMessage: error.toString(),
          onRetry: () => ref.invalidate(getSavedAddressesProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/add-address');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add New Address'),
      ),
    );
  }
}

class _AddressCard extends ConsumerWidget {
  final SavedAddressEntity address;

  const _AddressCard({required this.address});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteState = ref.watch(deleteAddressControllerProvider);
    final isDeleting = deleteState.isLoading;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  address.name.toLowerCase() == 'home'
                      ? Icons.home_outlined
                      : Icons.work_outline,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8.0),
                Text(
                  address.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (isDeleting)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  )
                else
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => _confirmDelete(context, ref),
                  ),
              ],
            ),
            const Divider(height: 16.0),
            Text(
              '${address.details}, ${address.city}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
            ),
            const SizedBox(height: 6.0),
            Row(
              children: [
                const Icon(
                  Icons.phone_outlined,
                  size: 16.0,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6.0),
                Text(
                  address.phone,
                  style: const TextStyle(fontSize: 13.0, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Are you sure you want to delete "${address.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ref
                  .read(deleteAddressControllerProvider.notifier)
                  .deleteAddress(address.id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _EmptyAddressView extends StatelessWidget {
  const _EmptyAddressView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.location_off_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No saved addresses found',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _ErrorView({required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
