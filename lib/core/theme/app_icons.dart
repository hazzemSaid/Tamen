import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'app_colors.dart';

/// Single source of truth for icons.
///
/// Rule: always use [FaIcon] (not [Icon]) with these [FaIconData]s —
/// many Font Awesome glyphs are not square and clip inside [Icon]
/// (see font_awesome_flutter FAQ). Do not mix Material `Icons` /
/// `CupertinoIcons` in feature code; add the mapping here instead.
///
/// Sizes follow `docs/designsystem.md` §25.
class TamenIcons {
  const TamenIcons._();

  // Sizes.
  static const double compact = 20;
  static const double standard = 24;
  static const double prominent = 32;
  static const double feature = 40;
  static const double hero = 48;

  // Trip / reassurance.
  static const FaIconData explore = FontAwesomeIcons.compass;
  static const FaIconData trip = FontAwesomeIcons.route;
  static const FaIconData location = FontAwesomeIcons.locationDot;
  static const FaIconData mapLocation = FontAwesomeIcons.mapLocationDot;
  static const FaIconData shield = FontAwesomeIcons.shieldHalved;
  static const FaIconData contacts = FontAwesomeIcons.userGroup;
  static const FaIconData clock = FontAwesomeIcons.clock;
  static const FaIconData bell = FontAwesomeIcons.bell;
  static const FaIconData settings = FontAwesomeIcons.gear;

  // Status (§15, §19 — always pair with label + timestamp, never color alone).
  static const FaIconData ok = FontAwesomeIcons.circleCheck;
  static const FaIconData warn = FontAwesomeIcons.triangleExclamation;
  static const FaIconData alert = FontAwesomeIcons.circleExclamation;
  static const FaIconData info = FontAwesomeIcons.circleInfo;

  // Actions (§16 — one clear primary action per screen).
  static const FaIconData start = FontAwesomeIcons.play;
  static const FaIconData confirm = FontAwesomeIcons.check;
  static const FaIconData share = FontAwesomeIcons.shareNodes;
  static const FaIconData end = FontAwesomeIcons.xmark;
  static const FaIconData add = FontAwesomeIcons.plus;
  static const FaIconData refresh = FontAwesomeIcons.arrowsRotate;

  // Auth / welcome (§16).
  static const FaIconData google = FontAwesomeIcons.google;
  static const FaIconData facebook = FontAwesomeIcons.facebookF;
  static const FaIconData phone = FontAwesomeIcons.phone;
  static const FaIconData globe = FontAwesomeIcons.globe;
  static const FaIconData moon = FontAwesomeIcons.moon;
  static const FaIconData sun = FontAwesomeIcons.sun;
  static const FaIconData shieldCheck = FontAwesomeIcons.shieldHalved;

  // Bottom navigation (single source — no Material Icons in features).
  static const FaIconData home = FontAwesomeIcons.house;
  static const FaIconData account = FontAwesomeIcons.user;

  // Directional — mirror in RTL via [directional] / [back] / [forward].
  // Do NOT mirror [location], [ok], [warn], [shield] (§25).
  static const FaIconData arrowRight = FontAwesomeIcons.arrowRight;
  static const FaIconData arrowLeft = FontAwesomeIcons.arrowLeft;
  static const FaIconData chevronRight = FontAwesomeIcons.chevronRight;
  static const FaIconData chevronLeft = FontAwesomeIcons.chevronLeft;

  /// Returns the logical "forward" arrow for the current [Directionality].
  static FaIconData forwardOf(BuildContext context) =>
      Directionality.of(context) == TextDirection.rtl ? arrowLeft : arrowRight;

  /// Returns the logical "back" arrow for the current [Directionality].
  static FaIconData backOf(BuildContext context) =>
      Directionality.of(context) == TextDirection.rtl ? arrowRight : arrowLeft;

  /// Status icon tinted with [TamenSemantics] — caller still must render
  /// the status label + supporting text alongside it.
  static Widget status(TamenStatus status, {double size = standard}) {
    return _StatusIcon(status: status, size: size);
  }
}

enum TamenStatus { ok, warn, alert, info }

class _StatusIcon extends StatelessWidget {
  final TamenStatus status;
  final double size;

  const _StatusIcon({required this.status, required this.size});

  @override
  Widget build(BuildContext context) {
    final semantics = Theme.of(context).extension<TamenSemantics>();
    final (icon, color) = switch (status) {
      TamenStatus.ok => (TamenIcons.ok, semantics?.ok),
      TamenStatus.warn => (TamenIcons.warn, semantics?.warn),
      TamenStatus.alert => (TamenIcons.alert, semantics?.alert),
      TamenStatus.info => (TamenIcons.info, semantics?.info),
    };
    return FaIcon(
      icon,
      size: size,
      color: color ?? Theme.of(context).colorScheme.onSurface,
      semanticLabel: status.name,
    );
  }
}

// Re-exported for call sites that only need the extension type.
