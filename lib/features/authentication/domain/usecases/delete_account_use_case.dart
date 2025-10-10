import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';
import '../error/exceptions.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase({required this.repository});

  Future<void> call() async {
    try {
      await repository.deleteAccount();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // Capturamos el error de Firebase y lanzamos nuestra propia excepción
        throw RequiresRecentLoginException();
      } else {
        // Relanzamos cualquier otro error de Firebase
        rethrow;
      }
    }
  }
}