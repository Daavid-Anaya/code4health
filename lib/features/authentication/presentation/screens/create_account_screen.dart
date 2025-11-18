import 'package:code4health/features/authentication/domain/usecases/create_account_use_case.dart';
import 'package:code4health/features/authentication/presentation/screens/user_info_screen.dart';
import 'package:code4health/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/auth_navigation_link.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/img_widgets.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/text_widgets.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  
  // Controladores para los campos de texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // Variable para el estado de carga
  bool _isLoading = false;

  // Obtenemos la instancia del caso de uso desde el service locator
  final CreateAccountUseCase _createAccountUseCase = sl<CreateAccountUseCase>();

  // Limpiamos los controladores
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Lógica para crear la cuenta
  Future<void> _createAccount() async {
    // Validar que las contraseñas coincidan
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() { _isLoading = true; });

    try {
      // Llamar al caso de uso
      await _createAccountUseCase.call(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const UserInfoScreen()),
              (Route<dynamic> route) => false,
        );
      }

    } on FirebaseAuthException catch (e) {
      String message = "Ocurrió un error al crear la cuenta.";
      if (e.code == 'weak-password') {
        message = 'La contraseña es muy débil (debe tener al menos 6 caracteres).';
      } else if (e.code == 'email-already-in-use') {
        message = 'Ya existe una cuenta con este correo electrónico.';
      } else if (e.code == 'invalid-email') {
        message = 'El formato del correo electrónico no es válido.';
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

    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: 28.0),
            child: ConstrainedBox(constraints: BoxConstraints(
              minHeight: screenHeight - (kToolbarHeight + MediaQuery.of(context).padding.top),
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  // Logo de la aplicación
                  ImgWidgets(proporcion:  screenHeight),
                  SizedBox(height: screenHeight * 0.04),

                  // Titulo
                  TextWidgets(title: "Crear Cuenta", stylee: TextStyles.encabezado(context),),
                  SizedBox(height: screenHeight * 0.04),

                  // Campo de texto para el Email
                  SizedBox(
                    height: 50,
                    child: CustomTextField(
                      controller: _emailController,
                      labelText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Campo de texto para la Contraseña
                  SizedBox(
                    height: 50,
                    child: CustomTextField(
                      controller: _passwordController,
                      labelText: "Contraseña",
                      isPassword: true,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Campo de texto para Confirmar Contraseña
                  SizedBox(
                    height: 50,
                    child: CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: "Confirmar Contraseña",
                      isPassword: true,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Botón de Registrarme
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: PrimaryActionButton(
                      text: _isLoading ? 'Creando...' : 'Registrarme',
                      onPressed: _isLoading ? null : _createAccount,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Texto y botón para iniciar sesión
                  AuthNavigationLink(
                    promptText: '¿Ya tienes una cuenta?',
                    linkText: 'Iniciar Sesión',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
