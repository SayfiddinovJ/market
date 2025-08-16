import 'package:market/data/models/product/product_model.dart';
import 'package:market/data/models/status.dart';

class ProductState {
  final ProductModel productModel;
  final List<ProductModel> products;
  final Status status;
  final String message;

  ProductState({
    required this.productModel,
    required this.products,
    required this.status,
    required this.message,
  });

  ProductState copyWith({
    ProductModel? productModel,
    List<ProductModel>? products,
    Status? status,
    String? message,
  }) {
    return ProductState(
      productModel: productModel ?? this.productModel,
      products: products ?? this.products,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
