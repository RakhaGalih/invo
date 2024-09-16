const String tableProduct = 'product_list';

class ProductFields {
  static final List<String> values = [
    id,
    nameProduct,
    category,
    quantity,
    codeProduct,
    price,
    location,
    desc,
    image,
  ];

  static const String id = '_id';
  static const String nameProduct = 'nameProduct';
  static const String category = 'category';
  static const String quantity = 'quantity';
  static const String codeProduct = 'codeProduct';
  static const String price = 'price';
  static const String location = 'location';
  static const String desc = 'desc';
  static const String image = 'image';
}

class ProductList {
  final int? id;
  final String nameProduct;
  final String category;
  final int quantity;
  final String codeProduct;
  final String price;
  final String location;
  final String desc;
  final String image;

  ProductList({
    this.id,
    required this.nameProduct,
    required this.category,
    required this.quantity,
    required this.codeProduct,
    required this.price,
    required this.location,
    required this.desc,
    required this.image,
  });

  Map<String, Object?> toJson() => {
        ProductFields.id: id,
        ProductFields.nameProduct: nameProduct,
        ProductFields.category: category,
        ProductFields.quantity: quantity,
        ProductFields.codeProduct: codeProduct,
        ProductFields.price: price,
        ProductFields.location: location,
        ProductFields.desc: desc,
        ProductFields.image: image,
      };

  static ProductList fromJson(Map<String, Object?> json) => ProductList(
        id: json[ProductFields.id] as int?,
        nameProduct: json[ProductFields.nameProduct] as String,
        category: json[ProductFields.category] as String,
        quantity: json[ProductFields.quantity] as int,
        codeProduct: json[ProductFields.codeProduct] as String,
        price: json[ProductFields.price] as String,
        location: json[ProductFields.location] as String,
        desc: json[ProductFields.desc] as String,
        image: json[ProductFields.image] as String,
      );

  ProductList copy({
    int? id,
    String? nameProduct,
    String? category,
    int? quantity,
    String? codeProduct,
    String? price,
    String? location,
    String? desc,
    String? image,
  }) =>
      ProductList(
        id: id ?? this.id,
        nameProduct: nameProduct ?? this.nameProduct,
        category: category ?? this.category,
        quantity: quantity ?? this.quantity,
        codeProduct: codeProduct ?? this.codeProduct,
        price: price ?? this.price,
        location: location ?? this.location,
        desc: desc ?? this.desc,
        image: image ?? this.image,
      );
}
