import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/utils/app_utils.dart';
import '../../models/home_trip_models.dart';

/// One recent-trip row.
class RecentTripTile extends StatelessWidget {
  final RecentTripUi trip;
  final VoidCallback? onTap;

  const RecentTripTile({super.key, required this.trip, this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ok =
        Theme.of(context).extension<TamenSemantics>()?.ok ?? scheme.primary;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: AppConstraints.homeRecentTileMinHeight,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: AppConstraints.homeTileVerticalPadding,
          ),
          child: Row(
            children: [
              Container(
                width: AppConstraints.homeAvatarSize,
                height: AppConstraints.homeAvatarSize,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: FaIcon(
                  TamenIcons.location,
                  size: AppConstraints.homeAvatarGlyphSize,
                  color: scheme.onSurfaceVariant,
                  semanticLabel: trip.title,
                ),
              ),
              const Gap.w(AppConstraints.homeRecentTileGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      trip.title,
                      style: TextStyle(
                        fontSize: AppConstraints.subtitleSize,
                        height: AppConstraints.homeTileTitleHeight,
                        color: scheme.onSurface,
                      ),
                    ),
                    const Gap.h(AppConstraints.homeTileMetaGap),
                    Row(
                      children: [
                        Container(
                          width: AppConstraints.homeStatusIconSize,
                          height: AppConstraints.homeStatusIconSize,
                          decoration: BoxDecoration(
                            color: ok,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Gap.w(AppConstraints.homeMetaRowSpacing),
                        Text(
                          trip.statusLabel,
                          style: TextStyle(
                            fontSize: AppConstraints.homeCaptionSize,
                            height: AppConstraints.homeCaptionHeight,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const Gap.w(AppConstraints.homeMetaRowSpacing),
                        Text(
                          trip.dateLabel,
                          style: TextStyle(
                            fontSize: AppConstraints.homeMetaSize,
                            height: AppConstraints.homeMetaHeight,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
