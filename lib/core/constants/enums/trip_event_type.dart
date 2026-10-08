/// Mirrors `public.trip_event_type` in `docs/supabase-mvp-schema-v2.sql`.
///
/// Append-only audit log (`trip_events`). Written by triggers
/// (`TRIP_CREATED`), RPCs (`change_trip_status`, `extend_trip_15_minutes`,
/// `create_trip_checkin`) and the revocation cascade (`RECIPIENT_REVOKED`).
enum TripEventType {
  tripCreated('TRIP_CREATED'),
  tripStarted('TRIP_STARTED'),
  tripDelayed('TRIP_DELAYED'),
  tripExtended('TRIP_EXTENDED'),
  tripUnconfirmed('TRIP_UNCONFIRMED'),
  tripCheckInNeeded('TRIP_CHECK_IN_NEEDED'),
  tripHelpRequested('TRIP_HELP_REQUESTED'),
  tripArrived('TRIP_ARRIVED'),
  tripExpired('TRIP_EXPIRED'),
  tripClosed('TRIP_CLOSED'),
  iAmSafe('I_AM_SAFE'),
  arrivalConfirmed('ARRIVAL_CONFIRMED'),
  locationSharingEnabled('LOCATION_SHARING_ENABLED'),
  locationSharingDisabled('LOCATION_SHARING_DISABLED'),
  recipientAdded('RECIPIENT_ADDED'),
  recipientLinkCreated('RECIPIENT_LINK_CREATED'),
  recipientRevoked('RECIPIENT_REVOKED');

  /// Exact wire value stored in Postgres / sent over Supabase.
  final String wire;

  const TripEventType(this.wire);

  /// Parses a Supabase wire value. Throws [ArgumentError] on unknown input.
  static TripEventType fromWire(String wire) =>
      TripEventType.values.firstWhere(
        (e) => e.wire == wire,
        orElse: () => throw ArgumentError.value(
          wire,
          'wire',
          'Unknown TripEventType',
        ),
      );
}
