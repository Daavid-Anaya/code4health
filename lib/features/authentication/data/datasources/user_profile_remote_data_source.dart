import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserProfileRemoteDataSource {
  Future<void> saveUserProfile(Map<String, dynamic> userData);
  Future<void> deleteUserData(String userId);
  Stream<Map<String, dynamic>?> getUserProfileStream();
  Future<void> updateUserProfile(Map<String, dynamic> data);
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserProfileRemoteDataSourceImpl({required this.firestore, required this.auth});

  @override
  Future<void> saveUserProfile(Map<String, dynamic> userData) {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado.');
    }
    return firestore.collection('users').doc(user.uid).set(userData);
  }

  @override
  Future<void> deleteUserData(String userId) async {
    final userDocRef = firestore.collection('users').doc(userId);
    await userDocRef.delete();
  }

  @override
  Stream<Map<String, dynamic>?> getUserProfileStream() {
    final user = auth.currentUser;
    if (user == null) {
      // Emite un stream con un valor nulo si no hay usuario
      return Stream.value(null);
    }

    // .snapshots() devuelve un Stream que emite automáticamente cada vez que el documento cambia
    return firestore.collection('users').doc(user.uid).snapshots().map((snapshot) {
      return snapshot.data();
    });
  }

  @override
  Future<void> updateUserProfile(Map<String, dynamic> data) {
    final user = auth.currentUser;
    if (user == null) throw Exception('Usuario no autenticado.');

    // Usamos .update() para no sobrescribir el documento, solo cambiar campos
    return firestore.collection('users').doc(user.uid).update(data);
  }
}