import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constraints.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

/// Error banner for [AuthFailure]: message + retry.
/// Rendered above the provider buttons so all 3 screen states
/// (initial / loading / failure) are visible in one place.
class AuthErrorBanner extends StatelessWidget {
  const AuthErrorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    if (state is! AuthFailure) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final isUnimplemented = state.message.contains('not wired');
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(
          AppConstraints.buttonRadius,
        ),
        border: Border.all(color: scheme.error),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              isUnimplemented ? 'auth.notWiredYet'.tr() : state.message,
              style: TextStyle(
                fontSize: AppConstraints.captionSize,
                color: scheme.onErrorContainer,
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => context.read<AuthCubit>().retry(),
            child: Text('auth.retry'.tr()),
          ),
        ],
      ),
    );
  }
}
