part of 'product_cart_bloc.dart';

class ProductCartState extends Equatable {
  final List<ProductOrder> carts;

  ProductCartState(this.carts);

  @override
  List<Object> get props => [carts];
}
