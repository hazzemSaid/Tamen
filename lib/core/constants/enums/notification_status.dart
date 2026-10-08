/// Mirrors `public.notification_status` in
/// `docs/supabase-mvp-schema-v2.sql`.
///
/// Lifecycle of an outbox row: PENDING → SENT / FAILED.
enum NotificationStatus {
  pending('PENDING'),
  sent('SENT'),
  failed('FAILED');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const NotificationStatus(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static NotificationStatus fromWire(String wire) =>
      NotificationStatus.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown NotificationStatus',
        ),
      );
}
