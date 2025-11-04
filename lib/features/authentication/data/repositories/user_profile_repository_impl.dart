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
  Stream<UserProfileEntity?> getUserProfileStream() {
    // Escuchamos el stream de nuestro data source
    return remoteDataSource.getUserProfileStream().asyncMap((data) {
      // Esta lógica se ejecuta cada vez que el stream emite nuevos datos
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || data == null) {
        return null;
      }

      // Mapea los datos del stream a nuestra entidad
      return UserProfileEntity(
        uid: user.uid,
        name: user.displayName ?? 'Sin nombre', // El nombre se actualiza reactivamente desde Auth
        edad: data['edad'],
        peso: (data['peso'] as num).toDouble(),
        altura: (data['altura'] as num).toDouble(),
        sexo: data['sexo'],
        nivelActividad: data['nivelActividad'],

        tratamientoHipertension: data['tratamientoHipertension'] ?? false,
        fumador: data['fumador'] ?? false,
        diabetico: data['diabetico'] ?? false,
        presionSistolica: data['presionSistolica'],
        hdl: data['hdl'],
        colesterol: data['colesterol'],
      );
    });
  }

  @override
  Future<void> updateUserProfile(Map<String, dynamic> data) {
    return remoteDataSource.updateUserProfile(data);
  }
}