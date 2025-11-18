import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductByBarcodeUseCase {
  final ProductRepository repository;

  GetProductByBarcodeUseCase({required this.repository});

  Future<ProductEntity> call(String barcode) {
    return repository.getProductByBarcode(barcode);
  }
}