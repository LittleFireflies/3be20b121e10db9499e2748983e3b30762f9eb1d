part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class EmptyProductList extends ProductListState {}

class LoadingProductList extends ProductListState {}

class ProductListHasData extends ProductListState {
  final List<Product> products;

  ProductListHasData(this.products);

  @override
  List<Object> get props => [products];
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError(this.message);

  @override
  List<Object> get props => [message];
}
