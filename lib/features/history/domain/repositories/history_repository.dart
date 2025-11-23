import '../../../products/domain/entities/product_entity.dart';

abstract class HistoryRepository {
  List<ProductEntity> getHistory();
  Future<void> addToHistory(ProductEntity product);
}