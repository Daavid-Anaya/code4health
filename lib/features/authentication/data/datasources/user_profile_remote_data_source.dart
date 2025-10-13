import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserProfileRemoteDataSource {
  Future<void> saveUserProfile(Map<String, dynamic> userData);
  Future<void> deleteUserData(String userId);
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
}