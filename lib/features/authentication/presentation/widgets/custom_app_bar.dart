import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';


AppBar buildSubPageAppBar({
  required BuildContext context,
  required String title,
  required VoidCallback onSave,
}) {
  return AppBar(
    backgroundColor: AppColors.bar,
    elevation: 0,
    // Botón de Cancelar
    leading: TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        'Cancelar',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    leadingWidth: 100, // Ajusta el espacio para "Cancelar"
    // Título
    title: Text(
      title,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    // Botón de Guardar
    actions: [
      TextButton(
        onPressed: onSave,
        child: Text(
          'Guardar',
          style: TextStyle(
            color: AppColors.primary, // Usando el color de tu app
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}