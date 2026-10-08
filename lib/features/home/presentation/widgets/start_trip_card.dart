import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/utils/app_utils.dart';

/// Empty-state hero card.
class StartTripCard extends StatelessWidget {
  final VoidCallback? onStartTrip;

  const StartTripCard({super.key, this.onStartTrip});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
        start: AppConstraints.homeCardPadding,
        end: AppConstraints.homeCardPadding,
        top: AppConstraints.homeCardTopPadding,
        bottom: AppConstraints.homeCardPadding,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppConstraints.homeCardRadius),
        border: Border.all(color: scheme.outline),
      ),
      child: Column(
        children: [
          _HeroGlyph(scheme: scheme),
          const Gap.h(AppConstraints.homeCardInnerSpacing),
          Text(
            'home.startTitle'.tr(),
            style: TextStyle(
              fontSize: AppConstraints.homeCardTitleSize,
              height: AppConstraints.homeCardTitleHeight,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap.h(AppConstraints.homeCardBodySpacing),
          Text(
            'home.startSubtitle'.tr(),
            style: TextStyle(
              fontSize: AppConstraints.homeBodySize,
              height: AppConstraints.homeBodyHeight,
              color: scheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap.h(AppConstraints.homeCardInnerSpacing),
          SizedBox(
            width: double.infinity,
            height: AppConstraints.buttonHeight,
            child: FilledButton.icon(
              onPressed: onStartTrip,
              icon: FaIcon(
                TamenIcons.start,
                size: AppConstraints.privacyIconSize,
                semanticLabel: 'home.startAction'.tr(),
              ),
              label: Text('home.startAction'.tr()),
              style: FilledButton.styleFrom(
                backgroundColor: scheme.primary,
                foregroundColor: scheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstraints.buttonRadius,
                  ),
                ),
              ),
            ),
          ),
          const Gap.h(AppConstraints.homeCardBodySpacing),
          _PrivacyFootnote(scheme: scheme),
        ],
      ),
    );
  }
}

class _HeroGlyph extends StatelessWidget {
  final ColorScheme scheme;

  const _HeroGlyph({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstraints.homeHeroIconSize,
      height: AppConstraints.homeHeroIconSize,
      decoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: FaIcon(
        TamenIcons.trip,
        size: AppConstraints.homeHeroGlyphSize,
        color: scheme.onPrimary,
        semanticLabel: 'home.startTitle'.tr(),
      ),
    );
  }
}

class _PrivacyFootnote extends StatelessWidget {
  final ColorScheme scheme;

  const _PrivacyFootnote({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(
          TamenIcons.shieldCheck,
          size: AppConstraints.homeStatusIconSize,
          color: scheme.onSurfaceVariant,
        ),
        const Gap.w(AppConstraints.homeMetaRowSpacing),
        Flexible(
          child: Text(
            'home.startPrivacy'.tr(),
            style: TextStyle(
              fontSize: AppConstraints.homeCaptionSize,
              height: AppConstraints.homeCaptionHeight,
              color: scheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
