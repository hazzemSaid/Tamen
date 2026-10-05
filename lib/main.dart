import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'package:tamen/core/constants/app_constants.dart';
import 'package:tamen/core/di/injection.dart';
import 'package:tamen/core/theme/app_theme.dart';
import 'package:tamen/core/theme/app_theme_controller.dart';
import 'package:tamen/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tamen/features/auth/presentation/cubit/auth_state.dart';
import 'package:tamen/features/auth/presentation/screens/auth_welcome_screen.dart';
import 'package:tamen/presentation/home/pages/home_page.dart';

/// Supabase credentials: `--dart-define` wins, `.env` is the debug fallback
/// (see `.vscode/launch.json`).
const String _supabaseUrlFromDefine = String.fromEnvironment('SUPABASE_URL');
const String _supabaseKeyFromDefine = String.fromEnvironment('SUPABASE_KEY');

/// Tamen bootstrap: Supabase + DI + EasyLocalization (en/ar, RTL-ready).
/// The Supabase client is always initialized so the real auth data source
/// (including Facebook OAuth) is available; there is no offline fallback.
Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: _resolveEnv('SUPABASE_URL', _supabaseUrlFromDefine),
    publishableKey: _resolveEnv('SUPABASE_KEY', _supabaseKeyFromDefine),
  );
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  await initInjection();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: AppConstants.translationsPath,
      fallbackLocale: const Locale(AppConstants.defaultLocaleCode),
      child: const TamenApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

/// Returns the `--dart-define` value when present, otherwise the `.env` value.
/// Throws when neither is set so a misconfigured build fails loudly.
String _resolveEnv(String name, String fromDefine) {
  if (fromDefine.isNotEmpty) return fromDefine;
  final fromDotenv = dotenv.env[name];
  if (fromDotenv == null || fromDotenv.isEmpty) {
    throw StateError(
      'Missing $name. Set it via --dart-define=$name=... or in the .env asset.',
    );
  }
  return fromDotenv;
}

class TamenApp extends StatelessWidget {
  const TamenApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = sl<AppThemeController>();
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeController,
        builder: (context, mode, _) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: TamenTheme.light,
            darkTheme: TamenTheme.dark,
            themeMode: mode,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) => state is AuthAuthenticated
                  ? const HomePage()
                  : const AuthWelcomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
