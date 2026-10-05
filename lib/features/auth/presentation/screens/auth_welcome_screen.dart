import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_theme_controller.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/user_entity.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_phone_button.dart';
import '../widgets/auth_social_button.dart';
import '../widgets/brand_hero.dart';
import '../widgets/or_divider.dart';
import '../widgets/phone_sheet.dart';
import '../widgets/privacy_notice.dart';

/// Welcome / sign-in entry from the Figma "Container 390x797" frame.
///
/// Layout: 56h header row + scrollable 350-wide content column with
/// brand hero, Google / Facebook secondaries, or-divider, lime phone
/// primary and privacy footnote. Renders all 3 cubit states:
/// initial (buttons), loading (spinner / disabled), failure (banner).
class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const _WelcomeView();
}

class _WelcomeView extends StatelessWidget {
  const _WelcomeView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.pageMaxWidth),
            child: Padding(
              padding: AppConstraints.pagePadding,
              child: Column(
                children: [
                  AuthHeader(themeController: sl<AppThemeController>()),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: context.contentMaxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BrandHero(),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: context.actionsTopPadding,
                              ),
                              child: BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  final loading = state is AuthLoading
                                      ? state.provider
                                      : null;
                                  final isBusy = loading != null;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const AuthErrorBanner(),
                                      if (state is AuthFailure)
                                        const Gap.h(12),
                                      AuthSocialButton(
                                        label: 'auth.continueWithGoogle'.tr(),
                                        badgeIcon: TamenIcons.google,
                                        badgeSemantic: 'Google',
                                        isLoading:
                                            loading == AuthProvider.google,
                                        onPressed: isBusy
                                            ? null
                                            : () => context
                                                .read<AuthCubit>()
                                                .continueWithGoogle(),
                                      ),
                                      const Gap.h(
                                        AppConstraints.actionsSpacing,
                                      ),
                                      AuthSocialButton(
                                        label:
                                            'auth.continueWithFacebook'.tr(),
                                        badgeIcon: TamenIcons.facebook,
                                        badgeSemantic: 'Facebook',
                                        isLoading:
                                            loading == AuthProvider.facebook,
                                        onPressed: isBusy
                                            ? null
                                            : () => context
                                                .read<AuthCubit>()
                                                .continueWithFacebook(),
                                      ),
                                      const Gap.h(
                                        AppConstraints.actionsSpacing,
                                      ),
                                      const OrDivider(),
                                      const Gap.h(
                                        AppConstraints.actionsSpacing,
                                      ),
                                      AuthPhoneButton(
                                        label: 'auth.continueWithPhone'.tr(),
                                        onPressed: () =>
                                            PhoneSheet.show(context),
                                      ),
                                      const PrivacyNotice(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
