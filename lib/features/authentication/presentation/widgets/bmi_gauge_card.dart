import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/text_styles.dart';

class BmiGaugeCard extends StatelessWidget {
  final double bmi;

  const BmiGaugeCard({
    super.key,
    required this.bmi,
  });

  @override
  Widget build(BuildContext context) {
    // La lógica para determinar el estado
    final String status;
    final String message;
    final Color statusColor;

    if (bmi < 18.5) {
      status = 'Bajo peso';
      message = 'Es importante consultar a un profesional.';
      statusColor = Colors.blue;
    } else if (bmi < 25) {
      status = 'Peso saludable';
      message = '¡Felicidades, continúa con un peso saludable!';
      statusColor = Colors.green;
    } else if (bmi < 30) {
      status = 'Sobrepeso';
      message = 'Considera ajustar tus hábitos alimenticios.';
      statusColor = Colors.orange;
    } else {
      status = 'Obesidad';
      message = 'Es crucial consultar a un profesional de la salud.';
      statusColor = Colors.red;
    }

    // La lógica para normalizar el valor del IMC
    final double normalizedBmi = (bmi.clamp(15, 40) - 15) / (40 - 15);
    final double alignmentX = normalizedBmi * 2 - 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.backgroundContainer),
      ),
      child: Column(
        children: [
          const Text('Tu IMC es', style: TextStyles.parrafo),
          Text(
            bmi.toStringAsFixed(2),
            style: TextStyle(
                color: AppColors.body,
                fontSize: 38,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Tu estado de nutrición es', style: TextStyles.etiqueta),
          const SizedBox(height: 8),
          Text(
            status,
            style: TextStyle(
                color: statusColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Medidor de IMC
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
                    stops: [0.1, 0.4, 0.7, 1.0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(alignmentX, 0),
                child: const Icon(Icons.arrow_drop_down, size: 40, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bajo peso', style: TextStyle(color: AppColors.grey400, fontSize: 10)),
                Text('Normal', style: TextStyle(color: AppColors.grey400, fontSize: 10)),
                Text('Sobrepeso', style: TextStyle(color: AppColors.grey400, fontSize: 10)),
                Text('Obesidad', style: TextStyle(color: AppColors.grey400, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(message,
              style: const TextStyle(color: AppColors.body),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}