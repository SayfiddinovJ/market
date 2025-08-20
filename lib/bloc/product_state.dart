import 'package:market/data/models/product/product_model.dart';
import 'package:market/data/models/status.dart';

class ProductState {
  final ProductModel productModel;
  final List<ProductModel> products;
  final List<ProductModel> categoryProducts;
  final Status status;
  final CategoryStatus categoryStatus;
  final String message;

  ProductState({
    required this.productModel,
    required this.products,
    required this.categoryProducts,
    required this.status,
    required this.categoryStatus,
    required this.message,
  });

  ProductState copyWith({
    ProductModel? productModel,
    List<ProductModel>? products,
    List<ProductModel>? categoryProducts,
    Status? status,
    CategoryStatus? categoryStatus,
    String? message,
  }) {
    return ProductState(
      productModel: productModel ?? this.productModel,
      products: products ?? this.products,
      status: status ?? this.status,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      message: message ?? this.message,
      categoryProducts: categoryProducts ?? this.categoryProducts,
    );
  }
}
