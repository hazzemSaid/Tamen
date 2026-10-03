import 'package:flutter/material.dart';

/// Raw Tamen color tokens, taken 1:1 from the Figma "Group 1" sheet.
/// See `docs/designsystem.md` §44. Consume via `TamenTheme`,
/// never raw in feature pages.
class TamenColors {
  const TamenColors._();

  // Brand core.
  static const midnightNavy = Color(0xFF071724);
  static const lime = Color(0xFFBDF75C);
  static const softWhite = Color(0xFFF7F7F7);
  static const forest = Color(0xFF46651F);
  static const muted = Color(0xFF526B38);

  // Light.
  static const lightBg = Color(0xFFF7F7F7);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightRaised = Color(0xFFEDF0F2);
  static const lightFg = Color(0xFF071724);
  static const lightSub = Color(0xFF435360);
  static const lightLine = Color(0xFFD9E0E5);
  static const lightPrimary = Color(0xFFBDF75C);
  static const lightTint = Color(0xFFEAF6D6);
  static const lightSuccess = Color(0xFF46651F);
  static const lightWarning = Color(0xFF875514);
  static const lightAlert = Color(0xFFA23E38);
  static const lightInfo = Color(0xFF326773);
  static const lightOnPrimaryContainer = Color(0xFF253A28);

  // Dark.
  static const darkBg = Color(0xFF071724);
  static const darkSurface = Color(0xFF102432);
  static const darkRaised = Color(0xFF193240);
  static const darkFg = Color(0xFFF7F7F7);
  static const darkSub = Color(0xFFB5C4CF);
  static const darkLine = Color(0xFF304856);
  static const darkPrimary = Color(0xFFBDF75C);
  static const darkTint = Color(0xFF253A28);
  static const darkSuccess = Color(0xFFBDF75C);
  static const darkWarning = Color(0xFFE8BD79);
  static const darkAlert = Color(0xFFEEAAA2);
  static const darkInfo = Color(0xFFA1CBD3);
}
