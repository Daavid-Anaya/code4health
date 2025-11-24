import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/screens/product_details_screen.dart';

class BuildHistoryCard extends StatelessWidget {
  final BuildContext context;
  final ProductEntity product;
  final double screenWidth;

  const BuildHistoryCard({
    super.key,
    required this.context,
    required this.product,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a detalles con el producto real
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundComponentSelect,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen del producto o Icono por defecto
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: product.imageUrl != null
                    ? Image.network(
                  product.imageUrl!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: screenWidth * 0.15, color: Colors.white54),
                )
                    : Icon(Icons.fastfood, size: screenWidth * 0.15, color: Colors.white54),
              ),
            ),

            // Nombre y Marca
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
              child: Column(
                children: [
                  Text(
                    product.productName ?? 'Sin nombre',
                    style: const TextStyle(
                      color: Colors.white, // Ajustado a blanco para contraste
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (product.brand != null)
                    Text(
                      product.brand!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}