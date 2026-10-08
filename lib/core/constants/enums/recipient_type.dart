/// Mirrors `public.recipient_type` in `docs/supabase-mvp-schema-v2.sql`.
///
/// ANONYMOUS = link-based (`recipient_name` + token), TRUSTED = app user
/// via `trusted_contact_id` (no token columns).
enum RecipientType {
  anonymous('ANONYMOUS'),
  trusted('TRUSTED');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const RecipientType(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static RecipientType fromWire(String wire) =>
      RecipientType.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown RecipientType',
        ),
      );
}
