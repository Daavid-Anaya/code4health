import 'package:code4health/features/authentication/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/text_styles.dart';

// Un pequeño modelo de datos para representar un item del historial
class HistoryItem {
  final String name;
  final IconData icon;

  const HistoryItem({required this.name, required this.icon});
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Lista de datos de ejemplo para el historial
  final List<HistoryItem> historyList = const [
    HistoryItem(name: 'Producto 1', icon: Icons.cake_outlined),
    HistoryItem(name: 'Producto 2', icon: Icons.bakery_dining_outlined),
    HistoryItem(name: 'Producto 3', icon: Icons.fastfood_outlined),
    HistoryItem(name: 'Producto 4', icon: Icons.local_pizza_outlined),
    HistoryItem(name: 'Producto 5', icon: Icons.lunch_dining_outlined),
    HistoryItem(name: 'Producto 6', icon: Icons.cookie_outlined),
  ];

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth * 0.04;
    final double spacing = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Historial', style: TextStyles.title),
        backgroundColor: AppColors.bar,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [

          // Cuadrícula de items
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(padding),
              // Configuración de la cuadrícula
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 1.0,
              ),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ProductDetailsScreen()),
                    );
                  },
                  // Construimos cada tarjeta del historial
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundComponentSelect,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: screenWidth * 0.15, color: Colors.black54),
                        const SizedBox(height: 8),
                        Text(
                          item.name,
                          style: const TextStyle(
                            color: AppColors.body,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
