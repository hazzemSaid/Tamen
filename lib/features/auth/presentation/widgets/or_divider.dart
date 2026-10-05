import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constraints.dart';

/// "— أو —" divider from Figma (two 1px lines + label).
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Divider(color: scheme.outline, thickness: 1)),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
            child: Text(
              'auth.or'.tr(),
              style: TextStyle(
                fontSize: AppConstraints.dividerLabelSize,
                height: AppConstraints.dividerLabelHeight,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Divider(color: scheme.outline, thickness: 1)),
        ],
      ),
    );
  }
}
