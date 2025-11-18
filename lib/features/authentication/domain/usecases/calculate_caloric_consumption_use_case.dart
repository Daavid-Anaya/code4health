class CalculateCaloricConsumptionUseCase {

  CalculateCaloricConsumptionUseCase();

  double call({
    required double peso,
    required double altura,
    required int edad,
    required String sexo,
    required String nivelActividad,
  }) {

    // Calcular la Tasa Metabólica Basal (TMB)
    double tmb;
    if (sexo.toLowerCase() == 'masculino') {
      tmb = (10 * peso) + (6.25 * altura) - (5 * edad) + 5;
    } else {
      tmb = (10 * peso) + (6.25 * altura) - (5 * edad) - 161;
    }

    // Obtener el factor de actividad
    double factorActividad;
    switch (nivelActividad.toLowerCase()) {
      case 'sedentario':
        factorActividad = 1.2;
        break;
      case 'ligero':
        factorActividad = 1.375;
        break;
      case 'moderado':
        factorActividad = 1.55;
        break;
      case 'activo':
        factorActividad = 1.725;
        break;
      case 'muy activo':
        factorActividad = 1.9;
        break;
      default:
        factorActividad = 1.2; // Valor por defecto
    }

    // Calcula el consumo calórico diario total (TDEE)
    final double tdee = tmb * factorActividad;

    return tdee;
  }
}