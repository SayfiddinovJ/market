class ProductModel {
  final String productId;
  final String name;
  final String type;
  final String price;
  final String image;
  final String status;
  final String category;
  final String description;
  final String createdAt;

  ProductModel({
    required this.productId,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    required this.status,
    required this.category,
    required this.description,
    required this.createdAt,
  });

  ProductModel copyWith({
    String? productId,
    String? name,
    String? type,
    String? price,
    String? image,
    String? status,
    String? category,
    String? description,
    String? createdAt,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      image: image ?? this.image,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      price: json['price'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'type': type,
      'price': price,
      'image': image,
      'status': status,
      'category': category,
      'description': description,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return '''
    productId: $productId,
    name: $name,
    type: $type,
    price: $price,
    image: $image,
    status: $status,
    category: $category,
    description: $description
    createdAt: $createdAt
    ''';
  }
}
