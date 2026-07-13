import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand
  static const Color primary = Color(0xFF0D2C6B); // navy blue card
  static const Color primaryDark = Color(0xFF091F4D);
  static const Color primaryLight = Color(0xFF1E4B9C);

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFF1A1A1A); // dark screen bg
  static const Color cardBackground = primary;
  static const Color inputFill = Colors.white;

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Color(0xFF9E9E9E); // hint text / grey.shade500
  static const Color textOnLight = primary; // e.g. button label on white bg

  // Icons
  static const Color iconMuted = Color(0xFF757575); // grey.shade600

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
  static const Color shadow = Color(0x1A000000); // black at 10% opacity
}