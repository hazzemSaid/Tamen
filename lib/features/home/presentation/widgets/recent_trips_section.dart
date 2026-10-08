import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/utils/app_utils.dart';
import '../../models/home_trip_models.dart';
import 'recent_trip_tile.dart';

/// Recent trips section.
class RecentTripsSection extends StatelessWidget {
  final List<RecentTripUi> trips;
  final VoidCallback? onSeeAll;
  final ValueChanged<RecentTripUi>? onTripTap;

  const RecentTripsSection({
    super.key,
    required this.trips,
    this.onSeeAll,
    this.onTripTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: AppConstraints.homeSectionLabelBottomPadding,
              ),
              child: Text(
                'home.recentTitle'.tr(),
                style: TextStyle(
                  fontSize: AppConstraints.homeMetaSize,
                  height: AppConstraints.homeMetaHeight,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            _SeeAllButton(onPressed: onSeeAll),
          ],
        ),
        const Gap.h(AppConstraints.homeCardBodySpacing),
        if (trips.isEmpty)
          Text(
            'home.noRecentTrips'.tr(),
            style: TextStyle(
              fontSize: AppConstraints.homeMetaSize,
              height: AppConstraints.homeMetaHeight,
              color: scheme.onSurfaceVariant,
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: scheme.outline,
                  width: AppConstraints.homeDividerWidth,
                ),
                bottom: BorderSide(
                  color: scheme.outline,
                  width: AppConstraints.homeDividerWidth,
                ),
              ),
            ),
            child: Column(
              children: [
                for (var i = 0; i < trips.length; i++) ...[
                  if (i > 0)
                    Divider(
                      color: scheme.outline,
                      thickness: AppConstraints.homeDividerWidth,
                      height: AppConstraints.homeDividerWidth,
                    ),
                  RecentTripTile(
                    trip: trips[i],
                    onTap: onTripTap == null
                        ? null
                        : () => onTripTap!(trips[i]),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _SeeAllButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _SeeAllButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
      ),
      child: Text(
        'home.seeAll'.tr(),
        style: TextStyle(
          fontSize: AppConstraints.homeMetaSize,
          height: AppConstraints.homeMetaHeight,
          color: scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
