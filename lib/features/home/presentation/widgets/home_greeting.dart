import 'package:flutter/material.dart';

import '../../../../core/constants/app_constraints.dart';

/// Greeting line.
class HomeGreeting extends StatelessWidget {
  final String text;

  const HomeGreeting({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppConstraints.homeGreetingTopPadding,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppConstraints.greetingSize,
          height: AppConstraints.greetingHeight,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
    );
  }
}
