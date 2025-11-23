import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductEntity> getProductByBarcode(String barcode) async {
    try {
      final ProductModel productModel = await remoteDataSource.getProductByBarcode(barcode);
      // Convierte el modelo de datos a la entidad de dominio
      return productModel.toEntity();
    } catch (e) {
      // Maneja errores
      rethrow;
    }
  }
}