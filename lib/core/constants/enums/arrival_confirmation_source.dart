/// Mirrors `public.arrival_confirmation_source` in
/// `docs/supabase-mvp-schema-v2.sql`.
///
/// TRAVELER confirmations carry no `trip_recipient_id`;
/// TRUSTED_CONTACT confirmations must reference one.
enum ArrivalConfirmationSource {
  traveler('TRAVELER'),
  trustedContact('TRUSTED_CONTACT');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const ArrivalConfirmationSource(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static ArrivalConfirmationSource fromWire(String wire) =>
      ArrivalConfirmationSource.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown ArrivalConfirmationSource',
        ),
      );
}
