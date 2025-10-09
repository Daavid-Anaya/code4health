import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  static const TextStyle title = TextStyle(
    color: AppColors.body,
    fontWeight: FontWeight.bold,
    fontSize: 26.0,
  );

  static const TextStyle encabezado = TextStyle(
    color: AppColors.body,
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  );

  static const TextStyle subEncabezado = TextStyle(
    color: AppColors.body,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  static const TextStyle parrafo = TextStyle(
    color: AppColors.body,
    fontSize: 16.0,
  );

  static const TextStyle etiqueta = TextStyle(
    color: AppColors.grey400,
    fontSize: 14.0,
  );

  static const TextStyle leyenda = TextStyle(
    color: AppColors.body,
    fontSize: 12.0,
  );

  static const TextStyle linkLeyenda = TextStyle(
    color: Colors.blue,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}