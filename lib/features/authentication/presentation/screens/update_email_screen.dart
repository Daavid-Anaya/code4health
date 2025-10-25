import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import 'custom_app_bar.dart';

class UpdateEmailScreen extends StatefulWidget {
  const UpdateEmailScreen({super.key});

  @override
  State<UpdateEmailScreen> createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _saveEmail() {
    // TODO: Lógica para guardar el email (_emailController.text)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildSubPageAppBar(
        context: context,
        title: 'Email',
        onSave: _saveEmail,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomTextField(
          labelText: 'Email',
          controller: _emailController,
        ),
      ),
    );
  }
}