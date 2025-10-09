import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? value; // El valor actualmente seleccionado
  final List<String> items; // La lista de opciones
  final ValueChanged<String?> onChanged; // La función que se ejecuta al cambiar

  const CustomDropdownFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      hint: Text(hintText, style: TextStyle(color: AppColors.grey400)),
      style: const TextStyle(color: AppColors.body),
      dropdownColor: AppColors.grey800,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.grey400),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey700),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.backgroundComponent),
        ),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}