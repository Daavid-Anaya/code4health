import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/entities/product_entity.dart';

class BuildIngredients extends StatelessWidget {
  final ProductEntity product;

  const BuildIngredients({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.ingredientsText ?? 'Información no disponible.',
          style: TextStyles.parrafo(context).copyWith(color: Colors.grey[400]),
        ),
        if (product.allergens.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Alérgenos: ${product.allergens.map((e) => e.split(':').last.replaceAll('-', ' ')).join(', ')}',
              style: TextStyles.parrafo(context).copyWith(fontWeight: FontWeight.bold, color: Colors.orange)),
        ]
      ],
    );
  }

}