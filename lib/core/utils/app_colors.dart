import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand
  static const Color primary = Color(0xFF0D2C6B);
  static const Color primaryDark = Color(0xFF091F4D);
  static const Color primaryLight = Color(0xFF1E4B9C);

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFF1A1A1A);
  static const Color cardBackground = primary;
  static const Color white = Colors.white;
  static const Color searchFieldBg = Colors.white; // Added missing search field background
  static const Color grey100 = Color(0xFFF5F5F5);

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color textOnLight = primary;

  // Icons
  static const Color iconMuted = Color(0xFF757575);

  // Status
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF9A825);
  static const Color info = Color(0xFF1976D2);

  // Borders / dividers
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFF424242);

  // Utility
  static const Color transparent = Colors.transparent;
  static const Color shadow = Color(0x1A000000);

  static const Color background = Color(0xFFFFFFFF);
  static const Color sidebarBg = Color(0xFFF4F6F9);
  static const Color chipBg = Color(0xFFF3F4F6);
  static const Color cccc = Color(0xFFEDF1F5);
  static const List<Color> bannerGradient = [
    Color(0xFF2F6FED),
    Color(0xFF1E3A8A),
  ];
}