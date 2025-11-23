import '../repositories/user_profile_repository.dart';

class UpdateUserProfileUseCase {
  final UserProfileRepository repository;
  UpdateUserProfileUseCase({required this.repository});

  Future<void> call(Map<String, dynamic> data) {
    return repository.updateUserProfile(data);
  }
}