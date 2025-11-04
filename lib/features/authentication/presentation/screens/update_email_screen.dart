import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../domain/error/exceptions.dart';
import '../../domain/usecases/sign_out_use_case.dart';
import '../../domain/usecases/update_email_use_case.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_app_bar.dart';

class UpdateEmailScreen extends StatefulWidget {
  const UpdateEmailScreen({super.key});

  @override
  State<UpdateEmailScreen> createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  // Inyecta el Caso de Uso y define el estado
  final _updateEmailUseCase = sl<UpdateEmailUseCase>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  // Carga el email actual del usuario al iniciar
  @override
  void initState() {
    super.initState();
    _emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Función para guardar los cambios de email
  Future<void> _saveEmail() async {
    // Validación
    if (_emailController.text.trim().isEmpty || !_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa un email válido.'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() { _isLoading = true; });

    try {
      // Llama al caso de uso
      await _updateEmailUseCase.call(_emailController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email actualizado. Revisa tu bandeja de entrada para verificarlo.'), backgroundColor: Colors.green),
        );
        Navigator.of(context).pop();
      }
    } on RequiresRecentLoginException {
      // Maneja el error de seguridad específico
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Esta acción es sensible. Por favor, vuelve a iniciar sesión.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
        // Cierra la sesión del usuario para forzar el re-login
        sl<SignOutUseCase>().call();
      }
    } on FirebaseAuthException catch (e) {
      // Manejo de errores de Firebase
      String message = 'Ocurrió un error.';
      if (e.code == 'email-already-in-use') {
        message = 'Este email ya está en uso por otra cuenta.';
      } else if (e.code == 'invalid-email') {
        message = 'El email no es válido.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
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
        title: 'Email',
        onSave: _saveEmail,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomTextField(
          labelText: 'Email',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress
        ),
      ),
    );
  }
}