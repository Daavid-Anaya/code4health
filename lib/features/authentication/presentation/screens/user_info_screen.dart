import 'package:code4health/features/authentication/domain/usecases/save_user_profile_use_case.dart';
import 'package:code4health/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
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
  final  _edadController = TextEditingController();
  final  _pesoController = TextEditingController();
  final  _alturaController = TextEditingController();
   bool _isLoading = false;

   // Obtenemos el caso de uso desde el service locator
  final SaveUserProfileUseCase _saveUserProfileUseCase = sl<SaveUserProfileUseCase>();
  
  // Limpiamos los controladores para evitar fugas de memoria
  @override
  void dispose() {
    _edadController.dispose();
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    // Validación de campos
    if (_selectedSexo == null || _selectedNivelActividad == null || _edadController.text.isEmpty || _pesoController.text.isEmpty || _alturaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.'), backgroundColor: Colors.orange),
      );
      return;
    }
    
    // Conversión de datos (Parsing) con manejo de errores
    final int? edad = int.tryParse(_edadController.text);
    final double? peso = double.tryParse(_pesoController.text);
    final double? altura = double.tryParse(_alturaController.text);

    if (edad == null || peso == null || altura == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa valores numéricos válidos.'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() { _isLoading = true; });

    final Map<String, dynamic> userData = {
      'edad': edad,
      'peso': peso,
      'altura': altura,
      'sexo': _selectedSexo!,
      'nivelActividad': _selectedNivelActividad!,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      // Llamada al caso de uso
      await _saveUserProfileUseCase.call(userData: userData);

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainScreen()),
              (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar los datos: ${e.toString()}'), backgroundColor: Colors.red),
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
                // Texto de instrucciones
                Text(
                  'Registra los datos que se piden para conocer su estado de nutrición',
                  textAlign: TextAlign.center,
                  style: TextStyles.parrafo(context),
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
                  child: CustomTextField(
                    controller: _edadController,
                    labelText: 'Edad',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Campo de texto para Peso
                SizedBox(
                  height: 50,
                  child: CustomTextField(
                    controller: _pesoController,
                    labelText: 'Peso (kg)',
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Campo de texto para Altura
                SizedBox(
                  height: 50,
                  child: CustomTextField(
                    controller: _alturaController,
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
                    hintText: 'Selecciona nivel de actividad',
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
                  widthFactor: 0.6,
                  child: PrimaryActionButton(
                    text: _isLoading ? 'Guardando...' : 'Continuar',
                    onPressed: _isLoading ? null : _saveProfile,
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