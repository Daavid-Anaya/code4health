import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code4health/features/authentication/data/datasources/user_profile_remote_data_source.dart';
import 'package:code4health/features/authentication/data/repositories/user_profile_repository_impl.dart';
import 'package:code4health/features/authentication/domain/repositories/user_profile_repository.dart';
import 'package:code4health/features/authentication/domain/usecases/create_account_use_case.dart';
import 'package:code4health/features/authentication/domain/usecases/save_user_profile_use_case.dart';
import 'package:code4health/features/authentication/domain/usecases/send_password_reset_email_use_case.dart';
import 'package:code4health/features/authentication/domain/usecases/sign_out_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/authentication/data/datasources/auth_remote_data_source.dart';
import 'features/authentication/data/datasources/product_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_remote_data_source_impl.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/data/repositories/product_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/repositories/product_repository.dart';
import 'features/authentication/domain/usecases/calculate_caloric_consumption_use_case.dart';
import 'features/authentication/domain/usecases/delete_account_use_case.dart';
import 'features/authentication/domain/usecases/get_product_by_barcode_use_case.dart';
import 'features/authentication/domain/usecases/get_user_profile_use_case.dart';
import 'features/authentication/domain/usecases/reauthenticate_use_case.dart';
import 'features/authentication/domain/usecases/sign_in_use_case.dart';
import 'features/authentication/domain/usecases/update_display_name_use_case.dart';
import 'features/authentication/domain/usecases/update_email_use_case.dart';
import 'features/authentication/domain/usecases/update_password_use_case.dart';
import 'features/authentication/domain/usecases/update_user_profile_use_case.dart';

// Creamos una instancia global de GetIt
final sl = GetIt.instance;

Future<void> init() async {
  // --- FEATURES - AUTHENTICATION ---

  // Casos de Uso
  sl.registerFactory(() => DeleteAccountUseCase(
        authRepository: sl(),
        userProfileRepository: sl(),
      ));
  sl.registerFactory(() => SignInUseCase(repository: sl()));
  sl.registerFactory(() => CreateAccountUseCase(repository: sl()));
  sl.registerFactory(() => SignOutUseCase(repository: sl()));
  sl.registerFactory(() => SendPasswordResetEmailUseCase(repository: sl()));
  sl.registerFactory(() => GetUserProfileUseCase(repository: sl()));
  sl.registerFactory(() => UpdateDisplayNameUseCase(repository: sl()));
  sl.registerFactory(() => UpdateEmailUseCase(repository: sl()));
  sl.registerFactory(() => UpdatePasswordUseCase(repository: sl()));
  sl.registerFactory(() => ReauthenticateUseCase(repository: sl()));


  // Repositorio
  // Se registra como 'lazySingleton' porque solo necesitamos una instancia en toda la app.
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Fuente de Datos
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  // --- FEATURES - PROFILE ---
  sl.registerFactory(() => SaveUserProfileUseCase(repository: sl()));
  sl.registerLazySingleton<UserProfileRepository>(() => UserProfileRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserProfileRemoteDataSource>(() => UserProfileRemoteDataSourceImpl(firestore: sl(), auth: sl()));
  sl.registerFactory(() => CalculateCaloricConsumptionUseCase());
  sl.registerFactory(() => UpdateUserProfileUseCase(repository: sl()));

  // --- FEATURES - PRODUCTS ---
  sl.registerFactory(() => GetProductByBarcodeUseCase(repository: sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(client: sl()));

  // Registramos la instancia de FirebaseAuth para que esté disponible en toda la app.
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}