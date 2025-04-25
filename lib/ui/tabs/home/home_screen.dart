import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/models/product/product_model.dart';
import 'package:market/repository/product_repo.dart';
import 'package:market/ui/shimmer/shimmer_grid_tile.dart';
import 'package:market/ui/tabs/search/search_screen.dart';
import 'package:market/ui/widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<ProductModel> _products = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchProducts() async {
    if (!_hasMore || _isLoading) return;

    setState(() => _isLoading = true);

    final newProducts = await context.read<ProductRepo>().getRandomProductsPaginated(
      page: _page,
      limit: _limit,
    );

    if (newProducts.length < _limit) {
      _hasMore = false;
    }

    if (mounted) {
      setState(() {
        _products.addAll(newProducts);
        _isLoading = false;
        _page++;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Barcha Mahsulotlar"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24.sp,
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchDelegate());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body:
          _products.isEmpty && _isLoading
              ? GridView.builder(
                physics: BouncingScrollPhysics(),
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
              : GridView.builder(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                padding: EdgeInsets.all(10.h),
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
    );
  }
}
