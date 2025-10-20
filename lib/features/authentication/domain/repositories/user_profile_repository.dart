import '../entities/user_profile_entity.dart';

abstract class UserProfileRepository {
  Future<void> saveUserProfile(Map<String, dynamic> userData);
  Future<void> deleteUserData(String userId);
  Future<UserProfileEntity?> getUserProfile();
}