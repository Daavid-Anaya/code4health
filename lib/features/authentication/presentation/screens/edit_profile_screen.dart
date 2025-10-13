import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/gender_selector.dart';
import '../widgets/info_card.dart';
import '../widgets/titled_switch.dart';
import '../widgets/value_stepper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  // Info Básica
  String? _selectedGender;

  // Stats Físicos
  double _altura = 170;
  int _edad = 28;
  int _peso = 70;
  String? _selectedNivelActividad;

  // Campos Opcionales
  bool _tratamientoHipertension = false;
  bool _fumador = false;
  bool _diabetico = false;

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.bar,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Avatar
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: CircleAvatar(
                  radius: screenWidth * 0.16,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: screenWidth * 0.12, color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Campos de texto
              Column(
                children: [
                  CustomTextField(labelText:'Nombre'),
                  const SizedBox(height: 12),
                  CustomTextField(labelText: 'Email'),
                  const SizedBox(height: 12),
                  CustomTextField(labelText: 'Contraseña', isPassword: true),
                  const SizedBox(height: 12),
                  CustomTextField(labelText: 'Confirmar Contraseña', isPassword: true),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Selector de Género
              Container(
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundContainer,
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    border: Border.all(color: AppColors.backgroundContainer, width: 2),
                  ),
                child: Row(
                  children: [
                    Expanded(
                      child: GenderSelector(
                        gender: 'Hombre',
                        icon: Icons.male,
                        isSelected: _selectedGender == 'Hombre',
                        onTap: () => setState(() => _selectedGender = 'Hombre'),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: GenderSelector(
                        gender: 'Mujer',
                        icon: Icons.female,
                        isSelected: _selectedGender == 'Mujer',
                        onTap: () => setState(() => _selectedGender = 'Mujer'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Slider de Altura
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Altura: ${_altura.toInt()} cm', style: TextStyles.parrafo),
                    Slider(
                      value: _altura,
                      min: 120,
                      max: 220,
                      divisions: 100,
                      label: _altura.round().toString(),
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.backgroundComponentSelect,
                      onChanged: (double value) {
                        setState(() {
                          _altura = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Steppers de Edad y Peso
              Row(
                children: [
                  Expanded(
                    child: ValueStepper(
                      label: 'Edad',
                      value: _edad,
                      onDecrement: () => setState(() => _edad--),
                      onIncrement: () => setState(() => _edad++),
                      screenHeight: screenHeight,
                    ),
                  ),
                  SizedBox(width: screenHeight * 0.02),
                  Expanded(
                    child: ValueStepper(
                      label: 'Peso',
                      value: _peso,
                      onDecrement: () => setState(() => _peso--),
                      onIncrement: () => setState(() => _peso++),
                      screenHeight: screenHeight,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Nivel de Actividad
              InfoCard(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedNivelActividad,
                  hint: Text('Selecciona tu nivel de actividad', style: TextStyle(color: Colors.grey[400])),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Colors.grey[800],
                  decoration: const InputDecoration(
                    labelText: 'Nivel de actividad',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none, // Quitamos el borde del dropdown
                  ),
                  items: <String>['Sedentario', 'Ligero', 'Moderado', 'Activo', 'Muy Activo']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedNivelActividad = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Título de Campos Opcionales
              const Text('Campos opcionales', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: screenHeight * 0.02),

              // Switches
              TitledSwitch(
                label: 'Tratamiento de hipertensión',
                value: _tratamientoHipertension,
                onChanged: (val) => setState(() => _tratamientoHipertension = val),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    child: TitledSwitch(
                      label: 'Fumador',
                      value: _fumador,
                      onChanged: (val) => setState(() => _fumador = val),
                    ),
                  ),
                  SizedBox(width: screenHeight * 0.04),
                  Expanded(
                    child: TitledSwitch(
                      label: 'Diabético',
                      value: _diabetico,
                      onChanged: (val) => setState(() => _diabetico = val),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // campos de texto
              Column(
                children: [
                  CustomTextField(labelText: 'Presión sanguínea sistólica (mmHg)'),
                  const SizedBox(height: 12),
                  CustomTextField(labelText: 'HDL (lipoproteína de alta densidad)'),
                  const SizedBox(height: 12),
                  CustomTextField(labelText: 'Colesterol'),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              // Botón de Guardar
              FractionallySizedBox(
                widthFactor: 0.4,
                child: PrimaryActionButton(
                  text: 'Guardar',
                  onPressed: () {
                    // TODO: Lógica para guardar todos los datos del perfil

                    Navigator.of(context).pop(); // Regresa a la pantalla de perfil
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

            ],
          ),
        ),
      ),
    );
  }
}
