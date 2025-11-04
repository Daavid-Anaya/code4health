import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool readOnly;


  const CustomTextField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      readOnly: readOnly,
      style: TextStyles.parrafo,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyles.etiqueta,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.backgroundComponentSelect),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.backgroundComponent),
        ),
      ),
    );
  }
}