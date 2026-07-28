import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/cache/cache_helper.dart';
import 'package:ecommerce/features/profile/presentation/providers/profile_providers.dart';
import 'package:ecommerce/features/auth/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  /// Handles user logout
  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final theme = Theme.of(context);
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: theme.hintColor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      // 1. Clear cached token and user ID
      await CacheHelper.clearUserId();
      await CacheHelper.clearToken();

      // 2. Invalidate profile provider state
      ref.invalidate(userProfileProvider);

      // 3. Navigate to Login Screen and clear route stack
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: profileAsync.when(
          data: (profile) => Column(
            children: [
              // Top Profile Header (Avatar + Name + Settings)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Row(
                  children: [
                    // Avatar Ring
                    Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2.5,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text(
                          profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'U',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // User Name & Main Email Display
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF102A43),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (profile.email.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              profile.email,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.hintColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Settings Icon
                    IconButton(
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Color(0xFF486581),
                        size: 26,
                      ),
                      onPressed: () {
                        // Navigate to Settings Screen
                      },
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, color: Color(0xFFF0F4F8)),

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  children: [
                    if (profile.phone.isNotEmpty)
                      _ProfileListTile(
                        icon: Icons.phone_outlined,
                        title: 'Phone',
                        subtitle: profile.phone,
                        onTap: () {},
                      ),
                    if (profile.role.isNotEmpty)
                      _ProfileListTile(
                        icon: Icons.badge_outlined,
                        title: 'Role',
                        subtitle: profile.role.toUpperCase(),
                        onTap: () {},
                      ),
                    _ProfileListTile(
                      icon: Icons.favorite_outline_rounded,
                      title: 'Wishlist',
                      subtitle: '${profile.wishlist.length} saved items',
                      onTap: () {
                        // Open Wishlist Screen
                      },
                    ),
                    _ProfileListTile(
                      icon: Icons.location_on_outlined,
                      title: 'Saved Addresses',
                      subtitle: '${profile.addresses.length} addresses',
                      onTap: () {
                        context.push('/saved-address');
                      },
                    ),
                    _ProfileListTile(
                      icon: Icons.shield_outlined,
                      title: 'Privacy policy',
                      onTap: () {},
                    ),
                    _ProfileListTile(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Contact us',
                      onTap: () {},
                    ),
                    _ProfileListTile(
                      icon: Icons.article_outlined,
                      title: 'Terms of Service',
                      onTap: () {},
                    ),
                    _ProfileListTile(
                      icon: Icons.people_outline_rounded,
                      title: 'Invite Friends',
                      onTap: () {},
                    ),
                    _ProfileListTile(
                      icon: Icons.power_settings_new_rounded,
                      title: 'Sign out',
                      onTap: () => _handleLogout(context, ref),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Loading State
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),

          // Error State
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load profile',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme.hintColor, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => ref.invalidate(userProfileProvider),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom ListTile component equipped with optional dynamic subtitles
class _ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ProfileListTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          leading: Icon(
            icon,
            color: AppColors.primary,
            size: 26,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF102A43),
            ),
          ),
          subtitle: subtitle != null
              ? Text(
            subtitle!,
            style: TextStyle(
              fontSize: 13,
              color: theme.hintColor,
            ),
          )
              : null,
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9FB3C8),
            size: 20,
          ),
          onTap: onTap,
        ),
        const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Color(0xFFF0F4F8),
        ),
      ],
    );
  }
}