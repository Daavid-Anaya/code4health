import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart'; // Crearemos este modelo en el siguiente paso

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductByBarcode(String barcode);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final String _baseUrl = 'https://world.openfoodfacts.org/api/v2/product';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getProductByBarcode(String barcode) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/$barcode.json'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 1 && data['product'] != null) {
        // El producto se encontró, lo parseamos usando ProductModel
        return ProductModel.fromJson(data);
      } else {
        throw Exception('Producto no encontrado');
      }
    } else {
      throw Exception('Error al conectar con la API');
    }
  }
}