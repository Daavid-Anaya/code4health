import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:code4health/features/authentication/presentation/screens/main_screen.dart';
import 'package:code4health/features/authentication/presentation/screens/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return const MainScreen(); // Usuario ha iniciado sesión
        } else {
          return const LoginScreen(); // Usuario NO ha iniciado sesión
        }
      },
    );
  }
}