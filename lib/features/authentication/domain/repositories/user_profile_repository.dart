import '../entities/user_profile_entity.dart';

abstract class UserProfileRepository {
  Future<void> saveUserProfile(Map<String, dynamic> userData);
  Stream<UserProfileEntity?> getUserProfileStream();
  Future<void> deleteUserData(String userId);
  Future<void> updateUserProfile(Map<String, dynamic> data);
}