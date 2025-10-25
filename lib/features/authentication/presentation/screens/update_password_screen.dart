import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import 'custom_app_bar.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _savePassword() {
    // TODO: Lógica para cambiar la contraseña
    Navigator.pop(context);
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