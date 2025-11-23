import 'package:code4health/features/profile/domain/repositories/user_profile_repository.dart';

class SaveUserProfileUseCase {
  final UserProfileRepository repository;

  SaveUserProfileUseCase({required this.repository});

  Future<void> call({required Map<String, dynamic> userData}) {
    return repository.saveUserProfile(userData);
  }
}