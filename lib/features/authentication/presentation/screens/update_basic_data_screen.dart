import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/gender_selector.dart';
import '../widgets/info_card.dart';
import '../widgets/value_stepper.dart';
import 'custom_app_bar.dart';

class UpdateBasicDataScreen extends StatefulWidget {
  const UpdateBasicDataScreen({super.key});

  @override
  State<UpdateBasicDataScreen> createState() => _UpdateBasicDataScreenState();
}

class _UpdateBasicDataScreenState extends State<UpdateBasicDataScreen> {
  // --- Estado MOVIDO aquí desde tu EditProfileScreen original ---
  String? _selectedGender;
  double _altura = 170;
  int _edad = 28;
  int _peso = 70;
  String? _selectedNivelActividad;

  void _saveBasicData() {
    // TODO: Lógica para guardar todos los datos básicos
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildSubPageAppBar(
        context: context,
        title: 'Datos básicos',
        onSave: _saveBasicData,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            children: [
              // --- Widgets MOVIDOS aquí ---
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

              InfoCard(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedNivelActividad,
                  hint: Text('Selecciona tu nivel de actividad', style: TextStyle(color: Colors.grey[400])),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Colors.grey[800],
                  decoration: const InputDecoration(
                    labelText: 'Nivel de actividad',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
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
            ],
          ),
        ),
      ),
    );
  }
}