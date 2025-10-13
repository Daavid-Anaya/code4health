import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  // abstracción del DataSource
  final AuthRemoteDataSource remoteDataSource;

  // Instancia de FirebaseAuth
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<User?> get authStateChanges => remoteDataSource.authStateChanges;

  @override
  Future<void> signInWithEmailAndPassword({required String email, required String password}) {
    return remoteDataSource.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> createUserWithEmailAndPassword({required String email, required String password}) {
    return remoteDataSource.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<void> deleteAccount() {
    return remoteDataSource.deleteAccount();
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return remoteDataSource.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername({required String username}) {
    return remoteDataSource.updateUsername(username: username);
  }

  @override
  String? getCurrentUserId() {
    return remoteDataSource.getCurrentUserId();
  }
}