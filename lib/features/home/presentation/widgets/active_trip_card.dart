import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/utils/app_utils.dart';
import '../../models/home_trip_models.dart';

/// Ongoing-trip hero card.
class ActiveTripCard extends StatelessWidget {
  final ActiveTripUi trip;
  final VoidCallback? onOpenTrip;

  const ActiveTripCard({super.key, required this.trip, this.onOpenTrip});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? scheme.surface : TamenColors.midnightNavy;
    final onCard = isDark ? scheme.onSurface : TamenColors.softWhite;
    final subColor = onCard.withValues(alpha: 0.7);
    final etaColor = onCard.withValues(alpha: 0.9);
    final trackColor = onCard.withValues(alpha: 0.1);
    final dividerColor = onCard.withValues(alpha: 0.1);

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(AppConstraints.homeCardPadding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppConstraints.homeCardRadius),
        border: isDark ? Border.all(color: scheme.outline) : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: TamenColors.midnightNavy.withValues(alpha: 0.8),
                  blurRadius: 40,
                  spreadRadius: -24,
                  offset: const Offset(0, 20),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_LiveBadge(scheme: scheme)],
          ),
          const Gap.h(AppConstraints.homeHeroTitleGap),
          Text(
            trip.title,
            style: TextStyle(
              fontSize: AppConstraints.homeCardTitleSize,
              height: AppConstraints.homeCardTitleHeight,
              fontWeight: FontWeight.w600,
              color: onCard,
            ),
          ),
          const Gap.h(AppConstraints.homeStatusGap),
          Text(
            trip.statusLine,
            style: TextStyle(
              fontSize: AppConstraints.homeBodySize,
              height: AppConstraints.homeBodyHeight,
              color: subColor,
            ),
          ),
          const Gap.h(AppConstraints.homeCardInnerSpacing),
          _ProgressBar(
            progress: trip.progress,
            track: trackColor,
            fill: scheme.primary,
            semanticLabel: trip.etaLabel,
          ),
          const Gap.h(AppConstraints.homeCardBodySpacing),
          Text(
            trip.etaLabel,
            style: TextStyle(
              fontSize: AppConstraints.homeMetaSize,
              height: AppConstraints.homeMetaHeight,
              color: etaColor,
            ),
          ),
          const Gap.h(AppConstraints.homeCardInnerSpacing),
          Divider(color: dividerColor, thickness: 1, height: 1),
          const Gap.h(AppConstraints.homeDividerGap),
          _MetaRow(
            icon: TamenIcons.location,
            label: trip.updatedLabel,
            iconColor: scheme.primary,
            textColor: subColor,
          ),
          const Gap.h(AppConstraints.homeCardBodySpacing),
          _MetaRow(
            icon: TamenIcons.contacts,
            label: trip.sharedWithLabel,
            iconColor: scheme.primary,
            textColor: subColor,
          ),
          const Gap.h(AppConstraints.homeCardInnerSpacing),
          SizedBox(
            width: double.infinity,
            height: AppConstraints.buttonHeight,
            child: FilledButton(
              onPressed: onOpenTrip,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstraints.buttonRadius,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('home.openTrip'.tr()),
                  const Gap.w(AppConstraints.homeMetaRowSpacing),
                  FaIcon(
                    TamenIcons.forwardOf(context),
                    size: AppConstraints.homeAvatarGlyphSize,
                    semanticLabel: 'home.openTrip'.tr(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  final ColorScheme scheme;

  const _LiveBadge({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppConstraints.homeBadgeHorizontalPadding,
        vertical: AppConstraints.homeBadgeVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppConstraints.pillRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulseDot(color: scheme.primary),
          const Gap.w(AppConstraints.homeMetaRowSpacing),
          Text(
            'home.activeBadge'.tr(),
            style: TextStyle(
              fontSize: AppConstraints.homeCaptionSize,
              height: AppConstraints.homeCaptionHeight,
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Static halo + solid dot.
class _PulseDot extends StatelessWidget {
  final Color color;

  const _PulseDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstraints.homePulseHaloSize,
      height: AppConstraints.homePulseHaloSize,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.21),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        width: AppConstraints.homeActiveDotSize,
        height: AppConstraints.homeActiveDotSize,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  final Color track;
  final Color fill;
  final String semanticLabel;

  const _ProgressBar({
    required this.progress,
    required this.track,
    required this.fill,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      value: '${(progress * 100).round()}%',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstraints.pillRadius),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: AppConstraints.homeProgressHeight,
          backgroundColor: track,
          valueColor: AlwaysStoppedAnimation<Color>(fill),
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final Color iconColor;
  final Color textColor;

  const _MetaRow({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon, size: AppConstraints.homeMetaIconSize, color: iconColor),
        const Gap.w(AppConstraints.homeMetaIconTextGap),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppConstraints.homeMetaSize,
              height: AppConstraints.homeMetaHeight,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
