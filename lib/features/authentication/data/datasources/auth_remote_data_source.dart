import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> get authStateChanges;
  Future<void> signInWithEmailAndPassword({required String email, required String password});
  Future<void> createUserWithEmailAndPassword({required String email, required String password});
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signOut();
  Future<void> deleteAccount();
  Future<void> updateUsername({required String username});
  String? getCurrentUserId();
  Future<void> updateDisplayName(String newName);
  //Future<void> updateEmail(String newEmail);
  Future<void> updatePassword(String newPassword);
  Future<void> reauthenticateWithCredential(String email, String password);
}