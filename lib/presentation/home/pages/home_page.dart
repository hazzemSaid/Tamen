import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_icons.dart';

/// Traveler home placeholder (pre-auth).
///
/// Shows the empty reassurance state. Trip creation and sign-in arrive with
/// the Supabase Auth slice.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('appTitle'.tr())),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                TamenIcons.explore,
                size: TamenIcons.hero,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'noActiveTrip'.tr(),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'noActiveTripHint'.tr(),
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                // Enabled by the trips slice.
                onPressed: null,
                child: Text('startTrip'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
