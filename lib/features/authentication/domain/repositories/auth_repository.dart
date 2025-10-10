import 'package:firebase_auth/firebase_auth.dart'; // Usamos User por conveniencia, idealmente sería una entidad propia

abstract class AuthRepository {
  // Un stream para escuchar los cambios de estado de autenticación
  Stream<User?> get authStateChanges;

  // Métodos para las acciones de autenticación
  Future<void> signInWithEmailAndPassword({required String email, required String password});
  Future<void> createUserWithEmailAndPassword({required String email, required String password});
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signOut();
  Future<void> deleteAccount();
}