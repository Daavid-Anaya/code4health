
import 'package:code4health/features/authentication/domain/repositories/auth_repository.dart';

class SendPasswordResetEmailUseCase {
  final AuthRepository repository;

  SendPasswordResetEmailUseCase({required this.repository});

  Future<void> call(String email) async {
    return await repository.sendPasswordResetEmail(email: email);
  }
}