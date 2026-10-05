/// Central image / asset paths. Single source of truth — never hardcode
/// an `assets/...` string in feature code.
class AppImages {
  const AppImages._();

  static const String _base = 'assets/images';
  static const String _translations = 'assets/translations';

  // Brand.
  static const String logoDark =
      '$_base/Tamen_logo.png';
  static const String logoLight =
      '$_base/tamenlogowithoutbackgroundlightmode.png';
  static const String logoWhiteBg =
      '$_base/Tamen_logo_white_bg.png';
  static const String appIcon = '$_base/app_icon.png';
  static const String splash = '$_base/splash_image.png';
  static const String splashDark = '$_base/splash_image_dark.png';

  // i18n bundle location (used by EasyLocalization in main).
  static const String translationsPath = _translations;
}
