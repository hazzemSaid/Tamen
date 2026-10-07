import 'package:flutter_dotenv/flutter_dotenv.dart';

const String supabaseUrlFromDefine = String.fromEnvironment('SUPABASE_URL');

const String supabaseKeyFromDefine = String.fromEnvironment('SUPABASE_KEY');

const String googleWebClientIdFromDefine = String.fromEnvironment(
  'GOOGLE_WEB_CLIENT_ID',
);

const String oauthRedirectUrlFromDefine = String.fromEnvironment(
  'OAUTH_REDIRECT_URL',
);

String resolveEnv(String name, String fromDefine) {
  if (fromDefine.isNotEmpty) return fromDefine;
  final fromDotenv = dotenv.env[name];
  if (fromDotenv == null || fromDotenv.isEmpty) {
    throw StateError(
      'Missing $name. Set it via --dart-define=$name=... or in the .env asset.',
    );
  }
  return fromDotenv;
}

String? resolveEnvOrNull(String name, String fromDefine) {
  if (fromDefine.isNotEmpty) return fromDefine;
  final fromDotenv = dotenv.env[name];
  if (fromDotenv == null || fromDotenv.isEmpty) return null;
  return fromDotenv;
}
