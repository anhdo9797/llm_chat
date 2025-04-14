import 'package:flutter/material.dart';

class AppTheme {
  // Light theme colors
  static final ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF059669), // Green
    onPrimary: Colors.white,
    secondary: const Color(0xFFF3F4F6), // Light gray
    onSecondary: const Color(0xFF111827), // Dark gray
    background: Colors.white,
    onBackground: const Color(0xFF111827),
    surface: Colors.white,
    onSurface: const Color(0xFF111827),
    surfaceVariant: const Color(0xFFF9FAFB), // Light grayish
    onSurfaceVariant: const Color(0xFF6B7280), // Medium gray
    outline: const Color(0xFFE5E7EB), // Border gray
    error: const Color(0xFFDC2626), // Red
    onError: Colors.white,
  );

  // Dark theme colors
  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF10B981), // Light green
    onPrimary: Colors.white,
    secondary: const Color(0xFF1F2937), // Dark gray
    onSecondary: Colors.white,
    background: const Color(0xFF111827), // Very dark gray
    onBackground: Colors.white,
    surface: const Color(0xFF1F2937),
    onSurface: Colors.white,
    surfaceVariant: const Color(0xFF374151), // Medium dark gray
    onSurfaceVariant: const Color(0xFF9CA3AF), // Light gray
    outline: const Color(0xFF4B5563), // Border gray
    error: const Color(0xFFEF4444), // Light red
    onError: Colors.white,
  );

  // Theme getters
  static ThemeData get lightTheme => _getTheme(_lightColorScheme);
  static ThemeData get darkTheme => _getTheme(_darkColorScheme);

  static ThemeData _getTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      fontFamily: 'OpenSans',
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceVariant,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      useMaterial3: true,
    );
  }
}
