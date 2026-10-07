import 'package:flutter/widgets.dart';

import '../constants/app_constraints.dart';

/// Responsive helpers shared by all features.
///
/// Breakpoints live in [AppConstraints] — widgets only ask questions,
/// never hardcode widths/heights.
extension ResponsiveX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Phone layout (< 600dp logical width).
  bool get isCompactWidth =>
      screenSize.width < AppConstraints.compactMaxWidth;

  /// Short screens (small phones, landscape) get tighter hero spacing
  /// and smaller display type so content fits without heavy scrolling.
  bool get isShortScreen =>
      screenSize.height < AppConstraints.shortScreenHeight;

  /// Page-level cap: 390 on phones, 560 centered on tablets/desktop.
  double get pageMaxWidth => isCompactWidth
      ? AppConstraints.pageMaxWidth
      : AppConstraints.widePageMaxWidth;

  /// Content column cap: 350 on phones, 480 centered on tablets/desktop.
  double get contentMaxWidth => isCompactWidth
      ? AppConstraints.contentMaxWidth
      : AppConstraints.wideContentMaxWidth;

  double get heroTitleGap => isShortScreen
      ? AppConstraints.heroTitleGapCompact
      : AppConstraints.heroTitleGap;

  double get heroSubtitleGap => isShortScreen
      ? AppConstraints.heroSubtitleGapCompact
      : AppConstraints.heroSubtitleGap;

  double get headingSize => isShortScreen
      ? AppConstraints.headingSizeCompact
      : AppConstraints.headingSize;

  double get brandWordSize => isShortScreen
      ? AppConstraints.brandWordSizeCompact
      : AppConstraints.brandWordSize;

  double get actionsTopPadding => isShortScreen
      ? AppConstraints.actionsTopPaddingCompact
      : AppConstraints.actionsTopPadding;
}
