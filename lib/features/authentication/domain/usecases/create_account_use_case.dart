import '../repositories/auth_repository.dart';

class CreateAccountUseCase {
  final AuthRepository repository;

  CreateAccountUseCase({required this.repository});

  Future<void> call({required String email, required String password}) {
    return repository.createUserWithEmailAndPassword(email: email, password: password);
  }
}