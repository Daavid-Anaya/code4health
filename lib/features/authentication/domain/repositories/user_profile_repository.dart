abstract class UserProfileRepository {
  Future<void> saveUserProfile(Map<String, dynamic> userData);
  Future<void> deleteUserData(String userId);
}