import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/bloc/product_bloc.dart';
import 'package:market/bloc/product_event.dart';
import 'package:market/bloc/product_state.dart';
import 'package:market/data/models/status.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/home/widgets/categories_list.dart';
import 'package:market/ui/home/widgets/search_container.dart';
import 'package:market/ui/widgets/global_button.dart';
import 'package:market/ui/widgets/product_card.dart';
import 'package:market/ui/widgets/theme_changer.dart';
import 'package:market/utils/extensions/extensions.dart';
import 'package:market/utils/images/app_images.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  void _init() {
    BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Image.asset(AppImages.appLogo),
          ),
          title: Text(
            'SSL Market',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.search);
              },
              icon: Icon(Icons.search),
            ),
            ThemeChanger(),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: const SearchContainer()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
                    child: Text(
                      'Kategoriyalar',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: const CategoriesList()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    child: Text(
                      'Mahsulotlar',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                SliverSkeletonizer(
                  enabled: state.status == Status.loading,
                  child: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (state.status == Status.loading) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            height: 100,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(
                                    context,
                                  ).extension<ContainerColors>()!.background,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        } else {
                          return ProductCard(
                            product: state.products[index],
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.product,
                                arguments: state.products[index],
                              );
                            },
                          );
                        }
                      },
                      childCount:
                          state.status == Status.loading
                              ? 10
                              : state.products.length,addAutomaticKeepAlives: true
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Qatorlar soni
                      mainAxisSpacing: 12, // Vertikal bo'shliq
                      crossAxisSpacing: 0, // Gorizontal bo'shliq
                      childAspectRatio: 0.7, // Elementlar proporsiyasi
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: GlobalButton()),
              ],
            );
          },
        ),
      ),
    );
  }
}
