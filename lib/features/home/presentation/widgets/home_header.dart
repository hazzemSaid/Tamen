import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_icons.dart';

/// Header row: text-only brand wordmark + language pill + theme switch.
class HomeHeader extends StatelessWidget {
  final String brandLabel;
  final String languageLabel;
  final String languageSemantic;
  final String themeSemantic;
  final String brandSemantic;
  final bool isDark;
  final VoidCallback? onLanguageTap;
  final VoidCallback? onThemeTap;

  const HomeHeader({
    super.key,
    required this.brandLabel,
    required this.languageLabel,
    required this.languageSemantic,
    required this.themeSemantic,
    required this.brandSemantic,
    required this.isDark,
    this.onLanguageTap,
    this.onThemeTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: AppConstraints.headerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Semantics(
            header: true,
            label: brandSemantic,
            child: ExcludeSemantics(
              child: Text.rich(
                TextSpan(
                  children: [
                    for (final unit in brandLabel.split(''))
                      TextSpan(
                        text: unit,
                        // Dot/shadda in primary, rest in onSurface.
                        style: (unit == '.' || unit == '\u0651')
                            ? TextStyle(color: scheme.primary)
                            : null,
                      ),
                  ],
                ),
                style: TextStyle(
                  fontSize: AppConstraints.brandWordmarkSize,
                  height: AppConstraints.brandWordmarkHeightFactor,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LanguagePill(
                label: languageLabel,
                semanticLabel: languageSemantic,
                onTap: onLanguageTap,
              ),
              const SizedBox(width: 8),
              _HeaderIconButton(
                icon: isDark ? TamenIcons.sun : TamenIcons.moon,
                semanticLabel: themeSemantic,
                onPressed: onThemeTap,
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
  final VoidCallback? onPressed;

  const _HeaderIconButton({
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
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
          color: Colors.transparent,
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

class _LanguagePill extends StatelessWidget {
  final String label;
  final String semanticLabel;
  final VoidCallback? onTap;

  const _LanguagePill({
    required this.label,
    required this.semanticLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstraints.languagePillRadius),
        onTap: onTap,
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
                label,
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
}
