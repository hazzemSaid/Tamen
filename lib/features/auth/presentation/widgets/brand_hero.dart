import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/responsive.dart';

/// Brand block: wordmark + slogan + subtitle.
///
/// The slogan keeps its diacritics (`طمّن`, not `طمن`) — the brand word
/// comes from its own l10n key so translators can never drop the tashkeel,
/// and it renders bold + bigger than the rest of the line.
class BrandHero extends StatelessWidget {
  const BrandHero({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                TextSpan(
                  text: 'auth.titleBrand'.tr(),
                  style: TextStyle(
                    fontSize: context.brandWordSize,
                    height: AppConstraints.brandWordHeight,
                    fontWeight: FontWeight.w700,
                  ),
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
