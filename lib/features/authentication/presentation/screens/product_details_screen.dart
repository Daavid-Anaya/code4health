import 'package:code4health/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detalles del Producto', style: TextStyles.title),
        backgroundColor: AppColors.bar,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera del producto (imagen y nombre)
              _buildProductHeader(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              const Divider(color: AppColors.backgroundLineasMarcos),
              SizedBox(height: screenHeight * 0.02),

              // Información
              _buildDietaryInfo(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.02),
              const Divider(color: AppColors.backgroundLineasMarcos),
              SizedBox(height: screenHeight * 0.02),

              // Productos similares
              _buildSimilarProducts(screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader(double screenWidth) {

    final double imageSize = screenWidth * 0.28;

    return Row(
      children: [
        // Placeholder para la imagen
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            color: AppColors.backgroundComponentSelect,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        // Columna para el texto
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Yogurt', style: TextStyles.encabezado),
              SizedBox(height: 8),
              Text('Descripción del producto...', style: TextStyles.parrafo),
              SizedBox(height: 4),
              Text('Más detalles aquí...', style: TextStyles.parrafo),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDietaryInfo(double screenWidth, double screenHeight) {
    return Column(
      children: [

        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.015),
          decoration: BoxDecoration(
            color: AppColors.backgroundComponent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: screenWidth * 0.005),
              const Text('Se ajusta a sus necesidades dietéticas', style: TextStyles.parrafo),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        const Divider(color: AppColors.backgroundLineasMarcos),
        SizedBox(height: screenHeight * 0.02),
        // El resto de los items
        _buildChecklistItem('Bajo en azúcares', true),
        SizedBox(height: screenHeight * 0.015),
        _buildChecklistItem('Contiene fibra', true),
        SizedBox(height: screenHeight * 0.015),
        _buildChecklistItem('Alto en sodio', false),
      ],
    );
  }

  // Widget de ayuda para cada item de la lista de pros/contras
  Widget _buildChecklistItem(String text, bool isPositive) {
    return Row(
      children: [
        Icon(
          isPositive ? Icons.check_circle_outline : Icons.cancel_outlined,
          color: isPositive ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: TextStyles.parrafo),
        ),
      ],
    );
  }

  Widget _buildSimilarProducts(double screenWidth, double screenHeight) {

    final double itemSize = screenWidth * 0.25;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Productos similares',
          style: TextStyles.subEncabezado,
        ),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          height: itemSize, // Altura fija para la lista horizontal
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3, // Número de productos similares de ejemplo
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
