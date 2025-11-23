import 'package:code4health/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';
import '../error/exceptions.dart';

class DeleteAccountUseCase {
  final AuthRepository authRepository;
  final UserProfileRepository userProfileRepository;

  DeleteAccountUseCase({required this.authRepository, required this.userProfileRepository});

  Future<void> call() async {
    try {
      final String? userId = authRepository.getCurrentUserId();
      if (userId == null || userId.isEmpty) {
        throw Exception("Usuario no encontrado.");
      }

      await userProfileRepository.deleteUserData(userId);

      await authRepository.deleteAccount();
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // Capturamos el error de Firebase y lanzamos nuestra propia excepción
        throw RequiresRecentLoginException();
      } else {
        // Relanzamos cualquier otro error de Firebase
        rethrow;
      }
    } catch (e) {
      // Capturamos cualquier otro error y lo relanzamos
      rethrow;
    }
  }
}