import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_theme_controller.dart';

/// Top 56h row from Figma: back button + [LanguageSwitch] + [ThemeSwitch].
/// Fully RTL-aware (Directional paddings, logical back icon).
class AuthHeader extends StatelessWidget {
  final AppThemeController themeController;
  final VoidCallback? onBack;

  const AuthHeader({super.key, required this.themeController, this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstraints.headerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _HeaderIconButton(
            icon: TamenIcons.backOf(context),
            semanticLabel: 'auth.back'.tr(),
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _LanguageSwitch(),
              const SizedBox(width: 8),
              _HeaderIconButton(
                icon: Theme.of(context).brightness == Brightness.dark
                    ? TamenIcons.sun
                    : TamenIcons.moon,
                semanticLabel: 'auth.toggleTheme'.tr(),
                onPressed: themeController.toggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final FaIconData icon;
  final String semanticLabel;
  final VoidCallback onPressed;

  const _HeaderIconButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: SizedBox(
        width: AppConstraints.iconButtonSize,
        height: AppConstraints.iconButtonSize,
        child: Material(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppConstraints.iconButtonRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              AppConstraints.iconButtonRadius,
            ),
            onTap: onPressed,
            child: Center(
              child: FaIcon(
                icon,
                size: AppConstraints.iconSize,
                color: scheme.onSurface,
                semanticLabel: semanticLabel,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageSwitch extends StatelessWidget {
  const _LanguageSwitch();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isArabic = context.locale.languageCode == 'ar';
    return Semantics(
      button: true,
      label: 'auth.switchLanguage'.tr(),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstraints.languagePillRadius),
        onTap: () => _toggleLocale(context, isArabic),
        child: Container(
          height: AppConstraints.languagePillHeight,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppConstraints.languagePillRadius,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                TamenIcons.globe,
                size: AppConstraints.privacyIconSize,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                isArabic ? 'auth.arabic'.tr() : 'auth.english'.tr(),
                style: TextStyle(
                  fontSize: AppConstraints.captionSize,
                  fontWeight: FontWeight.w500,
                  height: AppConstraints.captionHeight,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleLocale(BuildContext context, bool isArabic) {
    return context.setLocale(Locale(isArabic ? 'en' : 'ar'));
  }
}
