import 'package:code4health/features/authentication/presentation/screens/user_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code4health/features/scanner/presentation/screens/main_screen.dart';
import 'package:code4health/features/authentication/presentation/screens/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si el usuario no ha iniciado sesión, mostramos LoginScreen
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // Si el usuario sí ha iniciado sesión, comprobamos si ha completado el onboarding
        return FutureBuilder<DocumentSnapshot>(
          // Hacemos una consulta a Firestore para ver si el documento del usuario existe
          future: FirebaseFirestore.instance.collection('users').doc(snapshot.data!.uid).get(),
          builder: (context, userSnapshot) {
            
            // Mientras esperamos la respuesta de Firestore, mostramos un loader
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (userSnapshot.hasData && userSnapshot.data!.exists) {
              // Si el documento existe, el usuario ya completó el onboarding -> vamos a MainScreen
              return const MainScreen();
            } else {
              // Si el documento no existe, es un usuario nuevo -> vamos a UserInfoScreen
              return const UserInfoScreen();
            }
          },
        );
      },
    );
  }
}