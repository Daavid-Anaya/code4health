import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

class NovaGroupDisplay extends StatelessWidget {
  final String group; // '1', '2', '3', '4'

  const NovaGroupDisplay({super.key, required this.group});

  Color _getNovaGroupColor(String group) {
    switch (group) {
      case '1':
        return Colors.green[700]!;
      case '2':
        return Colors.lightGreen[600]!;
      case '3':
        return Colors.orange[700]!;
      case '4':
        return Colors.red[700]!;
      default:
        return Colors.grey;
    }
  }

  String _getNovaGroupDescription(String group) {
    switch (group) {
      case '1':
        return 'Alimentos no procesados o mínimamente procesados';
      case '2':
        return 'Ingredientes culinarios procesados';
      case '3':
        return 'Alimentos procesados';
      case '4':
        return 'Alimentos ultraprocesados';
      default:
        return 'Información no disponible';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getNovaGroupColor(group);
    final description = _getNovaGroupDescription(group);

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
                group,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NOVA', style: TextStyles.etiqueta(context)),
                Text(description,
                    style: TextStyles.parrafo(context).copyWith(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}