import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constraints.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme_controller.dart';
import '../../../../core/utils/responsive.dart';
import '../../models/home_trip_models.dart';
import '../state/home_ui_state.dart';
import '../widgets/active_trip_card.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/home_failure_view.dart';
import '../widgets/home_greeting.dart';
import '../widgets/home_header.dart';
import '../widgets/home_loading_view.dart';
import '../widgets/recent_trips_section.dart';
import '../widgets/start_trip_card.dart';

/// Traveler home screen.
class HomePage extends StatefulWidget {
  final HomeUiState? state;
  final AppThemeController? themeController;
  final VoidCallback? onStartTrip;
  final VoidCallback? onOpenTrip;
  final VoidCallback? onSeeAll;
  final ValueChanged<RecentTripUi>? onTripTap;
  final VoidCallback? onRetry;
  final ValueChanged<int>? onNavSelect;

  const HomePage({
    super.key,
    this.state,
    this.themeController,
    this.onStartTrip,
    this.onOpenTrip,
    this.onSeeAll,
    this.onTripTap,
    this.onRetry,
    this.onNavSelect,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = widget.state ?? HomeEmpty(recents: _demoRecents(context));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.pageMaxWidth),
            child: Padding(
              padding: AppConstraints.pagePadding,
              child: Column(
                children: [
                  _header(context),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: AppConstraints.homeScrollPadding,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: context.contentMaxWidth,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            HomeGreeting(text: _greeting(context)),
                            const SizedBox(
                              height: AppConstraints.homeHeroTopPadding,
                            ),
                            _body(context, state),
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
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _navIndex,
        onSelect: (index) {
          setState(() => _navIndex = index);
          widget.onNavSelect?.call(index);
        },
      ),
    );
  }

  Widget _header(BuildContext context) {
    final easy = EasyLocalization.of(context);
    final locale = easy?.locale ?? Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final controller =
        widget.themeController ??
        (sl.isRegistered<AppThemeController>()
            ? sl<AppThemeController>()
            : null);
    VoidCallback? onLanguageTap;
    final easyLoc = easy;
    if (easyLoc != null) {
      onLanguageTap = () => easyLoc.setLocale(Locale(isArabic ? 'en' : 'ar'));
    }
    VoidCallback? onThemeTap;
    final themeCtrl = controller;
    if (themeCtrl != null) {
      onThemeTap = themeCtrl.toggle;
    }
    return HomeHeader(
      brandLabel: 'home.wordmark'.tr(),
      languageLabel: (isArabic ? 'home.arabic' : 'home.english').tr(),
      languageSemantic: 'home.switchLanguage'.tr(),
      themeSemantic: 'home.toggleTheme'.tr(),
      brandSemantic: 'home.wordmark'.tr(),
      isDark: Theme.of(context).brightness == Brightness.dark,
      onLanguageTap: onLanguageTap,
      onThemeTap: onThemeTap,
    );
  }

  String _greeting(BuildContext context) =>
      'home.greetingEvening'.tr(namedArgs: {'name': 'home.demoName'.tr()});

  /// Demo snackbar until trips slice lands.
  void _showStartTripDemo(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('home.startTripDemo'.tr())));
  }

  Widget _body(BuildContext context, HomeUiState state) {
    return switch (state) {
      HomeLoading() => const HomeLoadingView(),
      HomeEmpty(recents: final recents) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StartTripCard(
            onStartTrip:
                widget.onStartTrip ?? () => _showStartTripDemo(context),
          ),
          const SizedBox(height: AppConstraints.homeSectionTopPadding),
          RecentTripsSection(
            trips: recents,
            onSeeAll: widget.onSeeAll,
            onTripTap: widget.onTripTap,
          ),
        ],
      ),
      HomeHasTrip(active: final active, recents: final recents) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ActiveTripCard(trip: active, onOpenTrip: widget.onOpenTrip),
          const SizedBox(height: AppConstraints.homeSectionTopPadding),
          RecentTripsSection(
            trips: recents,
            onSeeAll: widget.onSeeAll,
            onTripTap: widget.onTripTap,
          ),
        ],
      ),
      HomeFailure(message: final message) => HomeFailureView(
        message: message,
        onRetry: widget.onRetry,
      ),
    };
  }
}

// Demo content — removed once trips cubit lands.

List<RecentTripUi> _demoRecents(BuildContext context) => [
  RecentTripUi(
    id: 'demo-1',
    title: 'home.demoTrip1Title'.tr(),
    statusLabel: 'home.completed'.tr(),
    dateLabel: 'home.demoDate1'.tr(),
  ),
  RecentTripUi(
    id: 'demo-2',
    title: 'home.demoTrip2Title'.tr(),
    statusLabel: 'home.completed'.tr(),
    dateLabel: 'home.demoDate2'.tr(),
  ),
  RecentTripUi(
    id: 'demo-3',
    title: 'home.demoTrip3Title'.tr(),
    statusLabel: 'home.completed'.tr(),
    dateLabel: 'home.demoDate3'.tr(),
  ),
];

/// Demo active trip for previews.
HomeHasTrip demoHasTrip(BuildContext context) => HomeHasTrip(
  active: ActiveTripUi(
    title: 'home.demoActiveTitle'.tr(),
    statusLine: 'home.demoActiveStatus'.tr(),
    progress: 0.62,
    etaLabel: 'home.etaPrefix'.tr(
      namedArgs: {'minutes': 'home.demoMinutes'.tr()},
    ),
    updatedLabel: 'home.updatedNow'.tr(),
    sharedWithLabel: 'home.demoSharedWith'.tr(),
  ),
  recents: _demoRecents(context),
);
