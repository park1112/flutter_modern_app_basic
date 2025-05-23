import 'package:flutter/material.dart';

class AppColors {
  // Modern Primary Colors - Deep Purple & Teal Accent
  static const Color primary = Color(0xFF6366F1); // Modern Indigo
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primarySurface = Color(0xFFEEF2FF);

  // Accent Colors - Vibrant Teal
  static const Color accent = Color(0xFF14B8A6);
  static const Color accentDark = Color(0xFF0F766E);
  static const Color accentLight = Color(0xFF5EEAD4);
  static const Color accentSurface = Color(0xFFF0FDFA);

  // Secondary Colors - Warm Orange
  static const Color secondary = Color(0xFFF97316);
  static const Color secondaryDark = Color(0xFFEA580C);
  static const Color secondaryLight = Color(0xFFFB923C);
  static const Color secondarySurface = Color(0xFFFFF7ED);

  // Neutral Colors - Modern Gray Scale
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // Background Colors - Light Mode
  static const Color background = Color(0xFFFAFBFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color dialogBackground = Color(0xFFFFFFFF);

  // Background Colors - Dark Mode
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceVariantDark = Color(0xFF334155);
  static const Color dialogBackgroundDark = Color(0xFF1E293B);

  // Text Colors - Light Mode
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFFCBD5E1);

  // Text Colors - Dark Mode
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textTertiaryDark = Color(0xFF94A3B8);
  static const Color textDisabledDark = Color(0xFF475569);

  // Status Colors - Modern & Vibrant
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);
  static const Color successSurface = Color(0xFFECFDF5);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorSurface = Color(0xFFFEF2F2);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningSurface = Color(0xFFFFFBEB);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoSurface = Color(0xFFEFF6FF);

  // Chart Colors - Modern Palette
  static const Color chart1 = Color(0xFF6366F1);
  static const Color chart2 = Color(0xFF14B8A6);
  static const Color chart3 = Color(0xFFF59E0B);
  static const Color chart4 = Color(0xFFEF4444);
  static const Color chart5 = Color(0xFF8B5CF6);
  static const Color chart6 = Color(0xFF10B981);
  static const Color chart7 = Color(0xFFF97316);
  static const Color chart8 = Color(0xFF06B6D4);

  static const Color greyLight = Color(0xFFF3F4F6);
  static const Color greyDark = Color(0xFF1F2937);
  static const Color shadowLight = Color(0xFF000000);
  static const Color shadowMedium = Color(0xFF000000);
  static const Color shadowDark = Color(0xFF000000);
  static const Color shadowXL = Color(0xFF000000);
  static const Color glassWhite = Color(0xFFFFFFFF);
  static const Color glassLight = Color(0xFFFFFFFF);
  static const Color glassBorder = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF334155);

  // Modern Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5EEAD4), Color(0xFF14B8A6)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
  );

  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x0DFFFFFF), Color(0x1AFFFFFF)],
  );
}
