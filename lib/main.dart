import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'features/authentication/presentation/screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  // Aseguramos que los widgets de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
