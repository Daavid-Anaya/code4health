import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/entities/product_entity.dart';
import 'nutrition_row.dart';

class BuildNutritionTable extends StatelessWidget {
  final ProductEntity product;

  const BuildNutritionTable({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Por 100g', style: TextStyles.etiqueta(context)),
        SizedBox(height: 16),
        NutritionRow(label: 'Calorías', value: product.calories, unit: 'kcal'),
        NutritionRow(label: 'Proteínas', value: product.proteins, unit: 'g'),
        NutritionRow(label: 'Grasa Total', value: product.fat, unit: 'g'),
        NutritionRow(label: 'Grasa Saturada', value: product.saturatedFat, unit: 'g'),
        NutritionRow(label: 'Azúcares', value: product.sugars, unit: 'g'),
        NutritionRow(label: 'Sal', value: product.salt, unit: 'g'),
      ],
    );
  }

}