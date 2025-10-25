import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/titled_switch.dart';
import 'custom_app_bar.dart';

class UpdateCardioDataScreen extends StatefulWidget {
  const UpdateCardioDataScreen({super.key});

  @override
  State<UpdateCardioDataScreen> createState() => _UpdateCardioDataScreenState();
}

class _UpdateCardioDataScreenState extends State<UpdateCardioDataScreen> {
  // --- Estado MOVIDO aquí ---
  bool _tratamientoHipertension = false;
  bool _fumador = false;
  bool _diabetico = false;

  // Añadimos controladores para los campos de texto
  final _presionController = TextEditingController();
  final _hdlController = TextEditingController();
  final _colesterolController = TextEditingController();

  @override
  void dispose() {
    _presionController.dispose();
    _hdlController.dispose();
    _colesterolController.dispose();
    super.dispose();
  }

  void _saveCardioData() {
    // TODO: Lógica para guardar todos los datos cardiovasculares
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildSubPageAppBar(
        context: context,
        title: 'cardio',
        onSave: _saveCardioData,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.02),
          child: Column(
            children: [
              // --- Widgets MOVIDOS aquí ---
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
              SizedBox(height: screenHeight * 0.03), // Más espacio antes de los campos

              CustomTextField(
                labelText: 'Presión sanguínea sistólica (mmHg)',
                controller: _presionController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                labelText: 'HDL (lipoproteína de alta densidad)',
                controller: _hdlController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                labelText: 'Colesterol',
                controller: _colesterolController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}