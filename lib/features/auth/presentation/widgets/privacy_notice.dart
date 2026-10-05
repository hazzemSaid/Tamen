import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';

/// Privacy footnote from Figma: shield icon + single line.
/// Icon tint comes from [TamenSemantics.info], never hardcoded.
class PrivacyNotice extends StatelessWidget {
  const PrivacyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final info =
        Theme.of(context).extension<TamenSemantics>()?.info ??
            scheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppConstraints.privacyTopPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 2),
            child: FaIcon(
              TamenIcons.shieldCheck,
              size: AppConstraints.privacyIconSize,
              color: info,
              semanticLabel: 'auth.privacy'.tr(),
            ),
          ),
          const SizedBox(width: AppConstraints.privacySpacing),
          Expanded(
            child: Text(
              'auth.privacy'.tr(),
              style: TextStyle(
                fontSize: AppConstraints.captionSize,
                height: AppConstraints.captionHeight,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
