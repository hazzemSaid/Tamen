import 'package:equatable/equatable.dart';

/// Supported sign-in providers for the welcome screen.
enum AuthProvider { google, facebook, phone }

/// Pure domain user — no JSON / Supabase leakage allowed here.
class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String? phone;
  final String? displayName;
  final String? photoUrl;
  final AuthProvider provider;

  const UserEntity({
    required this.id,
    required this.provider,
    this.email,
    this.phone,
    this.displayName,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [id, email, phone, displayName, photoUrl, provider];
}
