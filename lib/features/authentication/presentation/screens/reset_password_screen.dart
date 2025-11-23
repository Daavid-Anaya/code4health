import 'package:code4health/core/constants/app_colors.dart';
import 'package:code4health/core/constants/text_styles.dart';
import 'package:code4health/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:code4health/features/authentication/presentation/widgets/primary_action_button.dart';
import 'package:code4health/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/send_password_reset_email_use_case.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  final _sendPasswordResetEmailUseCase = sl<SendPasswordResetEmailUseCase>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tu correo electrónico.')),
      );
      return;
    }

    setState(() { _isLoading = true; });

    try {
      await _sendPasswordResetEmailUseCase.call(_emailController.text.trim());
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Se ha enviado un enlace a tu correo.'), backgroundColor: Colors.green),
        );
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      String message = "Ocurrió un error.";
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        message = "No se encontró una cuenta con ese correo electrónico.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Restablecer Contraseña',
                textAlign: TextAlign.center,
                style: TextStyles.encabezado(context),
              ),
              SizedBox(height: screenHeight * 0.05),
        
              Text(
                'Ingresa el correo electrónico asociado a tu cuenta y te enviaremos un enlace para restablecer tu contraseña.',
                textAlign: TextAlign.center,
                style: TextStyles.etiqueta(context),
              ),
              SizedBox(height: screenHeight * 0.05),
        
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: screenHeight * 0.05),
        
              FractionallySizedBox(
                widthFactor: 0.6,
                child: PrimaryActionButton(
                  text: _isLoading ? 'Enviando...' : 'Restablecer',
                  onPressed: _isLoading ? null : _sendResetLink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}