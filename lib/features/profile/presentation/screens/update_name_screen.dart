import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../../authentication/domain/usecases/update_display_name_use_case.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_app_bar.dart';

class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({super.key});

  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  // Define controladores y estado de carga
  final _nameController = TextEditingController();
  bool _isLoading = false;

  // Inyecta el Caso de Uso desde el Service Locator (get_it)
  final UpdateDisplayNameUseCase _updateNameUseCase = sl<UpdateDisplayNameUseCase>();

  // Carga los datos actuales del usuario
  @override
  void initState() {
    super.initState();
    _nameController.text = FirebaseAuth.instance.currentUser?.displayName ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Función para guardar los cambios de nombre
  Future<void> _saveName() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El nombre no puede estar vacío.'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() { _isLoading = true; });

    try {
      // Llama al caso de uso
      await _updateNameUseCase.call(_nameController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nombre actualizado con éxito.'), backgroundColor: Colors.green),
        );
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}'), backgroundColor: Colors.red),
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildSubPageAppBar(
        context: context,
        title: 'Nombre',
        onSave: _saveName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomTextField(
          labelText: 'Nombre',
          controller: _nameController,
        ),
      ),
    );
  }
}