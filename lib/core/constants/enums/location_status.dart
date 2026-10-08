/// Mirrors `public.location_status` in `docs/supabase-mvp-schema-v2.sql`.
enum LocationStatus {
  live('LIVE'),
  stale('STALE'),
  unavailable('UNAVAILABLE');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const LocationStatus(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static LocationStatus fromWire(String wire) =>
      LocationStatus.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown LocationStatus',
        ),
      );
}
