import 'package:flutter/material.dart';

import '../constants/app_fonts.dart';
import 'app_colors.dart';

/// Tamen light + dark themes (Material 3) built from [TamenColors].
/// See `docs/designsystem.md` §§5-6, §44.
///
/// Brand core: Midnight Navy `#071724`, Lime `#BDF75C`, Soft White `#F7F7F7`.
/// Semantic statuses (--t-ok/warn/alert/info) live in [TamenSemantics]
/// because [ColorScheme] has no slots for them.
class TamenTheme {
  const TamenTheme._();

  /// Applies the `pubspec.yaml` font stack to every text style so no
  /// Material default (Roboto) leaks in — including AppBar, buttons,
  /// inputs, dialogs and snackbars that read [TextTheme] directly.
  static TextTheme _fontTextTheme(TextTheme base) {
    TextStyle? withFont(TextStyle? style) => style?.copyWith(
          fontFamily: AppFonts.inter,
          fontFamilyFallback: AppFonts.primaryStack,
        );
    return TextTheme(
      displayLarge: withFont(base.displayLarge),
      displayMedium: withFont(base.displayMedium),
      displaySmall: withFont(base.displaySmall),
      headlineLarge: withFont(base.headlineLarge),
      headlineMedium: withFont(base.headlineMedium),
      headlineSmall: withFont(base.headlineSmall),
      titleLarge: withFont(base.titleLarge),
      titleMedium: withFont(base.titleMedium),
      titleSmall: withFont(base.titleSmall),
      bodyLarge: withFont(base.bodyLarge),
      bodyMedium: withFont(base.bodyMedium),
      bodySmall: withFont(base.bodySmall),
      labelLarge: withFont(base.labelLarge),
      labelMedium: withFont(base.labelMedium),
      labelSmall: withFont(base.labelSmall),
    );
  }

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      // --t-primary #BDF75C + --t-fg #071724 (contrast rule §7).
      primary: TamenColors.lightPrimary,
      onPrimary: TamenColors.lightFg,
      // --t-tint #EAF6D6 + on-container #253A28.
      primaryContainer: TamenColors.lightTint,
      onPrimaryContainer: TamenColors.lightOnPrimaryContainer,
      // --t-surface #FFFFFF / --t-fg #071724.
      surface: TamenColors.lightSurface,
      onSurface: TamenColors.lightFg,
      // --t-raised #EDF0F2 / --t-sub #435360.
      surfaceContainerHighest: TamenColors.lightRaised,
      onSurfaceVariant: TamenColors.lightSub,
      // --t-line #D9E0E5.
      outline: TamenColors.lightLine,
      outlineVariant: TamenColors.lightLine,
      // --t-alert #A23E38.
      error: TamenColors.lightAlert,
      onError: TamenColors.lightSurface,
      errorContainer: TamenColors.lightTint,
      onErrorContainer: TamenColors.lightAlert,
      // Supporting green + info (§§5,15).
      secondary: TamenColors.forest, // #46651F
      onSecondary: TamenColors.softWhite,
      secondaryContainer: TamenColors.lightTint,
      onSecondaryContainer: TamenColors.lightOnPrimaryContainer,
      tertiary: TamenColors.lightInfo, // --t-info #326773
      onTertiary: TamenColors.lightSurface,
      tertiaryContainer: TamenColors.lightTint,
      onTertiaryContainer: TamenColors.lightInfo,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // --t-bg #F7F7F7.
      scaffoldBackgroundColor: TamenColors.lightBg,
      // Design system §8: yaml-declared Inter first, Arabic fallback.
      fontFamily: AppFonts.inter,
      fontFamilyFallback: AppFonts.primaryStack,
      textTheme: _fontTextTheme(ThemeData.light().textTheme),
      extensions: const [TamenSemantics.light],
      dividerTheme: const DividerThemeData(
        color: TamenColors.lightLine,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(
        color: TamenColors.lightFg,
        size: 24,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: TamenColors.lightSurface,
        foregroundColor: TamenColors.lightFg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: TamenColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: TamenColors.lightLine),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: TamenColors.lightRaised,
        selectedColor: TamenColors.lightTint,
        disabledColor: TamenColors.lightRaised,
        labelStyle: const TextStyle(
          color: TamenColors.lightFg,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: const TextStyle(color: TamenColors.lightSub),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: const BorderSide(color: TamenColors.lightLine),
        ),
        side: const BorderSide(color: TamenColors.lightLine),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: TamenColors.lightPrimary,
          foregroundColor: TamenColors.lightFg,
          disabledBackgroundColor: TamenColors.lightRaised,
          disabledForegroundColor: TamenColors.lightSub,
          minimumSize: const Size(0, 48),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 21 / 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: TamenColors.lightFg,
          side: const BorderSide(color: TamenColors.lightLine),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: TamenColors.lightFg,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TamenColors.lightSurface,
        hintStyle: const TextStyle(color: TamenColors.lightSub),
        labelStyle: const TextStyle(color: TamenColors.lightSub),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TamenColors.lightLine),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TamenColors.lightPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TamenColors.lightAlert),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TamenColors.lightAlert, width: 2),
        ),
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: TamenColors.lightFg,
        contentTextStyle: TextStyle(color: TamenColors.lightSurface),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: TamenColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: TamenColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      // --t-primary stays #BDF75C in dark (§40).
      primary: TamenColors.darkPrimary,
      onPrimary: TamenColors.midnightNavy,
      // --t-tint dark #253A28 + lime content.
      primaryContainer: TamenColors.darkTint,
      onPrimaryContainer: TamenColors.darkSuccess,
      // --t-surface #102432 / --t-fg #F7F7F7.
      surface: TamenColors.darkSurface,
      onSurface: TamenColors.darkFg,
      // --t-raised #193240 / --t-sub #B5C4CF.
      surfaceContainerHighest: TamenColors.darkRaised,
      onSurfaceVariant: TamenColors.darkSub,
      // --t-line #304856.
      outline: TamenColors.darkLine,
      outlineVariant: TamenColors.darkLine,
      // --t-alert dark #EEAAA2.
      error: TamenColors.darkAlert,
      onError: TamenColors.midnightNavy,
      errorContainer: TamenColors.darkTint,
      onErrorContainer: TamenColors.darkAlert,
      secondary: TamenColors.darkSuccess, // --t-ok dark #BDF75C
      onSecondary: TamenColors.midnightNavy,
      secondaryContainer: TamenColors.darkTint,
      onSecondaryContainer: TamenColors.darkSuccess,
      tertiary: TamenColors.darkInfo, // --t-info dark #A1CBD3
      onTertiary: TamenColors.midnightNavy,
      tertiaryContainer: TamenColors.darkTint,
      onTertiaryContainer: TamenColors.darkInfo,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // --t-bg dark #071724 (never pure black, §40).
      scaffoldBackgroundColor: TamenColors.darkBg,
      // Design system §8: yaml-declared Inter first, Arabic fallback.
      fontFamily: AppFonts.inter,
      fontFamilyFallback: AppFonts.primaryStack,
      textTheme: _fontTextTheme(ThemeData.dark().textTheme),
      extensions: const [TamenSemantics.dark],
      dividerTheme: const DividerThemeData(
        color: TamenColors.darkLine,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(
        color: TamenColors.darkFg,
        size: 24,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: TamenColors.darkSurface,
        foregroundColor: TamenColors.darkFg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: TamenColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: TamenColors.darkLine),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: TamenColors.darkRaised,
        selectedColor: TamenColors.darkTint,
        disabledColor: TamenColors.darkRaised,
        labelStyle: const TextStyle(
          color: TamenColors.darkFg,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: const TextStyle(color: TamenColors.darkSub),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: const BorderSide(color: TamenColors.darkLine),
        ),
        side: const BorderSide(color: TamenColors.darkLine),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: TamenColors.darkPrimary,
          foregroundColor: TamenColors.midnightNavy,
          disabledBackgroundColor: TamenColors.darkRaised,
          disabledForegroundColor: TamenColors.darkSub,
          minimumSize: const Size(0, 48),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 21 / 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: TamenColors.darkFg,
          side: const BorderSide(color: TamenColors.darkLine),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: TamenColors.darkFg,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TamenColors.darkSurface,
        hintStyle: const TextStyle(color: TamenColors.darkSub),
        labelStyle: const TextStyle(color: TamenColors.darkSub),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TamenColors.darkLine),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TamenColors.darkPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TamenColors.darkAlert),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TamenColors.darkAlert, width: 2),
        ),
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: TamenColors.darkRaised,
        contentTextStyle: TextStyle(color: TamenColors.darkFg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: TamenColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: TamenColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }
}
