import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tamen light + dark themes (Material 3) built from [TamenColors].
/// See `docs/designsystem.md` §§5-6.
class TamenTheme {
  const TamenTheme._();

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: TamenColors.lightPrimary,
      onPrimary: TamenColors.lightFg,
      primaryContainer: TamenColors.lightTint,
      onPrimaryContainer: TamenColors.lightOnPrimaryContainer,
      surface: TamenColors.lightSurface,
      onSurface: TamenColors.lightFg,
      surfaceContainerHighest: TamenColors.lightRaised,
      onSurfaceVariant: TamenColors.lightSub,
      outline: TamenColors.lightLine,
      error: TamenColors.lightAlert,
      onError: TamenColors.lightSurface,
      secondary: TamenColors.forest,
      onSecondary: TamenColors.softWhite,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: TamenColors.lightBg,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: TamenColors.darkPrimary,
      onPrimary: TamenColors.midnightNavy,
      primaryContainer: TamenColors.darkTint,
      onPrimaryContainer: TamenColors.darkSuccess,
      surface: TamenColors.darkSurface,
      onSurface: TamenColors.darkFg,
      surfaceContainerHighest: TamenColors.darkRaised,
      onSurfaceVariant: TamenColors.darkSub,
      outline: TamenColors.darkLine,
      error: TamenColors.darkAlert,
      onError: TamenColors.midnightNavy,
      secondary: TamenColors.darkSuccess,
      onSecondary: TamenColors.midnightNavy,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: TamenColors.darkBg,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
