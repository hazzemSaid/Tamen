import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';

/// Secondary (outlined surface) provider button from Figma:
/// 50h, radius 12, 24px badge + centered label.
class AuthSocialButton extends StatelessWidget {
  final String label;
  final FaIconData badgeIcon;
  final String badgeSemantic;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthSocialButton({
    super.key,
    required this.label,
    required this.badgeIcon,
    required this.badgeSemantic,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: AppConstraints.buttonHeight,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: scheme.surface,
          side: BorderSide(
            color: scheme.outline,
            width: AppConstraints.buttonBorderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstraints.buttonRadius,
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: AppConstraints.iconSize,
                height: AppConstraints.iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: scheme.onSurface,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: AppConstraints.socialBadgeSize,
                    height: AppConstraints.socialBadgeSize,
                    decoration: BoxDecoration(
                      color: scheme.onSurface,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: FaIcon(
                      badgeIcon,
                      size: 14,
                      color: scheme.surface,
                      semanticLabel: badgeSemantic,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: AppConstraints.bodySize,
                        height: AppConstraints.bodyHeight,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
