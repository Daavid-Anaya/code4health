import 'dart:math';
import 'package:code4health/core/constants/app_colors.dart';
import 'package:code4health/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:code4health/injection_container.dart';
import '../../domain/usecases/sign_in_use_case.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/auth_navigation_link.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/img_widgets.dart';
import '../widgets/or_divider.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/text_widgets.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Controladores para obtener el texto de los campos
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Variable para manejar el estado de carga
  bool _isLoading = false;

  // Obtenemos la instancia del caso de uso desde el service locator
  final SignInUseCase _signInUseCase = sl<SignInUseCase>();

  // Limpiamos los controladores al destruir el widget
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Lógica de inicio de sesión
  Future<void> _signIn() async {
    setState(() { _isLoading = true; });

    try {
      await _signInUseCase.call(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

    } on FirebaseAuthException catch (e) {
      String message = "Ocurrió un error. Inténtalo de nuevo.";
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = "Correo o contraseña incorrectos.";
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
    final currentDiagonal = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: 28.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
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
                  TextWidgets(title: "Iniciar Sesión", stylee: TextStyles.encabezado(context),),
                  SizedBox(height: screenHeight * 0.04),

                  // Campo de texto para el Email
                  SizedBox(
                    height: 50,
                    child: CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Campo de texto para la Contraseña
                  SizedBox(
                    height: 50,
                    child: CustomTextField(
                      controller: _passwordController,
                      labelText: 'Contraseña',
                      isPassword: true,
                      keyboardType: TextInputType.text
                    ),
                  ),
                  //SizedBox(height: screenHeight * 0.03),

                  // Enlace para "¿Olvidaste tu contraseña?"
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                          );
                        },
                        child: Text('¿Olvidaste tu contraseña?', style: TextStyles.leyenda(context)),
                      ),
                    ),
                  ),

                  // Botón de Iniciar
                  FractionallySizedBox(
                    widthFactor: 0.6,
                      child: PrimaryActionButton(
                        text: _isLoading ? 'Ingresando...' : 'Iniciar',
                        onPressed: _isLoading ? null : _signIn, // Se deshabilita durante la carga
                      ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Divisor con "O"
                  const OrDivider(),
                  SizedBox(height: screenHeight * 0.03),

                  // Botones de inicio de sesión social
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Usamos CircleAvatar para crear los círculos
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.grey700,
                        // child: Icon(Icons.google, color: Colors.white), // Ejemplo con un icono
                      ),
                      SizedBox(width: screenWidth * 0.06),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.grey700,
                      ),
                      SizedBox(width: screenWidth * 0.06),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.grey700,
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.05),

                  // Texto y botón para registrarse
                  AuthNavigationLink(
                    promptText: 'No tienes una cuenta',
                    linkText: 'Registrarme',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}