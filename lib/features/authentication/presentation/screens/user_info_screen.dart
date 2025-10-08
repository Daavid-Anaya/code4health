import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/text_styles.dart';
import '../widgets/custom_dropdown_form_field.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_action_button.dart';
import 'main_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen ({super.key});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen > {
  // Variables para guardar los valores de los dropdowns
  String? _selectedSexo;
  String? _selectedNivelActividad;

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final EdgeInsets screenPadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: 0.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - kToolbarHeight - screenPadding.top,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //
                const Text(
                  'Registra los datos que se piden para conocer su estado de nutricón',
                  textAlign: TextAlign.center,
                  style: TextStyles.parrafo,
                ),
                SizedBox(height: screenHeight * 0.035),

                // Dropdown para genero
                SizedBox(
                  height: 50,
                  child: CustomDropdownFormField(
                    labelText: 'Sexo',
                    hintText: 'Selecciona tu sexo',
                    value: _selectedSexo,
                    items: const ['Masculino', 'Femenino'],
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSexo = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Campo de texto para Edad
                SizedBox(
                  height: 50,
                  child: const CustomTextField(
                    labelText: 'Edad',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Campo de texto para Peso
                SizedBox(
                  height: 50,
                  child: const CustomTextField(
                    labelText: 'Peso (kg)',
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Campo de texto para Altura
                SizedBox(
                  height: 50,
                  child: const CustomTextField(
                    labelText: 'Altura (cm)',
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Dropdown para Nivel de actividad
                SizedBox(
                  height: 50,
                  child: CustomDropdownFormField(
                    labelText: 'Nivel de actividad',
                    hintText: 'Selecciona tu nivel de actividad',
                    value: _selectedNivelActividad,
                    items: const ['Sedentario', 'Ligero', 'Moderado', 'Activo', 'Muy Activo'],
                    onChanged: (newValue) {
                      setState(() {
                        _selectedNivelActividad = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // Botón de Continuar
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: PrimaryActionButton(
                    text: 'Continuar',
                    onPressed: () {
                      // TODO: Lógica para guardar los datos y continuar

                      // Navega a la pantalla principal y elimina todas las rutas anteriores
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const MainScreen()),
                            (Route<dynamic> route) => false, // Esta condición elimina todas las rutas anteriores
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

