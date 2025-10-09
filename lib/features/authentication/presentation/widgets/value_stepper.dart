import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import 'info_card.dart';

class ValueStepper extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const ValueStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: AppColors.body)),
          Text('$value', style: TextStyles.encabezado),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 40.0,
                icon: const Icon(Icons.remove_circle, color: AppColors.primary, ),
                onPressed: onDecrement,
              ),
              IconButton(
                iconSize: 40.0,
                icon: const Icon(Icons.add_circle, color: AppColors.primary),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}