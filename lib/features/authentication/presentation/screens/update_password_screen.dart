import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/reauthenticate_use_case.dart';
import '../../domain/usecases/update_password_use_case.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_app_bar.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  // Inyecta los Casos de Uso
  final _updatePasswordUseCase = sl<UpdatePasswordUseCase>();
  final _reauthenticateUseCase = sl<ReauthenticateUseCase>();

  // Define los controladores y el estado de carga
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isLoading = false;

  // Carga el email actual del usuario
  @override
  void initState() {
    super.initState();
    _emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _savePassword() async {
    // Validación
    if (_currentPasswordController.text.isEmpty || _newPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.'), backgroundColor: Colors.orange),
      );
      return;
    }

    if (_newPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La nueva contraseña debe tener al menos 6 caracteres.'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() { _isLoading = true; });

    try {
      // Re-autenticar al usuario
      await _reauthenticateUseCase.call(
        email: _emailController.text.trim(),
        password: _currentPasswordController.text.trim(),
      );

      // Si la re-autenticación es exitosa, actualiza la contraseña
      await _updatePasswordUseCase.call(_newPasswordController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contraseña actualizada con éxito.'), backgroundColor: Colors.green),
        );
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      // Manejo de errores
      String message = 'Ocurrió un error.';
      if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
        message = 'La contraseña actual es incorrecta.';
      } else if (e.code == 'weak-password') {
        message = 'La nueva contraseña es muy débil.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      // Atrapa cualquier otro error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Un error inesperado ocurrió: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildSubPageAppBar(
        context: context,
        title: 'Contraseña',
        onSave: _savePassword,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Email',
              controller: _emailController,
              readOnly: true,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              labelText: 'Contraseña actual',
              isPassword: true,
              controller: _currentPasswordController,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              labelText: 'Nueva contraseña',
              isPassword: true,
              controller: _newPasswordController,
            ),
          ],
        ),
      ),
    );
  }
}