import 'package:flutter/material.dart';

/// Global theme-mode controller (light / dark) backing the welcome
/// header's ThemeSwitch. Registered as a singleton in DI.
class AppThemeController extends ValueNotifier<ThemeMode> {
  AppThemeController() : super(ThemeMode.system);

  bool get isDark => value == ThemeMode.dark;

  void toggle() {
    value = switch (value) {
      ThemeMode.dark => ThemeMode.light,
      _ => ThemeMode.dark,
    };
  }
}
