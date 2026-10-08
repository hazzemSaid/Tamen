import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/utils/app_utils.dart';

/// Bottom 3-tab bar.
class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onSelect;

  const HomeBottomNav({super.key, this.currentIndex = 0, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tabs = <_Tab>[
      _Tab(label: 'home.tabsHome'.tr(), icon: TamenIcons.home),
      _Tab(label: 'home.tabsTrips'.tr(), icon: TamenIcons.trip),
      _Tab(label: 'home.tabsAccount'.tr(), icon: TamenIcons.account),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: scheme.outline,
            width: AppConstraints.homeDividerWidth,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: AppConstraints.homeNavBarTopPadding,
          ),
          child: Row(
            children: [
              for (var i = 0; i < tabs.length; i++)
                Expanded(
                  child: _NavItem(
                    tab: tabs[i],
                    selected: i == currentIndex,
                    onTap: onSelect == null ? null : () => onSelect!(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tab {
  final String label;
  final FaIconData icon;

  const _Tab({required this.label, required this.icon});
}

class _NavItem extends StatelessWidget {
  final _Tab tab;
  final bool selected;
  final VoidCallback? onTap;

  const _NavItem({required this.tab, required this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.onSurface : scheme.onSurfaceVariant;
    return Semantics(
      button: true,
      selected: selected,
      label: tab.label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: AppConstraints.homeNavItemPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(tab.icon, size: AppConstraints.iconSize, color: color),
              const Gap.h(AppConstraints.homeNavItemGap),
              Text(
                tab.label,
                style: TextStyle(
                  fontSize: AppConstraints.homeTabSize,
                  height: AppConstraints.homeTabHeight,
                  color: color,
                ),
              ),
              const Gap.h(AppConstraints.homeNavItemGap),
              Container(
                width: AppConstraints.homeTabDotSize,
                height: AppConstraints.homeTabDotSize,
                decoration: BoxDecoration(
                  color: selected ? scheme.primary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
