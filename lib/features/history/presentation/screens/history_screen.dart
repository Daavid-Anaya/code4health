import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../injection_container.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import '../../domain/usecases/get_history_use_case.dart';
import '../widgets/build_empty_state.dart';
import '../widgets/build_history_card.dart';

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
          ? BuildEmptyState()
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
                return BuildHistoryCard(context: context, product: product, screenWidth: screenWidth);
              },
            ),
          ),
        ],
      ),
    );
  }
}