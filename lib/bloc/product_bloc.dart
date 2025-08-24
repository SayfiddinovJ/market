import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bloc/product_event.dart';
import 'package:market/bloc/product_state.dart';
import 'package:market/data/models/product/product_model.dart';
import 'package:market/data/models/status.dart';
import 'package:market/data/models/universal_data.dart';
import 'package:market/repository/product_repo.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;

  ProductBloc(this.productRepo)
    : super(
        ProductState(
          productModel: ProductModel(
            productId: '',
            name: '',
            type: '',
            price: '',
            image: '',
            status: '',
            category: '',
            description: '',
            createdAt: '',
          ),
          products: [],
          status: Status.pure,
          message: '',
          categoryProducts: [],
          categoryStatus: CategoryStatus.pure,
          searchedProducts: [],
        ),
      ) {
    on<ProductEvent>((event, emit) {});
    on<GetProductsEvent>(getProducts);
    on<GetRandomProductsEvent>(getRandomProducts);
    on<GetProductByCategoryEvent>(getProductsByCategory);
    on<ClearCategoryProductEvent>(clearCategoryProduct);
    on<SearchProductByCategoryEvent>(searchProductsByCategory);
    on<SearchProductEvent>(
      searchProduct,
      transformer: debounce(const Duration(seconds: 1)),
    );
    on<ClearSearchedProductEvent>(clearSearchedProduct);
  }

  Future<void> getProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, message: 'Yuklanmoqda...'));
    UniversalData data = await productRepo.getRandomProductsPaginated();
    if (data.error.isNotEmpty) {
      emit(state.copyWith(status: Status.failure, message: data.error));
    } else {
      emit(
        state.copyWith(
          status: Status.success,
          products: data.data,
          message: data.error,
        ),
      );
    }
  }

  Future<void> getRandomProducts(
    GetRandomProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, message: 'Yuklanmoqda...'));
    UniversalData data = await productRepo.getRandomProductsPaginated(
      page: event.page,
      limit: event.limit,
    );
    if (data.error.isNotEmpty) {
      emit(state.copyWith(status: Status.failure, message: data.error));
    } else {
      emit(
        state.copyWith(
          status: Status.success,
          products: state.products + data.data,
          message: data.error,
        ),
      );
    }
  }

  Future<void> getProductsByCategory(
    GetProductByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, message: 'Yuklanmoqda...'));
    UniversalData data = await productRepo.getProductsByCategory(
      event.category,
      page: event.page,
      limit: event.limit,
    );
    if (data.error.isNotEmpty) {
      emit(state.copyWith(status: Status.failure, message: data.error));
    } else {
      emit(
        state.copyWith(
          status: Status.success,
          categoryProducts: state.categoryProducts + data.data,
          message: data.error,
        ),
      );
    }
  }

  Future<void> searchProductsByCategory(
    SearchProductByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, message: 'Yuklanmoqda...'));
    UniversalData data = await productRepo.searchProductsByCategory(
      event.query,
      event.category,
    );
    if (data.error.isNotEmpty) {
      emit(state.copyWith(status: Status.failure, message: data.error));
    } else {
      emit(
        state.copyWith(
          status: Status.success,
          searchedProducts: state.searchedProducts,
          message: data.error,
        ),
      );
    }
  }

  Future<void> searchProduct(
    SearchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, message: 'Yuklanmoqda...'));
    UniversalData data = await productRepo.searchProduct(event.query);
    if (data.error.isNotEmpty) {
      emit(state.copyWith(status: Status.failure, message: data.error));
    } else {
      emit(
        state.copyWith(
          status: Status.success,
          searchedProducts: data.data,
          message: data.error,
        ),
      );
    }
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  Future<void> clearCategoryProduct(
    ClearCategoryProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(categoryProducts: []));
  }

  Future<void> clearSearchedProduct(
    ClearSearchedProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(searchedProducts: []));
  }
}
