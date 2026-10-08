import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'package:tamen/core/config/env.dart';
import 'package:tamen/core/constants/app_constants.dart';
import 'package:tamen/core/di/injection.dart';
import 'package:tamen/core/theme/app_theme.dart';
import 'package:tamen/core/theme/app_theme_controller.dart';
import 'package:tamen/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tamen/features/auth/presentation/cubit/auth_state.dart';
import 'package:tamen/features/auth/presentation/screens/auth_welcome_screen.dart';
import 'package:tamen/features/home/presentation/pages/home_page.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: resolveEnv('SUPABASE_URL', supabaseUrlFromDefine),
    publishableKey: resolveEnv('SUPABASE_KEY', supabaseKeyFromDefine),
  );
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  await initInjection(
    googleServerClientId: resolveEnvOrNull(
      'GOOGLE_WEB_CLIENT_ID',
      googleWebClientIdFromDefine,
    ),
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: AppConstants.translationsPath,
      startLocale: const Locale(AppConstants.defaultLocaleCode),
      fallbackLocale: const Locale(AppConstants.defaultLocaleCode),
      child: const TamenApp(),
    ),
  );
  FlutterNativeSplash.remove();
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
            debugShowCheckedModeBanner: false,
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
