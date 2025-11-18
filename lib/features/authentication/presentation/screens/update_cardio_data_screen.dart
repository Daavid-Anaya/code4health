import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/get_user_profile_use_case.dart';
import '../../domain/usecases/update_user_profile_use_case.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/titled_switch.dart';
import '../widgets/custom_app_bar.dart';

class UpdateCardioDataScreen extends StatefulWidget {
  const UpdateCardioDataScreen({super.key});

  @override
  State<UpdateCardioDataScreen> createState() => _UpdateCardioDataScreenState();
}

class _UpdateCardioDataScreenState extends State<UpdateCardioDataScreen> {
  // Inyecta los Casos de Uso
  final _getUserProfileUseCase = sl<GetUserProfileUseCase>();
  final _updateUserProfileUseCase = sl<UpdateUserProfileUseCase>();

  // Define los estados de carga
  bool _isScreenLoading = true;
  bool _isSaving = false;

  // Variables de estado
  bool _tratamientoHipertension = false;
  bool _fumador = false;
  bool _diabetico = false;

  final _presionController = TextEditingController();
  final _hdlController = TextEditingController();
  final _colesterolController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _presionController.dispose();
    _hdlController.dispose();
    _colesterolController.dispose();
    super.dispose();
  }

  // Lógica para cargar los datos
  Future<void> _loadData() async {
    try {
      final UserProfileEntity? profile = (_getUserProfileUseCase.call()) as UserProfileEntity?;
      if (profile != null) {
        // Rellena los widgets con los datos de Firestore
        setState(() {
          _tratamientoHipertension = profile.tratamientoHipertension ?? false;
          _fumador = profile.fumador ?? false;
          _diabetico = profile.diabetico ?? false;
          _presionController.text = profile.presionSistolica?.toString() ?? '';
          _hdlController.text = profile.hdl?.toString() ?? '';
          _colesterolController.text = profile.colesterol?.toString() ?? '';
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

  // Lógica para guardar los datos
  Future<void> _saveCardioData() async {
    setState(() { _isSaving = true; });

    // Usamos int.tryParse para convertir los strings a números de forma segura
    final Map<String, dynamic> dataToUpdate = {
      'tratamientoHipertension': _tratamientoHipertension,
      'fumador': _fumador,
      'diabetico': _diabetico,
      'presionSistolica': int.tryParse(_presionController.text),
      'hdl': int.tryParse(_hdlController.text),
      'colesterol': int.tryParse(_colesterolController.text),
    };

    // Filtra los valores nulos si los campos de texto están vacíos
    dataToUpdate.removeWhere((key, value) => value == null && (key == 'presionSistolica' || key == 'hdl' || key == 'colesterol'));

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
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildSubPageAppBar(
        context: context,
        title: 'Cardiovasculares',
        onSave: _saveCardioData,
      ),
      body: _isScreenLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.02),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.04),
              TitledSwitch(
                label: 'Tratamiento de hipertensión',
                value: _tratamientoHipertension,
                onChanged: (val) => setState(() => _tratamientoHipertension = val),
              ),
              SizedBox(height: screenHeight * 0.04),
              Row(
                children: [
                  Expanded(
                    child: TitledSwitch(
                      label: 'Fumador',
                      value: _fumador,
                      onChanged: (val) => setState(() => _fumador = val),
                    ),
                  ),
                  SizedBox(width: screenHeight * 0.02),
                  Expanded(
                    child: TitledSwitch(
                      label: 'Diabético',
                      value: _diabetico,
                      onChanged: (val) => setState(() => _diabetico = val),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),

              CustomTextField(
                labelText: 'Presión sanguínea sistólica (mmHg)',
                controller: _presionController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomTextField(
                labelText: 'HDL (lipoproteína de alta densidad)',
                controller: _hdlController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomTextField(
                labelText: 'Colesterol',
                controller: _colesterolController,
                keyboardType: TextInputType.number,
              ),

              // Muestra un indicador si se está guardando
              if (_isSaving)
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}