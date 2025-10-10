import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call({required String email, required String password}) {
    return repository.signInWithEmailAndPassword(email: email, password: password);
  }
}