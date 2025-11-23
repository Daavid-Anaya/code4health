import '../../../products/domain/entities/product_entity.dart';
import '../repositories/history_repository.dart';

class AddToHistoryUseCase {
  final HistoryRepository repository;
  AddToHistoryUseCase({required this.repository});

  Future<void> call(ProductEntity product) {
    return repository.addToHistory(product);
  }
}