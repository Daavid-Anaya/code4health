import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import 'custom_app_bar.dart';

class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({super.key});

  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() {
    // TODO: Lógica para guardar el nombre (_nameController.text)
    Navigator.pop(context);
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
          controller: _nameController, // Asignar el controlador
        ),
      ),
    );
  }
}