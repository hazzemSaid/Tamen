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

  // Home screen (Figma "Home 390x797" frame).
  static const double greetingSize = 22;
  static const double greetingHeight = 33 / 22;
  static const double homeCardTitleSize = 20;
  static const double homeCardTitleHeight = 26 / 20;
  static const double homeBodySize = 14;
  static const double homeBodyHeight = 24 / 14;
  static const double homeMetaSize = 13;
  static const double homeMetaHeight = 20 / 13;
  static const double homeCaptionSize = 12;
  static const double homeCaptionHeight = 18 / 12;
  static const double homeTabSize = 11;
  static const double homeTabHeight = 16 / 11;

  static const double homeCardRadius = 24;
  static const double homeCardPadding = 24;
  static const double homeCardTopPadding = 32;
  static const double homeHeroIconSize = 64;
  static const double homeHeroGlyphSize = 26;
  static const double homeAvatarSize = 36;
  static const double homeAvatarGlyphSize = 16;
  static const double homeStatusIconSize = 12;
  static const double homeMetaIconSize = 15;
  static const double homePulseHaloSize = 14;
  static const double homeActiveDotSize = 8;
  static const double homeTabDotSize = 4;
  static const double homeProgressHeight = 6;
  static const double homeDividerWidth = 1.2;

  static const double homeGreetingTopPadding = 16;
  static const double homeHeroTopPadding = 20;
  static const double homeSectionTopPadding = 32;
  static const double homeSectionLabelBottomPadding = 4;
  static const double homeCardInnerSpacing = 20;
  static const double homeCardBodySpacing = 8;
  static const double homeHeroTitleGap = 28;
  static const double homeDividerGap = 16;
  static const double homeFeedbackPadding = 48;
  static const double homeStatusGap = 4;
  static const double homeMetaRowSpacing = 6;
  static const double homeMetaIconTextGap = 8;
  static const double homeRecentTileGap = 12;
  static const double homeRecentTileMinHeight = 60;
  static const double homeTileVerticalPadding = 12;
  static const double homeTileTitleHeight = 22 / 15;
  static const double homeTileMetaGap = 2;
  static const double homeNavBarTopPadding = 8;
  static const double homeNavItemGap = 4;
  static const double homeNavItemPadding = 4;
  static const double homeBadgeHorizontalPadding = 10;
  static const double homeBadgeVerticalPadding = 4;
  static const double pillRadius = 999;
  // Text-only header wordmark: طمّن (ar) / tamen. (en).
  static const double brandWordmarkSize = 22;
  static const double brandWordmarkHeightFactor = 28 / 22;
  static const double brandWordmarkWidth = 112;
  static const double brandWordmarkHeight = 32;

  static const EdgeInsetsDirectional homeScrollPadding =
      EdgeInsetsDirectional.only(top: 8, bottom: 16);
}
