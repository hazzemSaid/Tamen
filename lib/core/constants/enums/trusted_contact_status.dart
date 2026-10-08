/// Mirrors `public.trusted_contact_status` in
/// `docs/supabase-mvp-schema-v2.sql`.
///
/// PENDING (invite link, no `contact_id`) → ACCEPTED (linked user) →
/// REVOKED (cascade-deactivates `trip_recipients`).
enum TrustedContactStatus {
  pending('PENDING'),
  accepted('ACCEPTED'),
  revoked('REVOKED');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const TrustedContactStatus(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static TrustedContactStatus fromWire(String wire) =>
      TrustedContactStatus.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown TrustedContactStatus',
        ),
      );
}
