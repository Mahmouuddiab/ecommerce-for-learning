import 'package:ecommerce/core/params/address_params.dart';
import 'package:ecommerce/features/adresses/domain/entity/address_entity.dart';
import 'package:ecommerce/features/adresses/presentation/providers/address_providers.dart';
import 'package:ecommerce/shared/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _submitAddress() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final params = AddressParams(
        name: _nameController.text.trim(),
        details: _detailsController.text.trim(),
        phone: _phoneController.text.trim(),
        city: _cityController.text.trim(),
      );

      ref.read(addAddressControllerProvider.notifier).addAddress(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen<AsyncValue<AddressEntity?>>(
      addAddressControllerProvider,
          (previous, next) {
        next.whenOrNull(
          data: (address) {
            if (address != null) {
              CustomSnackBar.show(
                  context: context,
                  message: 'Address added successfully',
                  type: SnackBarType.success
              );
              Navigator.pop(context);
            }
          },
          error: (error, _) {
            CustomSnackBar.show(
                context: context,
                message: error.toString(),
                type: SnackBarType.error
            );
          },
        );
      },
    );

    final addressState = ref.watch(addAddressControllerProvider);
    final isLoading = addressState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Details',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Please fill in the information below to add a new delivery location.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: _nameController,
                  label: 'Address Label',
                  hint: 'e.g., Home, Office, Gym',
                  prefixIcon: Icons.bookmark_border_rounded,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an address label';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                _buildTextField(
                  controller: _cityController,
                  label: 'City',
                  hint: 'e.g., Giza, Cairo',
                  prefixIcon: Icons.location_city_rounded,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: 'e.g., 01270883103',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                _buildTextField(
                  controller: _detailsController,
                  label: 'Detailed Address',
                  hint: 'Street name, building number, apartment, floor...',
                  prefixIcon: Icons.home_outlined,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter detailed address information';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: isLoading ? null : _submitAddress,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: isLoading
                ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.onPrimary,
                ),
              ),
            )
                : const Text(
              'Save Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        alignLabelWithHint: maxLines > 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}