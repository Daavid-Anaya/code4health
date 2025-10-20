import '../entities/user_profile_entity.dart';
import '../repositories/user_profile_repository.dart';

class GetUserProfileUseCase {
  final UserProfileRepository repository;

  GetUserProfileUseCase({required this.repository});

  Future<UserProfileEntity?> call() {
    return repository.getUserProfile();
  }
}