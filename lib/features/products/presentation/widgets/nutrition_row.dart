import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';

class NutritionRow extends StatelessWidget {
  final String label;
  final double? value;
  final String unit;

  const NutritionRow({
    super.key,
    required this.label,
    this.value,
    required this.unit
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyles.parrafo(context)),
          Text(
            value != null ? '${value!.toStringAsFixed(1)} $unit' : 'N/A',
            style: TextStyles.parrafo(context),
          ),
        ],
      ),
    );
  }
}