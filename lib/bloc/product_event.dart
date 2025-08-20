class ProductEvent {}

class GetProductsEvent extends ProductEvent {}

class GetRandomProductsEvent extends ProductEvent {
  final int limit;
  final int page;

  GetRandomProductsEvent(this.limit, this.page);
}

class GetProductByCategoryEvent extends ProductEvent {
  final String category;
  final int limit;
  final int page;

  GetProductByCategoryEvent({
    required this.category,
    required this.limit,
    required this.page,
  });
}

class SearchProductEvent extends ProductEvent {
  final String query;

  SearchProductEvent({required this.query});
}

class SearchProductByCategoryEvent extends ProductEvent {
  final String query;
  final String category;

  SearchProductByCategoryEvent({required this.query, required this.category});
}

class ClearCategoryProductEvent extends ProductEvent {}
