import '../../../products/domain/entities/product_entity.dart';
import '../repositories/history_repository.dart';

class GetHistoryUseCase {
  final HistoryRepository repository;
  GetHistoryUseCase({required this.repository});

  List<ProductEntity> call() {
    return repository.getHistory();
  }
}