import 'package:code4health/core/constants/text_styles.dart';
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
        style: TextStyles.parrafo(context).copyWith(color: Colors.white),
      ),
    ),
    leadingWidth: 100, // Ajusta el espacio para "Cancelar"
    // Título
    title: Text(
      title,
      style: TextStyles.subEncabezado(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    // Botón de Guardar
    actions: [
      TextButton(
        onPressed: onSave,
        child: Text(
          'Guardar',
          style: TextStyles.parrafo(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}