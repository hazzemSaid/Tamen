import 'package:flutter/material.dart';

/// Layout constraints taken from the Auth / Welcome Figma frame
/// (390x797, content width 350, paddings 20, buttons 50h, radius 12).
///
/// Rule: feature screens must consume these values — no magic numbers
/// for padding / radius / button sizes in widgets.
class AppConstraints {
  const AppConstraints._();

  // Page.
  static const double pageMaxWidth = 390;
  static const double contentMaxWidth = 350;
  static const EdgeInsetsDirectional pagePadding =
      EdgeInsetsDirectional.symmetric(horizontal: 20);

  // Responsive breakpoints + wide-screen caps. Below [compactMaxWidth]
  // the phone layout is used; above it the content widens and centers
  // instead of stretching edge to edge.
  static const double compactMaxWidth = 600;
  static const double shortScreenHeight = 700;
  static const double widePageMaxWidth = 560;
  static const double wideContentMaxWidth = 480;

  // Header bar (Figma "Welcome" 56h row).
  static const double headerHeight = 56;
  static const double iconButtonSize = 44;
  static const double iconButtonRadius = 12;
  static const double iconSize = 22;
  static const double languagePillHeight = 44;
  static const double languagePillRadius = 12;

  // Hero / brand block.
  static const double heroTopPadding = 40;
  static const double heroSpacing = 20;
  static const double heroTitleGap = 28;
  static const double heroTitleGapCompact = 20;
  static const double heroSubtitleGap = 12;
  static const double heroSubtitleGapCompact = 8;
  static const double brandLogoWidth = 176;
  static const double brandLogoHeight = 48;

  // Type scale used on the welcome screen.
  static const double headingSize = 28;
  static const double headingHeight = 38 / 28;
  static const double brandWordSize = 34;
  static const double brandWordHeight = 42 / 34;
  // Compact variants for short screens (height < [shortScreenHeight])
  // so the hero fits without pushing actions off-screen.
  static const double brandWordSizeCompact = 30;
  static const double headingSizeCompact = 24;
  static const double subtitleSize = 15;
  static const double bodySize = 16;
  static const double bodyHeight = 24 / 16;
  static const double captionSize = 14;
  static const double captionHeight = 24 / 14;
  static const double dividerLabelSize = 13;
  static const double dividerLabelHeight = 20 / 13;

  // Auth actions block.
  static const double actionsTopPadding = 48;
  static const double actionsTopPaddingCompact = 28;
  static const double actionsSpacing = 12;
  static const double buttonHeight = 50;
  static const double buttonRadius = 12;
  static const double buttonBorderWidth = 1.07;
  static const double socialBadgeSize = 24;
  static const double socialBadgeRadius = 24;

  // Privacy notice.
  static const double privacyTopPadding = 28;
  static const double privacySpacing = 12;
  static const double privacyIconSize = 18;
}
