import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'features/authentication/data/datasources/auth_remote_data_source.dart';
import 'features/authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/delete_account_use_case.dart';
import 'features/authentication/domain/usecases/sign_in_use_case.dart';

// Creamos una instancia global de GetIt
final sl = GetIt.instance;

Future<void> init() async {
  // --- FEATURES - AUTHENTICATION ---

  // Casos de Uso (Use Cases)
  // Se registran como 'factory' porque generalmente solo se necesitan para una única acción.
  sl.registerFactory(() => DeleteAccountUseCase(repository: sl()));
  sl.registerFactory(() => SignInUseCase(repository: sl()));
  // Aquí registrarías otros casos de uso, por ejemplo:
  // sl.registerFactory(() => CreateAccountUseCase(repository: sl()));
  // sl.registerFactory(() => SignOutUseCase(repository: sl()));


  // Repositorio (Repository)
  // Se registra como 'lazySingleton' porque solo necesitamos una instancia en toda la app.
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Fuente de Datos (Data Source)
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );


  // --- EXTERNAL ---
  // Registramos la instancia de FirebaseAuth para que esté disponible en toda la app.
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}