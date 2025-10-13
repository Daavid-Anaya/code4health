import '../../domain/repositories/user_profile_repository.dart';
import '../datasources/user_profile_remote_data_source.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveUserProfile(Map<String, dynamic> userData) {
    return remoteDataSource.saveUserProfile(userData);
  }

   @override
  Future<void> deleteUserData(String userId) async {
    try {
      await remoteDataSource.deleteUserData(userId);
    } catch (e) {
      // Maneja o relanza el error
      rethrow;
    }
  }
}