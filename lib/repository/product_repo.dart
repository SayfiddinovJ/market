import 'package:flutter/foundation.dart';
import 'package:market/models/product/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepo {
  Future<List<ProductModel>> getProductsByCategory(
    String category,
    int limit,
    int offset,
  ) async {
    final response = await Supabase.instance.client
        .from('products')
        .select()
        .eq('category', category)
        .range(offset, offset + limit - 1);

    return response.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> searchProductsByCategory(
    String query,
    String category,
  ) async {
    final response = await Supabase.instance.client
        .from('products')
        .select()
        .ilike('name', '%$query%')
        .eq('category', category);

    return response.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> getAllProducts({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await Supabase.instance.client
        .from('products')
        .select()
        .range((page - 1) * limit, (page * limit) - 1);

    return response.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> searchProduct(String query) async {
    if (query.isEmpty) {
      return [];
    }

    try {
      final response = await Supabase.instance.client
          .from('products')
          .select()
          .or('name.ilike.%$query%, category.ilike.%$query%')
          .limit(20);

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (error) {
      debugPrint('Supabase Exception: $error');
      return [];
    }
  }

  Future<List<ProductModel>> getRandomProductsPaginated({
    int page = 1,
    int limit = 10,
  }) async {
    final offset = (page - 1) * limit;

    final response = await Supabase.instance.client.rpc(
      'get_random_products_paginated',
      params: {'limit_param': limit, 'offset_param': offset},
    );

    return (response as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }
}
