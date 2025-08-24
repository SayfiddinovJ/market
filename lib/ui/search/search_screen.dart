import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/bloc/product_bloc.dart';
import 'package:market/bloc/product_event.dart';
import 'package:market/bloc/product_state.dart';
import 'package:market/data/models/status.dart';
import 'package:market/data/storage/storage_repository.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/search/widgets/last_searched.dart';
import 'package:market/ui/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void deactivate() {
    context.read<ProductBloc>().add(ClearSearchedProductEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsetsGeometry.symmetric(vertical: 5.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                hintText: 'Mahsulotlarni qidirish...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    context.read<ProductBloc>().add(
                      ClearSearchedProductEvent(),
                    );
                  },
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && value.length > 2) {
                  context.read<ProductBloc>().add(
                    SearchProductEvent(query: value),
                  );
                }
              },
            ),
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Mahsulot qidirilmoqda...'),
                    CupertinoActivityIndicator(),
                  ],
                ),
              );
            } else if (state.status == Status.failure) {
              return const Center(child: Text('Xatolik yuz berdi'));
            } else if (controller.text.isEmpty) {
              // agar yozilmagan bo‘lsa oxirgi qidiruvlar chiqadi
              return LastSearched(
                onChanged: (value) {
                  controller.text = value;
                  context.read<ProductBloc>().add(
                    SearchProductEvent(query: value),
                  );
                },
              );
            } else if (state.status == Status.success &&
                state.searchedProducts.isNotEmpty) {
              // qidiruv muvaffaqiyatli va natija bor
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.7,
                addAutomaticKeepAlives: true,
                children:
                    state.searchedProducts
                        .map(
                          (e) => ProductCard(
                            product: e,
                            onTap: () {
                              List<String> searches = StorageRepository.getList(
                                'searchedProducts',
                              );
                              searches.add(e.name);
                              StorageRepository.putList(
                                'searchedProducts',
                                searches,
                              );
                              Navigator.pushNamed(
                                context,
                                RouteNames.product,
                                arguments: e,
                              );
                            },
                          ),
                        )
                        .toList(),
              );
            } else if (state.status == Status.success &&
                state.searchedProducts.isEmpty &&
                controller.text.isNotEmpty) {
              // qidiruv muvaffaqiyatli, lekin hech narsa topilmadi
              return const Center(child: Text('Mahsulot topilmadi'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
