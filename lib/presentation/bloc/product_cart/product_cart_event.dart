part of 'product_cart_bloc.dart';

abstract class ProductCartEvent extends Equatable {
  const ProductCartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends ProductCartEvent {
  final Product product;
  final DateTime date;

  AddToCartEvent({required this.product, required this.date});

  @override
  List<Object?> get props => [product, date];
}

class GetCartEvent extends ProductCartEvent {
  DateTime? date;

  GetCartEvent({this.date});

  @override
  List<Object?> get props => [date];
}

class IncrementProductOrder extends ProductCartEvent {
  final ProductOrder product;

  IncrementProductOrder({required this.product});

  @override
  List<Object?> get props => [product];
}

class DecrementProductOrder extends ProductCartEvent {
  final ProductOrder product;

  DecrementProductOrder({required this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveCartItem extends ProductCartEvent {
  final ProductOrder productOrder;

  RemoveCartItem({required this.productOrder});

  @override
  List<Object?> get props => [productOrder];
}

class RemoveOrder extends ProductCartEvent {}
