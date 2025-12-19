import 'package:flutter/material.dart';

class AppColors {
  // =========================================================
  // CORE BRAND COLORS (Little Hearts Default)
  // Used for: Dashboard, Signup, Set Profile, Home
  // =========================================================
  static const Color primary = Color(0xFF61529F);
  static const Color primaryDark = Color(0xFF4E427F);
  static const Color primaryLight = Color(0xFF8A7CC4);

  // =========================================================
  // MODE-SPECIFIC COLORS
  // =========================================================

  /// Friend Mode
  static const Color friendMode = Color(0xFF5F8FFE);
  static const Color friendModeLight = Color(0xFF8FB0FF);
  static const Color friendModeDark = Color(0xFF3F6FD6);

  /// Date Mode
  static const Color dateMode = Color(0xFFF16586);
  static const Color dateModeLight = Color(0xFFF59BB0);
  static const Color dateModeDark = Color(0xFFD94B6B);

  /// Hangout Mode
  static const Color hangoutMode = Color(0xFF34C759);
  static const Color hangoutModeLight = Color(0xFF6EE08A);
  static const Color hangoutModeDark = Color(0xFF1E9E44);

  // =========================================================
  // BACKGROUNDS
  // =========================================================
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1E1E2E);
  static const Color onboardingBg = Color(0xFFB8A5D6);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // =========================================================
  // BUTTONS
  // =========================================================
  static const Color buttonPrimary = primary;
  static const Color buttonDisabled = Color(0xFFD1CBE8);
  static const Color buttonText = Colors.white;

  // =========================================================
  // TEXT COLORS
  // =========================================================
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textLink = Color(0xFF4A90D9);

  // =========================================================
  // NEUTRALS
  // =========================================================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyDark = Color(0xFF616161);

  // =========================================================
  // BORDERS & DIVIDERS
  // =========================================================
  static const Color borderLight = Color(0xFFE0E0E0);

  // =========================================================
  // STATUS COLORS
  // =========================================================
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);

  // Indicator Colors 
  static const Color indicatorActive = Color(0xFF6B4EAA); 
  static const Color indicatorInactive = Color(0xFFFFFFFF);
}
