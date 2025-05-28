import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/models/product/product_model.dart';
import 'package:market/repository/product_repo.dart';
import 'package:market/ui/shimmer/shimmer_grid_tile.dart';
import 'package:market/ui/tabs/category/subs/category_search.dart';
import 'package:market/ui/widgets/product_grid.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key, required this.category});

  final String category;

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<ProductModel> _products = [];
  bool _isLoading = false;
  int _page = 0;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchProducts() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      List<ProductModel> newProducts = await context
          .read<ProductRepo>()
          .getProductsByCategory(widget.category, _limit, _page * _limit);

      setState(() {
        _products.addAll(newProducts);
        _page++;
      });
    } catch (e) {
      debugPrint("Xatolik: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _fetchProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(widget.category),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.sp,
          overflow: TextOverflow.ellipsis
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CategorySearchDelegate(widget.category),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child:
            _products.isEmpty && _isLoading
                ? GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => const ShimmerGridTile(),
                )
                : _products.isEmpty
                ? const Center(child: Text("Bu kategoriyada mahsulot yo'q!"))
                : GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _products.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _products.length) {
                      return ProductGridTile(product: _products[index]);
                    } else {
                      return ShimmerGridTile();
                    }
                  },
                ),
      ),
    );
  }
}
