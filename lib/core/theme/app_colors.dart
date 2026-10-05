import 'package:flutter/material.dart';

/// Raw Tamen color tokens, taken 1:1 from the Figma "Group 1" sheet.
/// See `docs/designsystem.md` §44. Consume via `TamenTheme`,
/// never raw in feature pages.
///
/// Token map (light / dark):
/// | Token       | Light     | Dark      |
/// | --t-bg      | #F7F7F7    | #071724   |
/// | --t-surface | #FFFFFF    | #102432   |
/// | --t-raised  | #EDF0F2    | #193240   |
/// | --t-fg      | #071724    | #F7F7F7   |
/// | --t-sub     | #435360    | #B5C4CF   |
/// | --t-line    | #D9E0E5    | #304856   |
/// | --t-primary | #BDF75C    | #BDF75C   |
/// | --t-tint    | #EAF6D6    | #253A28   |
/// | --t-ok      | #46651F    | #BDF75C   |
/// | --t-warn    | #875514    | #E8BD79   |
/// | --t-alert   | #A23E38    | #EEAAA2   |
/// | --t-info    | #326773    | #A1CBD3   |
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

/// Semantic status colors that have no direct Material [ColorScheme] slot
/// (--t-ok / --t-warn / --t-alert / --t-info).
///
/// Access via `Theme.of(context).extension<TamenSemantics>()`.
@immutable
class TamenSemantics extends ThemeExtension<TamenSemantics> {
  final Color ok;
  final Color warn;
  final Color alert;
  final Color info;

  const TamenSemantics({
    required this.ok,
    required this.warn,
    required this.alert,
    required this.info,
  });

  static const light = TamenSemantics(
    ok: TamenColors.lightSuccess, // --t-ok light #46651F
    warn: TamenColors.lightWarning, // --t-warn light #875514
    alert: TamenColors.lightAlert, // --t-alert light #A23E38
    info: TamenColors.lightInfo, // --t-info light #326773
  );

  static const dark = TamenSemantics(
    ok: TamenColors.darkSuccess, // --t-ok dark #BDF75C
    warn: TamenColors.darkWarning, // --t-warn dark #E8BD79
    alert: TamenColors.darkAlert, // --t-alert dark #EEAAA2
    info: TamenColors.darkInfo, // --t-info dark #A1CBD3
  );

  @override
  TamenSemantics copyWith({Color? ok, Color? warn, Color? alert, Color? info}) {
    return TamenSemantics(
      ok: ok ?? this.ok,
      warn: warn ?? this.warn,
      alert: alert ?? this.alert,
      info: info ?? this.info,
    );
  }

  @override
  TamenSemantics lerp(ThemeExtension<TamenSemantics>? other, double t) {
    if (other is! TamenSemantics) return this;
    return TamenSemantics(
      ok: Color.lerp(ok, other.ok, t)!,
      warn: Color.lerp(warn, other.warn, t)!,
      alert: Color.lerp(alert, other.alert, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
