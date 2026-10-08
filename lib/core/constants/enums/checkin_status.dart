/// Mirrors `public.checkin_status` in `docs/supabase-mvp-schema-v2.sql`.
///
/// Payload status for `create_trip_checkin()` — each value drives a
/// side effect (I_AM_SAFE → event, DELAYED → +15 min, HELP_REQUESTED →
/// status change, ARRIVED → confirmation flow, ON_MY_WAY → resume).
enum CheckinStatus {
  onMyWay('ON_MY_WAY'),
  iAmSafe('I_AM_SAFE'),
  delayed('DELAYED'),
  helpRequested('HELP_REQUESTED'),
  arrived('ARRIVED');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const CheckinStatus(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static CheckinStatus fromWire(String wire) =>
      CheckinStatus.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown CheckinStatus',
        ),
      );
}
