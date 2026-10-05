import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/utils/app_utils.dart';

/// Phone entry bottom sheet — UI ONLY in this slice (no OTP logic).
/// Shows a phone field + disabled continue + "coming soon" note.
class PhoneSheet extends StatefulWidget {
  const PhoneSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const PhoneSheet(),
    );
  }

  @override
  State<PhoneSheet> createState() => _PhoneSheetState();
}

class _PhoneSheetState extends State<PhoneSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    // Centered + capped so the sheet stays a compact card on tablets.
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppConstraints.wideContentMaxWidth,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 20,
            end: 20,
            top: 12,
            bottom: bottom + 24,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.outline,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const Gap.h(16),
          Text(
            'auth.phoneTitle'.tr(),
            style: TextStyle(
              fontSize: AppConstraints.bodySize,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const Gap.h(4),
          Text(
            'auth.phoneHint'.tr(),
            style: TextStyle(
              fontSize: AppConstraints.captionSize,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const Gap.h(16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'auth.phonePlaceholder'.tr(),
              prefixText: '+966 ',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const Gap.h(12),
          SizedBox(
            width: double.infinity,
            height: AppConstraints.buttonHeight,
            child: FilledButton(
              // UI-only: always null until the OTP slice lands.
              onPressed: null,
              child: Text('auth.phoneContinue'.tr()),
            ),
          ),
          const Gap.h(8),
          Center(
            child: Text(
              'auth.phoneComingSoon'.tr(),
              style: TextStyle(
                fontSize: AppConstraints.dividerLabelSize,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }
}
