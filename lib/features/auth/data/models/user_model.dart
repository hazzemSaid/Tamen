import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_entity.dart';

/// Data-layer user. Knows how to (de)serialize — domain entity stays pure.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.provider,
    super.email,
    super.phone,
    super.displayName,
    super.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      provider: AuthProvider.values.firstWhere(
        (p) => p.name == (json['provider'] as String? ?? 'google'),
        orElse: () => AuthProvider.google,
      ),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      displayName: json['display_name'] as String?,
      photoUrl: json['photo_url'] as String?,
    );
  }

  factory UserModel.fromSupabaseUser(User user) {
    final metadata = user.userMetadata ?? const <String, dynamic>{};
    final appMetadata = user.appMetadata;
    final identityProviders = user.identities
            ?.map((identity) => identity.provider)
            .toSet() ??
        const <String>{};
    final providerName = appMetadata['provider'] as String? ??
        (identityProviders.contains('facebook') ? 'facebook' : 'google');
    final provider = AuthProvider.values.firstWhere(
      (value) => value.name == providerName,
      orElse: () => AuthProvider.google,
    );

    return UserModel(
      id: user.id,
      provider: provider,
      email: user.email,
      phone: user.phone,
      displayName: metadata['full_name'] as String? ??
          metadata['name'] as String?,
      photoUrl: metadata['avatar_url'] as String? ??
          metadata['picture'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'provider': provider.name,
        'email': email,
        'phone': phone,
        'display_name': displayName,
        'photo_url': photoUrl,
      };
}
