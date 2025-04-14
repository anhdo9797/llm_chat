import 'package:flutter/material.dart';

/// Extension cho ColorScheme
extension ColorSchemeX on ColorScheme {
  // Background colors
  Color get background1 => surface; // Primary background
  Color get background2 => surfaceVariant; // Secondary background

  // Text colors
  Color get textPrimary => onSurface; // Primary text
  Color get textSecondary => onSurfaceVariant; // Secondary text

  // Border & Divider
  Color get border => outline;
  Color get divider => outline.withOpacity(0.1);

  // Message bubbles
  Color get messageBubbleUser => primary.withOpacity(0.1);
  Color get messageBubbleBot => surfaceVariant;

  // Buttons
  Color get buttonPrimary => primary;
  Color get buttonSecondary => secondary;

  // Interactive
  Color get hoverLight => onSurface.withOpacity(0.04);
  Color get hoverDark => onSurface.withOpacity(0.08);
  Color get pressed => onSurface.withOpacity(0.12);
}

/// Extension cho BuildContext
extension BuildContextX on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Spacing
  double get spacing => 8.0;
  double get spacingXS => 4.0;
  double get spacingS => 12.0;
  double get spacingL => 16.0;
  double get spacingXL => 24.0;
  double get spacingXXL => 32.0;

  // Screen size
  Size get screenSize => MediaQuery.of(this).size;
  double get width => screenSize.width;
  double get height => screenSize.height;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1200;
  bool get isDesktop => width >= 1200;

  // Padding
  EdgeInsets get paddingZero => EdgeInsets.zero;
  EdgeInsets get paddingXS => EdgeInsets.all(spacingXS);
  EdgeInsets get paddingS => EdgeInsets.all(spacingS);
  EdgeInsets get padding => EdgeInsets.all(spacing);
  EdgeInsets get paddingL => EdgeInsets.all(spacingL);
  EdgeInsets get paddingXL => EdgeInsets.all(spacingXL);
  EdgeInsets get paddingXXL => EdgeInsets.all(spacingXXL);

  // Border radius
  BorderRadius get radiusXS => BorderRadius.circular(4);
  BorderRadius get radiusS => BorderRadius.circular(8);
  BorderRadius get radius => BorderRadius.circular(12);
  BorderRadius get radiusL => BorderRadius.circular(16);
  BorderRadius get radiusXL => BorderRadius.circular(24);
  BorderRadius get radiusXXL => BorderRadius.circular(32);
}

/// Extension for TextStyles
extension TextStyleX on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.normal);

  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
  TextStyle withOpacity(double opacity) =>
      copyWith(color: color?.withOpacity(opacity));
  TextStyle withHeight(double height) => copyWith(height: height);
}
