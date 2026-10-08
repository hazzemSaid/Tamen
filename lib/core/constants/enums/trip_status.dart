/// Mirrors `public.trip_status` in `docs/supabase-mvp-schema-v2.sql`.
///
/// Lifecycle: DRAFT → ON_MY_WAY ⇄ DELAYED → UNCONFIRMED →
/// CHECK_IN_NEEDED → HELP_REQUESTED → ARRIVED / EXPIRED / CLOSED.
/// See `validate_trip_update()` in schema v2 for the allowed transitions.
enum TripStatus {
  draft('DRAFT'),
  onMyWay('ON_MY_WAY'),
  delayed('DELAYED'),
  unconfirmed('UNCONFIRMED'),
  checkInNeeded('CHECK_IN_NEEDED'),
  helpRequested('HELP_REQUESTED'),
  arrived('ARRIVED'),
  expired('EXPIRED'),
  closed('CLOSED');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const TripStatus(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static TripStatus fromWire(String wire) => TripStatus.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown TripStatus',
        ),
      );

  /// True for terminal states (location sharing is force-disabled).
  bool get isTerminal =>
      this == TripStatus.arrived ||
      this == TripStatus.expired ||
      this == TripStatus.closed;
}
