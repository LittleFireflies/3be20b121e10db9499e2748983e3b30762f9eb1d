part of 'product_cart_bloc.dart';

class ProductCartState extends Equatable {
  final List<ProductOrder> carts;
  int totalPrice = 0;

  ProductCartState({required this.carts, required this.totalPrice});

  @override
  List<Object> get props => [carts, totalPrice];
}
