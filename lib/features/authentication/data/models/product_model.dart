import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String barcode;
  final String? productName;
  final String? brand;
  final String? imageUrl;
  final String? nutriscore;
  final String? novaGroup;
  final double? calories;
  final double? sugars;
  final double? fat;
  final double? saturatedFat;
  final double? salt;
  final double? proteins;
  final String? ingredientsText;
  final List<String> allergens;
  final Map<String, String> nutrientLevels;
  final String? quantity;
  final List<String> categories;

  ProductModel({
    required this.barcode,
    this.productName,
    this.brand,
    this.imageUrl,
    this.nutriscore,
    this.novaGroup,
    this.calories,
    this.sugars,
    this.fat,
    this.saturatedFat,
    this.salt,
    this.proteins,
    this.ingredientsText,
    this.allergens = const [],
    this.nutrientLevels = const {},
    this.quantity,
    this.categories = const [],
  });

  // FUNCIONES DE AYUDA PARA PARSEO SEGURO
  static double? _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static List<String> _parseList(dynamic value) {
    if (value is List) return value.cast<String>();
    return [];
  }

  static Map<String, String> _parseMap(dynamic value) {
    if (value is Map) return value.map((k, v) => MapEntry(k.toString(), v.toString()));
    return {};
  }

  //Parseo
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final productData = json['product'] ?? {};
    final nutriments = productData['nutriments'] ?? {};

    return ProductModel(
        barcode: json['code'] ?? '',
      productName: productData['product_name'] ?? 'Nombre no disponible',
      brand: productData['brands'] ?? 'Marca no disponible',
      imageUrl: productData['image_front_url'],
      nutriscore: productData['nutriscore_grade'], // 'a', 'b', 'c', etc.
      novaGroup: productData['nova_group']?.toString(), // 1, 2, 3, 4

      // Info Nutricional
      calories: _parseDouble(nutriments['energy-kcal_100g']),
      sugars: _parseDouble(nutriments['sugars_100g']),
      fat: _parseDouble(nutriments['fat_100g']),
      saturatedFat: _parseDouble(nutriments['saturated-fat_100g']),
      salt: _parseDouble(nutriments['salt_100g']),
      proteins: _parseDouble(nutriments['proteins_100g']),

      // Ingredientes y Alérgenos
      ingredientsText: productData['ingredients_text_es'] ?? productData['ingredients_text'],
      allergens: _parseList(productData['allergens_tags']),

      // Sellos de Advertencia
      nutrientLevels: _parseMap(productData['nutrient_levels']),

      // Otros
      quantity: productData['quantity'],
      categories: _parseList(productData['categories_tags']),
    );
  }

  // Metodo para convertir el Modelo de Datos a la Entidad de Dominio
  ProductEntity toEntity() {
    return ProductEntity(
      barcode: barcode,
      imageUrl: imageUrl,
      productName: productName,
      categories: categories,
      brand: brand,
      quantity: quantity,
      nutriscore: nutriscore,
      novaGroup: novaGroup,
      calories: calories,
      sugars: sugars,
      fat: fat,
      saturatedFat: saturatedFat,
      salt: salt,
      proteins: proteins,
      ingredientsText: ingredientsText,
      allergens: allergens,
      nutrientLevels: nutrientLevels,
    );
  }
}