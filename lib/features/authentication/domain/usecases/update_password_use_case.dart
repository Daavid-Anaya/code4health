import 'package:firebase_auth/firebase_auth.dart';
import '../error/exceptions.dart';
import '../repositories/auth_repository.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;
  UpdatePasswordUseCase({required this.repository});

  Future<void> call(String newPassword) async {
    try {
      await repository.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw RequiresRecentLoginException();
      }
      rethrow;
    }
  }
}