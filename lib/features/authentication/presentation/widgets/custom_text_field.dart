import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
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