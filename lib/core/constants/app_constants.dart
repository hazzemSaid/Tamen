/// App-wide non-widget constants. No colors / sizes here —
/// those live in `TamenColors` and [AppConstraints].
class AppConstants {
  const AppConstants._();

  static const String appName = 'Tamen';
  static const String translationsPath = 'assets/translations';
  static const List<String> supportedLanguageCodes = ['en', 'ar'];

  // easy_localization keys are namespaced per feature (`auth.*`, ...).
  static const String defaultLocaleCode = 'en';
}
