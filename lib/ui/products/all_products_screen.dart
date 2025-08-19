import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/bloc/product_bloc.dart';
import 'package:market/bloc/product_event.dart';
import 'package:market/bloc/product_state.dart';
import 'package:market/data/models/status.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/widgets/product_card.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late ScrollController controller;

  void init() {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        BlocProvider.of<ProductBloc>(
          context,
        ).add(GetRandomProductsEvent(10, 1));
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Barcha mahsulotlar'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.search);
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: GridView.count(
                    controller: controller,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.7,
                    addAutomaticKeepAlives: true,
                    children:
                        state.products
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(bottom: 5.w),
                                child: ProductCard(
                                  product: e,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.product,
                                      arguments: e,
                                    );
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                if (state.status == Status.loading) ...[
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
