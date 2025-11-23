import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../injection_container.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import '../../domain/usecases/get_history_use_case.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Inyectamos el caso de uso
  final GetHistoryUseCase _getHistoryUseCase = sl<GetHistoryUseCase>();

  // Lista que contendrá los productos reales
  List<ProductEntity> historyList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  // Método para recargar el historial cada vez que la pantalla se construye
  // Esto es útil si usas BottomNavigationBar y la pantalla no se destruye
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadHistory();
  }

  void _loadHistory() {
    setState(() {
      historyList = _getHistoryUseCase.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth * 0.04;
    final double spacing = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Historial', style: TextStyles.title(context)),
        backgroundColor: AppColors.bar,
        elevation: 0,
        actions: [
          // Botón opcional para recargar manualmente
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadHistory,
          )
        ],
      ),
      body: historyList.isEmpty
          ? _buildEmptyState()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(padding),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 0.85,
              ),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final product = historyList[index];
                return _buildHistoryCard(context, product, screenWidth);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, ProductEntity product, double screenWidth) {
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.history, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Aún no has escaneado productos',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}