import '../../../products/domain/entities/product_entity.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  // Esta lista vive en memoria mientras la app está abierta (Singleton)
  final List<ProductEntity> _history = [];

  @override
  List<ProductEntity> getHistory() {
    // Retornamos la lista invertida para ver los más recientes primero
    return List.from(_history.reversed);
  }

  @override
  Future<void> addToHistory(ProductEntity product) async {
    // Evitamos duplicados: si ya existe, lo borramos para agregarlo al final (como reciente)
    _history.removeWhere((p) => p.barcode == product.barcode);
    _history.add(product);
  }
}