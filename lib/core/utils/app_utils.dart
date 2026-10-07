import 'package:flutter/material.dart';

/// Shared, heavily-reused helpers. Feature code should use these
/// instead of copy-pasting SnackBars, spacers or theme lookups.
class AppUtils {
  const AppUtils._();

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  static void showError(BuildContext context, String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: theme.colorScheme.error,
        ),
      );
  }
}

/// Reusable gap box — prefer over raw `SizedBox(height: N)` so spacing
/// stays greppable and consistent.
class Gap extends StatelessWidget {
  final double width;
  final double height;

  const Gap({super.key, this.width = 0, this.height = 0});

  const Gap.h(this.height, {super.key}) : width = 0;
  const Gap.w(this.width, {super.key}) : height = 0;

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: width, height: height);
}

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}
