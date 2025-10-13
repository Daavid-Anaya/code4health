import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundComponent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.backgroundComponent),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyles.etiqueta),
          const SizedBox(height: 4),
          Text(value, style: TextStyles.subEncabezado),
        ],
      ),
    );
  }
}