import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/responsive.dart';

/// Brand block: wordmark + slogan + subtitle.
///
/// Same wordmark style as HomeHeader: `tamen.` / `طمّن.` with dot +
/// shadda in primary. The brand word comes from its own l10n key so
/// translators can never drop the tashkeel.
class BrandHero extends StatelessWidget {
  const BrandHero({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brandLabel = 'auth.titleBrand'.tr();
    final brandStyle = TextStyle(
      fontSize: context.brandWordSize,
      height: AppConstraints.brandWordHeight,
      fontWeight: FontWeight.w700,
      color: scheme.onSurface,
    );
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppConstraints.heroTopPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'auth.titlePrefix'.tr()),
                // Same wordmark style as HomeHeader: `tamen.` / `طمّن.`
                // with dot / shadda (U+0651) in primary, rest in onSurface.
                for (final unit in brandLabel.split(''))
                  TextSpan(
                    text: unit,
                    style: (unit == '.' || unit == '\u0651')
                        ? brandStyle.copyWith(color: scheme.primary)
                        : brandStyle,
                  ),
              ],
            ),
            style: TextStyle(
              fontSize: context.headingSize,
              height: AppConstraints.headingHeight,
              fontWeight: FontWeight.w500,
              color: scheme.onSurface,
            ),
          ),
          Gap.h(context.heroSubtitleGap),
          Text(
            'auth.subtitle'.tr(),
            style: TextStyle(
              fontSize: AppConstraints.subtitleSize,
              height: 24 / 15,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
