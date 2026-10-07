/// Font family names declared in `pubspec.yaml`.
/// Single source of truth — never hardcode a family string in theme/widgets.
class AppFonts {
  const AppFonts._();

  /// Latin UI face (Inter static cuts with explicit weights).
  static const String inter = 'Inter';

  /// Arabic UI face (matches the Figma Arabic copy).
  static const String arabic = 'IBMPlexSansArabic';

  /// Primary stack: Latin first, Arabic fallback for non-Latin glyphs.
  static const List<String> primaryStack = [arabic];
}
