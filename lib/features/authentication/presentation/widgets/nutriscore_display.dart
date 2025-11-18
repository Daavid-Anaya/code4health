import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

class NutriScoreDisplay extends StatelessWidget {
  final String grade; // 'a', 'b', 'c', 'd', 'e'

  const NutriScoreDisplay({super.key, required this.grade});

  Color _getNutriscoreColor(String grade) {
    switch (grade.toLowerCase()) {
      case 'a':
        return Colors.green[700]!;
      case 'b':
        return Colors.lightGreen[600]!;
      case 'c':
        return Colors.yellow[700]!;
      case 'd':
        return Colors.orange[700]!;
      case 'e':
        return Colors.red[700]!;
      default:
        return Colors.grey;
    }
  }

  String _getNutriscoreGrade(String grade) {
    switch (grade.toLowerCase()) {
      case 'a':
        return 'Muy buena calidad nutricional';
      case 'b':
        return 'Calidad nutricional buena';
      case 'c':
        return 'Calidad nutricional media';
      case 'd':
        return 'Baja calidad nutricional';
      case 'e':
        return 'Baja calidad nutricional';
      default:
        return 'Información no dispibles';
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradeUpper = grade.toUpperCase();
    final color = _getNutriscoreColor(grade);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundComponent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                gradeUpper,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nutri-Score', style: TextStyles.etiqueta(context)),
                Text(_getNutriscoreGrade(grade),
                    style: TextStyles.parrafo(context).copyWith(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

