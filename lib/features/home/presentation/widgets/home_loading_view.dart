import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/utils/app_utils.dart';

/// Loading slot.
class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: AppConstraints.homeFeedbackPadding,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: scheme.primary),
            const Gap.h(AppConstraints.homeCardBodySpacing),
            Text(
              'home.loading'.tr(),
              style: TextStyle(
                fontSize: AppConstraints.homeMetaSize,
                height: AppConstraints.homeMetaHeight,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
