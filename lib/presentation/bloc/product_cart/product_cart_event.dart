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

class GetProductStatusEvent extends ProductCartEvent {
  final Product product;

  GetProductStatusEvent(this.product);

  @override
  // TODO: implement props
  List<Object?> get props => [product];
}
