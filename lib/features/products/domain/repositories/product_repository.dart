import '../../../products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  // Metodo para obtener el producto por su código de barras
  Future<ProductEntity> getProductByBarcode(String barcode);
}