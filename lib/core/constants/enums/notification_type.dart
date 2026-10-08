/// Mirrors `public.notification_type` in `docs/supabase-mvp-schema-v2.sql`.
///
/// Outbox pattern: the scheduler enqueues rows, a push worker sends
/// FCM/APNs. `CHECK_IN_NEEDED` renders as "Arrival hasn't been confirmed",
/// NOT "she is in danger".
enum NotificationType {
  checkInNeeded('CHECK_IN_NEEDED');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const NotificationType(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static NotificationType fromWire(String wire) =>
      NotificationType.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown NotificationType',
        ),
      );
}
