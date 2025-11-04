import '../repositories/auth_repository.dart';

class UpdateDisplayNameUseCase {
  final AuthRepository repository;
  UpdateDisplayNameUseCase({required this.repository});

  Future<void> call(String newName) {
    return repository.updateDisplayName(newName);
  }
}