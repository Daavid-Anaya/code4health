import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_profile_entity.dart';
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

  @override
  Future<UserProfileEntity?> getUserProfile() async {
    final user = FirebaseAuth.instance.currentUser; // Necesitamos el nombre y UID
    if (user == null) return null;

    final data = await remoteDataSource.getUserProfile();
    if (data != null) {
      // Convertimos el mapa de Firestore a nuestra entidad de dominio
      return UserProfileEntity(
        uid: user.uid,
        name: user.displayName ?? 'Sin nombre', // El nombre se puede guardar en Auth
        edad: data['edad'],
        peso: (data['peso'] as num).toDouble(),
        altura: (data['altura'] as num).toDouble(),
        sexo: data['sexo'],
        nivelActividad: data['nivelActividad'],
      );
    }
    return null;
  }
}