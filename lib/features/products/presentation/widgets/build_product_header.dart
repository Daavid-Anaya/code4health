import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/entities/product_entity.dart';

class BuildProductHeader extends StatelessWidget {
  final double screenWidth;
  final ProductEntity product;

  const BuildProductHeader({
    super.key,
    required this.screenWidth,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundComponent,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.28,
            height: screenWidth * 0.28,
            decoration: BoxDecoration(
              color: AppColors.backgroundComponentSelect,
              borderRadius: BorderRadius.circular(16),
              image: product.imageUrl != null
                  ? DecorationImage(image: NetworkImage(product.imageUrl!), fit: BoxFit.cover,)
                  : null,
            ),
            // Muestra un ícono si no hay imagen
            child: product.imageUrl == null
                ? const Icon(Icons.fastfood, color: Colors.grey, size: 60)
                : null,
          ),
          SizedBox(width: screenWidth * 0.04),
          // Columna para el texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.productName ?? 'Nombre no disponible', style: TextStyles.encabezado(context)),
                SizedBox(height: 8),
                Text(product.brand ?? 'Marca no disponible', style: TextStyles.parrafo(context)),
                SizedBox(height: 4),
                Text(product.quantity ?? 'Cantidad no disponible', style: TextStyles.etiqueta(context)),

              ],
            ),
          ),
        ],
      ),
    );
  }
}