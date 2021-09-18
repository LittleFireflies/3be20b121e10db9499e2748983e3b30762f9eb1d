part of 'product_cart_bloc.dart';

abstract class ProductCartEvent extends Equatable {
  const ProductCartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends ProductCartEvent {
  final Product product;
  final DateTime date;

  AddToCartEvent({required this.product, required this.date});

  @override
  List<Object> get props => [product, date];
}
