part of 'product_cart_bloc.dart';

abstract class ProductCartEvent extends Equatable {
  const ProductCartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends ProductCartEvent {
  final Product product;

  AddToCartEvent(this.product);

  @override
  List<Object> get props => [product];
}
