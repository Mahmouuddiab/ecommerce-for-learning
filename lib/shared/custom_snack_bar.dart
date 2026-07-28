import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    IconData? customIcon,
    Duration duration = const Duration(seconds: 3),
    EdgeInsetsGeometry outerPadding =
    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    EdgeInsetsGeometry innerPadding =
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: outerPadding,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: CustomSnackBarWidget(
          message: message,
          type: type,
          customIcon: customIcon,
          innerPadding: innerPadding,
        ),
      ),
    );
  }
}

class CustomSnackBarWidget extends StatelessWidget {
  final String message;
  final SnackBarType type;
  final IconData? customIcon;
  final EdgeInsetsGeometry innerPadding;

  const CustomSnackBarWidget({
    super.key,
    required this.message,
    this.type = SnackBarType.info,
    this.customIcon,
    this.innerPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styleConfig = _getStyleConfig(theme, type);

    return Container(
      padding: innerPadding,
      decoration: BoxDecoration(
        color: styleConfig.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: styleConfig.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            customIcon ?? styleConfig.icon,
            color: styleConfig.iconColor,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: styleConfig.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _SnackBarConfig _getStyleConfig(ThemeData theme, SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarConfig(
          backgroundColor: const Color(0xFFE8F5E9),
          borderColor: const Color(0xFFA5D6A7),
          iconColor: const Color(0xFF2E7D32),
          textColor: const Color(0xFF1B5E20),
          icon: Icons.check_circle_rounded,
        );
      case SnackBarType.error:
        return _SnackBarConfig(
          backgroundColor: const Color(0xFFFFEBEE),
          borderColor: const Color(0xFFFFCDD2),
          iconColor: const Color(0xFFC62828),
          textColor: const Color(0xFFB71C1C),
          icon: Icons.error_rounded,
        );
      case SnackBarType.warning:
        return _SnackBarConfig(
          backgroundColor: const Color(0xFFFFF8E1),
          borderColor: const Color(0xFFFFE082),
          iconColor: const Color(0xFFF57F17),
          textColor: const Color(0xFFE65100),
          icon: Icons.warning_rounded,
        );
      case SnackBarType.info:
      default:
        return _SnackBarConfig(
          backgroundColor: theme.colorScheme.surfaceContainerHigh,
          borderColor: theme.dividerColor.withOpacity(0.2),
          iconColor: theme.colorScheme.primary,
          textColor: theme.colorScheme.onSurface,
          icon: Icons.info_rounded,
        );
    }
  }
}

class _SnackBarConfig {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final IconData icon;

  _SnackBarConfig({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
  });
}