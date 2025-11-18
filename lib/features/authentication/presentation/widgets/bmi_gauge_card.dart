import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

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
    } else if (bmi < 25.0) {
      status = 'Peso saludable';
      message = '¡Felicidades, continúa con un peso saludable!';
      statusColor = Colors.green;
    } else if (bmi < 30.0) {
      status = 'Sobrepeso';
      message = 'Considera ajustar tus hábitos alimenticios.';
      statusColor = Colors.orange;
    } else {
      status = 'Obesidad';
      message = 'Es crucial consultar a un profesional de la salud.';
      statusColor = Colors.red;
    }

    // La lógica para normalizar el valor del IMC
    final double normalizedBmi = (bmi.clamp(5, 50) - 5) / (50 - 5);
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
          Text('Tu IMC es', style: TextStyles.parrafo(context)),
          Text(
            bmi.toStringAsFixed(2),
            style: TextStyle(
                color: AppColors.body,
                fontSize: 38,
                fontWeight: FontWeight.bold
              ),
          ),
          SizedBox(height: 8),
          Text('Tu estado de nutrición es', style: TextStyles.etiqueta(context)),
          SizedBox(height: 8),
          Text(
            status,
            style: TextStyle(
                color: statusColor, fontSize: 18, fontWeight: FontWeight.bold
              ),
          ),
          SizedBox(height: 8),

          // Medidor de IMC
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
                    stops: [0.1, 0.35, 0.65, 0.9],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(alignmentX, 0),
                child: const Icon(Icons.arrow_drop_down, size: 40, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 4),
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
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: AppColors.body),
            textAlign: TextAlign.center
          ),
        ],
      ),
    );
  }
}