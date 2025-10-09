import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/auth_navigation_link.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/img_widgets.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/text_widgets.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final screenPadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: 28.0),
            child: ConstrainedBox(constraints: BoxConstraints(
              minHeight: screenHeight - screenPadding.top - screenPadding.bottom,
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  // Logo de la aplicación
                  ImgWidgets(proporcion:  screenHeight),
                  SizedBox(height: screenHeight * 0.04),

                  // Titulo
                  TextWidgets(title: "Crear Cuenta", stylee: TextStyles.encabezado,),
                  SizedBox(height: screenHeight * 0.04),

                  // Campo de texto para el Nombre email
                  SizedBox(
                    height: 50,
                    child: const CustomTextField(labelText: "Nombre")
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Campo de texto para el Email
                  SizedBox(
                    height: 50,
                    child: const CustomTextField(labelText: "Email", keyboardType: TextInputType.emailAddress)
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Campo de texto para la Contraseña
                  SizedBox(
                    height: 50,
                    child: const CustomTextField(labelText: "Contraseña", isPassword: true)
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Campo de texto para Confirmar Contraseña
                  SizedBox(
                    height: 50,
                    child: const CustomTextField(
                      labelText: "Confirmar Contraseña", isPassword: true,
                    )
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Botón de Registrarme
                  FractionallySizedBox(
                    widthFactor: 0.4,
                    child: PrimaryActionButton(
                      text: 'Registrarme',
                      onPressed: () {
                        // TODO: Lógica para iniciar sesión

                      },
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
