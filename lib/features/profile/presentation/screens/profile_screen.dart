import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/cache/cache_helper.dart';
import 'package:ecommerce/core/localization/translation_keys.dart';
import 'package:ecommerce/core/router/app_routes.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final theme = Theme.of(context);
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(TranslationKeys.profile.logoutTitle.tr()),
        content: Text(TranslationKeys.profile.logoutConfirmMessage.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              TranslationKeys.profile.cancel.tr(),
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
            child: Text(TranslationKeys.profile.logout.tr()),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      await CacheHelper.clearUserId();
      await CacheHelper.clearToken();
      ref.invalidate(userProfileProvider);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
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
          data: (profile) {
            final items = [
              if (profile.phone.isNotEmpty)
                _ProfileItem(
                  icon: Icons.phone_outlined,
                  title: TranslationKeys.profile.phone.tr(),
                  subtitle: profile.phone,
                ),
              if (profile.role.isNotEmpty)
                _ProfileItem(
                  icon: Icons.badge_outlined,
                  title: TranslationKeys.profile.role.tr(),
                  subtitle: profile.role.toUpperCase(),
                ),
              _ProfileItem(
                icon: Icons.favorite_outline_rounded,
                title: TranslationKeys.profile.wishlist.tr(),
                subtitle:
                '${profile.wishlist.length} ${TranslationKeys.profile.savedItemsSuffix.tr()}',
                onTap: () => Navigator.pushNamed(context, AppRoutes.wishlist),
              ),
              _ProfileItem(
                icon: Icons.location_on_outlined,
                title: TranslationKeys.profile.savedAddresses.tr(),
                subtitle:
                '${profile.addresses.length} ${TranslationKeys.profile.addressesSuffix.tr()}',
                onTap: () => Navigator.pushNamed(context, AppRoutes.savedAddress),
              ),
              _ProfileItem(
                icon: Icons.shield_outlined,
                title: TranslationKeys.profile.privacyPolicy.tr(),
                onTap: () => Navigator.pushNamed(context, AppRoutes.privacyPolicy),
              ),
              _ProfileItem(
                icon: Icons.chat_bubble_outline_rounded,
                title: TranslationKeys.profile.contactUs.tr(),
              ),
              _ProfileItem(
                icon: Icons.article_outlined,
                title: TranslationKeys.profile.termsOfService.tr(),
              ),
              _ProfileItem(
                icon: Icons.people_outline_rounded,
                title: TranslationKeys.profile.inviteFriends.tr(),
              ),
              _ProfileItem(
                icon: Icons.power_settings_new_rounded,
                title: TranslationKeys.profile.signOut.tr(),
                isDestructive: true,
                onTap: () => _handleLogout(context, ref),
              ),
            ];

            return Column(
              children: [
                // Profile Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    children: [
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
                            profile.name.isNotEmpty
                                ? profile.name[0].toUpperCase()
                                : TranslationKeys.profile.defaultAvatarLetter
                                .tr(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
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
                      IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 26,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.setting),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: theme.dividerColor.withValues(alpha: 0.1),
                ),

                // Navigation Options List
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    itemCount: items.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 2.5,
                      indent: 20,
                      endIndent: 20,
                      color: theme.dividerColor.withValues(alpha: 0.1),
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                        leading: Icon(
                          item.icon,
                          color: item.isDestructive
                              ? theme.colorScheme.error
                              : AppColors.primary,
                          size: 26,
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: item.isDestructive
                                ? theme.colorScheme.error
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                        subtitle: item.subtitle != null
                            ? Text(
                          item.subtitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.hintColor,
                          ),
                        )
                            : null,
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: theme.colorScheme.outlineVariant,
                          size: 20,
                        ),
                        onTap: item.onTap,
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
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
                    TranslationKeys.profile.failedToLoadProfile.tr(),
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
                    label: Text(TranslationKeys.profile.tryAgain.tr()),
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

class _ProfileItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isDestructive;

  const _ProfileItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isDestructive = false,
  });
}