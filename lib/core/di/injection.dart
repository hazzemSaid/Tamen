import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme/app_theme_controller.dart';
import '../../features/auth/data/datasources/supabase_auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/sign_in_with_facebook.dart';
import '../../features/auth/domain/usecases/sign_in_with_google.dart';
import '../../features/auth/domain/usecases/sign_out.dart';
import '../../features/auth/domain/usecases/start_phone_sign_in.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> initInjection({String? googleServerClientId}) async {
  if (sl.isRegistered<AppThemeController>()) return;

  if (!sl.isRegistered<AuthRepository>()) {
    if (!sl.isRegistered<SupabaseClient>()) {
      throw StateError(
        'SupabaseClient must be registered before initInjection(). '
        'Call Supabase.initialize() first, or pre-register an AuthRepository.',
      );
    }
    if (!sl.isRegistered<GoogleSignIn>()) {
      sl.registerLazySingleton<GoogleSignIn>(
        () => GoogleSignIn(
          scopes: const <String>['email', 'profile'],
          serverClientId: googleServerClientId?.isNotEmpty == true
              ? googleServerClientId
              : null,
        ),
      );
    }
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => SupabaseAuthRemoteDataSource(sl(), googleSignIn: sl()),
    );
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  }

  sl.registerLazySingleton<AppThemeController>(() => AppThemeController());

  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithFacebookUseCase(sl()));
  sl.registerLazySingleton(() => StartPhoneSignInUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  sl.registerFactory(
    () => AuthCubit(
      signInWithGoogle: sl(),
      signInWithFacebook: sl(),
      startPhoneSignIn: sl(),
      getCurrentUser: sl(),
      signOut: sl(),
    ),
  );
}
