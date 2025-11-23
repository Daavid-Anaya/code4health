import 'package:code4health/features/profile/presentation/screens/update_basic_data_screen.dart';
import 'package:code4health/features/profile/presentation/screens/update_cardio_data_screen.dart';
import 'package:code4health/features/profile/presentation/screens/update_email_screen.dart';
import 'package:code4health/features/profile/presentation/screens/update_name_screen.dart';
import 'package:code4health/features/profile/presentation/screens/update_password_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/profile_option_tile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Editar perfil', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.bar,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar y botón de editar foto
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: CircleAvatar(
                  radius: screenWidth * 0.16,
                  backgroundColor: Colors.grey.shade800,
                  child: Icon(Icons.person, size: screenWidth * 0.12, color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implementar lógica para seleccionar imagen (Image Picker)
                },
                child: const Text(
                  'Editar',
                  style: TextStyle(color: AppColors.primary, fontSize: 16),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // --- Opciones de Navegación ---
              ProfileOptionTile(
                title: 'Actualizar nombre',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateNameScreen()));
                },
              ),
              SizedBox(height: screenHeight * 0.02),

              ProfileOptionTile(
                title: 'Actualizar Email',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateEmailScreen()));
                },
              ),
              SizedBox(height: screenHeight * 0.02),

              ProfileOptionTile(
                title: 'Cambiar contraseña',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdatePasswordScreen()));
                },
              ),
              SizedBox(height: screenHeight * 0.02),

              ProfileOptionTile(
                title: 'Actualizar datos básicos',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateBasicDataScreen()));
                },
              ),
              SizedBox(height: screenHeight * 0.02),

              ProfileOptionTile(
                title: 'Actualizar datos cardiovasculares',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateCardioDataScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}