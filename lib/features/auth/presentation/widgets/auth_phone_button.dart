import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_icons.dart';

/// Primary (lime) phone button from Figma: 50h, radius 12.
class AuthPhoneButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const AuthPhoneButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: AppConstraints.buttonHeight,
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              TamenIcons.phone,
              size: AppConstraints.privacyIconSize,
              color: scheme.onPrimary,
            ),
            const SizedBox(width: 8),
            Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
