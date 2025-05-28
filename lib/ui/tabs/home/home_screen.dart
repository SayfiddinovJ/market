import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/models/product/product_model.dart';
import 'package:market/repository/product_repo.dart';
import 'package:market/ui/shimmer/shimmer_grid_tile.dart';
import 'package:market/ui/tabs/search/search_screen.dart';
import 'package:market/ui/widgets/product_grid.dart';
import 'package:market/utils/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   tabController = TabController(length: 13, vsync: this);
  // }

  // @override
  // void dispose() {
  //   tabController.dispose();
  //   super.dispose();
  // }

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

    final newProducts = await context
        .read<ProductRepo>()
        .getRandomProductsPaginated(page: _page, limit: _limit);

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
      appBar: AppBar(
        title: const Text("SSL Market"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchDelegate());
            },
            icon: Icon(Icons.search),
          ),
        ],
        bottom: TabBar(
          indicatorColor: AppTheme.primaryColor,
          dividerHeight: 0,
          labelColor: AppTheme.primaryColor,
          labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          splashBorderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
          tabs: const [
            Tab(text: "Barchasi"),
            Tab(text: "Aksessuarlar"),
            Tab(text: "Kolbasalar"),
            Tab(text: "Oziq-ovqatlar"),
            Tab(text: "Parfyumeriyalar"),
            Tab(text: "Don mahsulotlari"),
            Tab(text: "Muzqaymoqlar"),
            Tab(text: "Suvlar"),
            Tab(text: "Pecheniylar"),
            Tab(text: "Pecheniylar"),
            Tab(text: "Uy ro'zg'or buyumlari"),
            Tab(text: "Xozmag"),
            Tab(text: "Boshqalar"),
          ],
        ),
      ),

      body: SafeArea(
        child:
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
      ),
    );
  }
}
