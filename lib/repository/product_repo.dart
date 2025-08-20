import 'package:flutter/foundation.dart';
import 'package:market/data/models/product/product_model.dart';
import 'package:market/data/models/universal_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepo {
  Future<UniversalData> getProductsByCategory(
    String category, {
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select()
          .eq('category', category)
          .range((page - 1) * limit, (page * limit) - 1);

      print(response.map((json) => ProductModel.fromJson(json)).toList());

      return UniversalData(
        data: response.map((json) => ProductModel.fromJson(json)).toList(),
      );
    } catch (error) {
      return UniversalData(error: error.toString());
    }
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

  Future<UniversalData> getRandomProductsPaginated({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final offset = (page - 1) * limit;

      final response = await Supabase.instance.client.rpc(
        'get_random_products_paginated',
        params: {'limit_param': limit, 'offset_param': offset},
      );
      return UniversalData(
        data:
            (response as List)
                .map((json) => ProductModel.fromJson(json))
                .toList(),
      );
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
