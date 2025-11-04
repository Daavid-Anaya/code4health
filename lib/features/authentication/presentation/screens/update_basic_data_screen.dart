import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/get_user_profile_use_case.dart';
import '../../domain/usecases/update_user_profile_use_case.dart';
import '../widgets/gender_selector.dart';
import '../widgets/info_card.dart';
import '../widgets/value_stepper.dart';
import '../widgets/custom_app_bar.dart';

class UpdateBasicDataScreen extends StatefulWidget {
  const UpdateBasicDataScreen({super.key});

  @override
  State<UpdateBasicDataScreen> createState() => _UpdateBasicDataScreenState();
}

class _UpdateBasicDataScreenState extends State<UpdateBasicDataScreen> {
  // Inyecta Casos de Uso
  final _getUserProfileUseCase = sl<GetUserProfileUseCase>();
  final _updateUserProfileUseCase = sl<UpdateUserProfileUseCase>();

  // Define los estados de carga
  bool _isScreenLoading = true; // Para la carga inicial
  bool _isSaving = false; // Para el proceso de guardado

  // Variables de estado
  String? _selectedGender;
  double _altura = 170;
  int _edad = 28;
  int _peso = 70;
  String? _selectedNivelActividad;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Lógica para cargar los datos del usuario
  Future<void> _loadData() async {
    try {
      final UserProfileEntity? profile = await _getUserProfileUseCase.call().first;
      if (profile != null) {
        // Rellena los widgets con los datos de Firestore
        setState(() {
          _selectedGender = profile.sexo;
          _altura = profile.altura;
          _edad = profile.edad;
          _peso = profile.peso.toInt();
          _selectedNivelActividad = profile.nivelActividad;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() { _isScreenLoading = false; });
      }
    }
  }

  // Lógica para guardae los datos
  Future<void> _saveBasicData() async {
    // Validación
    if (_selectedGender == null || _selectedNivelActividad == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() { _isSaving = true; });

    // Crea el mapa solo con los datos que esta pantalla actualiza
    final Map<String, dynamic> dataToUpdate = {
      'sexo': _selectedGender,
      'altura': _altura,
      'edad': _edad,
      'peso': _peso,
      'nivelActividad': _selectedNivelActividad,
    };

    try {
      await _updateUserProfileUseCase.call(dataToUpdate);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos actualizados con éxito.'), backgroundColor: Colors.green),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() { _isSaving = false; });
      }
    }
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
      body: _isScreenLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            children: [
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
                      min: 0,
                      max: 220,
                      divisions: 220,
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
                  value: _selectedNivelActividad,
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