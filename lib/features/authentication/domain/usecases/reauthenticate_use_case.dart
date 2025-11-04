import '../repositories/auth_repository.dart';

class ReauthenticateUseCase {
  final AuthRepository repository;
  ReauthenticateUseCase({required this.repository});

  Future<void> call({required String email, required String password}) {
    return repository.reauthenticateWithCredential(email, password);
  }
}