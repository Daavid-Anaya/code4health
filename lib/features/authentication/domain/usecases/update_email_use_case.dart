import 'package:firebase_auth/firebase_auth.dart';
import '../error/exceptions.dart';
import '../repositories/auth_repository.dart';

class UpdateEmailUseCase {
  final AuthRepository repository;
  UpdateEmailUseCase({required this.repository});

  Future<void> call(String newEmail) async {
    try {
      //await repository.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw RequiresRecentLoginException();
      }
      rethrow;
    }
  }
}