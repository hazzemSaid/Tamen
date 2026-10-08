import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/utils/app_utils.dart';

/// Failure slot with retry.
class HomeFailureView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const HomeFailureView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final alert =
        Theme.of(context).extension<TamenSemantics>()?.alert ?? scheme.error;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: AppConstraints.homeFeedbackPadding,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              TamenIcons.alert,
              size: TamenIcons.prominent,
              color: alert,
              semanticLabel: 'home.loadError'.tr(),
            ),
            const Gap.h(AppConstraints.homeCardBodySpacing),
            Text(
              'home.loadError'.tr(),
              style: TextStyle(
                fontSize: AppConstraints.homeBodySize,
                height: AppConstraints.homeBodyHeight,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap.h(AppConstraints.homeTileMetaGap),
            Text(
              message,
              style: TextStyle(
                fontSize: AppConstraints.homeMetaSize,
                height: AppConstraints.homeMetaHeight,
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap.h(AppConstraints.homeCardInnerSpacing),
            OutlinedButton(onPressed: onRetry, child: Text('home.retry'.tr())),
          ],
        ),
      ),
    );
  }
}
