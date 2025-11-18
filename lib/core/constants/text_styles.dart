import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'dart:math';

class TextStyles {
  static double _getResponsiveFontSize(BuildContext context, double baseSize) {

    // Obtiene el tamaño actual de la pantalla
    final size = MediaQuery.of(context).size;

    // Calcula la diagonal
    final currentDiagonal = sqrt(pow(size.width, 2) + pow(size.height, 2));

    const double baseDiagonal = 900.0;

    // Calcula el factor de escalado
    final scalingFactor = currentDiagonal / baseDiagonal;

    // Aplica el escalado al tamaño base
    // Usamos .clamp() para evitar tamaños de fuente  grandes o pequeños
    // Aquí, no será más pequeño que el 80% ni más grande que el 180%.
    final responsiveSize = baseSize * scalingFactor.clamp(0.8, 1.8);

    return responsiveSize;
  }

  static TextStyle title(BuildContext context) {
    return TextStyle(
      color: AppColors.body,
      fontWeight: FontWeight.bold,
      fontSize: _getResponsiveFontSize(context, 26.0),
    );
  }

  static TextStyle encabezado(BuildContext context) {
    return TextStyle(
      color: AppColors.body,
      fontWeight: FontWeight.bold,
      fontSize: _getResponsiveFontSize(context, 24.0),
    );
  }

  static TextStyle subEncabezado(BuildContext context) {
    return TextStyle(
      color: AppColors.body,
      fontWeight: FontWeight.bold,
      fontSize: _getResponsiveFontSize(context, 20.0),
    );
  }

  static TextStyle parrafo(BuildContext context) {
    return TextStyle(
      color: AppColors.body,
      fontSize: _getResponsiveFontSize(context, 15.0),
    );
  }

  static TextStyle etiqueta(BuildContext context) {
    return TextStyle(
      color: AppColors.body,
      fontSize: _getResponsiveFontSize(context, 14.0),
    );
  }

  static TextStyle leyenda(BuildContext context) {
    return TextStyle(
      color: AppColors.body,
      fontSize: _getResponsiveFontSize(context, 12.0),
    );
  }

  static TextStyle linkLeyenda(BuildContext context) {
    return TextStyle(
      color: Colors.blue,
      fontSize: _getResponsiveFontSize(context, 12.0),
      fontWeight: FontWeight.bold,
    );
  }
}