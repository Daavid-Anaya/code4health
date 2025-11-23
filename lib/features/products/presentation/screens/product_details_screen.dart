import 'package:code4health/core/constants/app_colors.dart';
import 'package:code4health/features/products/presentation/widgets/build_product_header.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/entities/product_entity.dart';
import '../widgets/build_info_card.dart';
import '../widgets/build_ingredients.dart';
import '../widgets/build_nutrition_table.dart';
import '../widgets/build_preferences_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(product.productName ?? 'Detalles', style: TextStyles.title(context)),
        backgroundColor: AppColors.bar,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera del producto (imagen, nombre, marca, cantidad)
              BuildProductHeader(screenWidth: screenWidth, product: product),
              SizedBox(height: screenHeight * 0.02),

              // Sección de relación con preferencias
              BuildPreferencesSection(screenWidth: screenWidth, screenHeight: screenHeight, product: product),
              SizedBox(height: screenHeight * 0.02),

              // Información Nutricional
              BuildInfoCard(
                context,
                title: 'Información nutricional',
                content: BuildNutritionTable(product: product),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Ingredientes
              BuildInfoCard(
                context,
                title: 'Ingredientes',
                content: BuildIngredients(product: product),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.all(screenHeight * 0.02),
              //   decoration: BoxDecoration(
              //     color: AppColors.background,
              //     borderRadius: BorderRadius.circular(16),
              //     border: Border.all(color: AppColors.background),
              //   ),
              //   child: Column(
              //     // Productos similares
              //     //_buildSimilarProducts(screenWidth, screenHeight),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimilarProducts(double screenWidth, double screenHeight) {

    final double itemSize = screenWidth * 0.25;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Text(
          //'Productos similares',
          //style: TextStyles.subEncabezado(context),
        //),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          height: itemSize,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: itemSize,
                margin: EdgeInsets.only(right: screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: AppColors.backgroundComponentSelect,
                  borderRadius: BorderRadius.circular(16),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}