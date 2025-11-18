class ProductEntity {
  final String barcode;
  final String? productName;
  final String? brand;
  final String? imageUrl;
  final String? nutriscore;
  final String? novaGroup;

  // Información Nutricional (por 100g)
  final double? calories;
  final double? sugars;
  final double? fat;
  final double? saturatedFat;
  final double? salt;
  final double? proteins;

  // Ingredientes y Alérgenos
  final String? ingredientsText;
  final List<String> allergens;

  // Sellos de Advertencia (de OFF)
  final Map<String, String> nutrientLevels;

  // Otros Datos
  final String? quantity;
  final List<String> categories;

  ProductEntity({
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
}