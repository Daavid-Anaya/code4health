import 'package:flutter/material.dart';
import 'package:code4health/features/authentication/presentation/widgets/warning_seal.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/entities/product_entity.dart';
import 'nova_group_display.dart';
import 'nutriscore_display.dart';

class BuildPreferencesSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final ProductEntity product;

  const BuildPreferencesSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final highLevels =
    product.nutrientLevels.entries.where((e) => e.value == 'high').toList();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Calificación nutricional', style: TextStyles.subEncabezado(context)),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          // Nutri-Score
          if (product.nutriscore != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: NutriScoreDisplay(grade: product.nutriscore!),
            ),

          // Grupo NOVA
          if (product.novaGroup != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: NovaGroupDisplay(group: product.novaGroup!),
            ),

          // Sellos de Advertencia (ALTO EN GRASAS, ALTO EN SODIO, etc.)
          if (highLevels.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: highLevels.map((level) {
                String label = '';
                switch (level.key) {
                  case 'fat':
                    label = 'ALTO EN GRASAS';
                    break;
                  case 'saturated-fat':
                    label = 'ALTO EN GRASAS SATURADAS';
                    break;
                  case 'sugars':
                    label = 'ALTO EN AZÚCARES';
                    break;
                  case 'salt':
                    label = 'ALTO EN SODIO';
                    break;
                }
                return WarningSeal(label: label);
              }).toList(),
            ),
        ],
      ),
    );
  }

}