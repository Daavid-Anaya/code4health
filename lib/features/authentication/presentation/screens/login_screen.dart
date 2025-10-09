import 'package:code4health/features/authentication/presentation/screens/user_info_screen.dart';
import 'package:code4health/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/auth_navigation_link.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/img_widgets.dart';
import '../widgets/or_divider.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/text_widgets.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  TextWidgets(title: "Iniciar Sesión", stylee: TextStyles.encabezado,),
                  SizedBox(height: screenHeight * 0.04),
              
                  // Campo de texto para el Nombre
                  SizedBox(
                    height: 50,
                    child: const CustomTextField(
                      labelText: 'Nombre',
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
              
                  // Campo de texto para la Contraseña
                  SizedBox(
                    height: 50,
                    child: const CustomTextField(
                      labelText: 'Contraseña',
                      isPassword: true,
                      keyboardType: TextInputType.text
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
              
                  // Botón de Iniciar
                  FractionallySizedBox(
                    widthFactor: 0.4,
                      child: PrimaryActionButton(
                        text: 'Iniciar',
                        onPressed: () {
                          // TODO: Lógica para iniciar sesión
              
                          // Después de registrar al usuario, navega a la pantalla de información
                          Navigator.of(context).pushReplacement( // Usamos pushReplacement para que el usuario no pueda volver a "Crear Cuenta"
                            MaterialPageRoute(builder: (context) => UserInfoScreen()),
                          );
                        },
                      ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
              
                  // Divisor con "O"
                  const OrDivider(),
                  SizedBox(height: screenHeight * 0.04),
              
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
                      // TODO: Navegar a la pantalla de registro
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