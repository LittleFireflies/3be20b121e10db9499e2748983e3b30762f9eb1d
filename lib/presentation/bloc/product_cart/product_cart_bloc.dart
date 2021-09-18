import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/usecases/add_to_cart.dart';
import 'package:kulina_app/domain/usecases/get_cart_list.dart';
import 'package:kulina_app/domain/usecases/update_quantity.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  final GetCartList getCartList;
  final AddToCart addToCart;
  final UpdateQuantity updateQuantity;

  ProductCartBloc({
    required this.getCartList,
    required this.addToCart,
    required this.updateQuantity,
  }) : super(ProductCartState(carts: [], totalPrice: 0));

  @override
  Stream<ProductCartState> mapEventToState(
    ProductCartEvent event,
  ) async* {
    if (event is AddToCartEvent) {
      addToCart.execute(
          ProductOrder(product: event.product, date: event.date, quantity: 1));
      final cart = await getCartList.execute();
      yield ProductCartState(carts: cart, totalPrice: _countTotalPrice(cart));
    } else if (event is GetCartEvent) {
      final cart = await getCartList.execute();
      yield ProductCartState(carts: cart, totalPrice: _countTotalPrice(cart));
    } else if (event is IncrementProductOrder) {
      updateQuantity.execute(event.product, event.product.quantity + 1);
      final cart = await getCartList.execute();
      yield ProductCartState(
        carts: cart,
        totalPrice: _countTotalPrice(cart),
      );
    } else if (event is DecrementProductOrder) {
      updateQuantity.execute(event.product, event.product.quantity - 1);
      final cart = await getCartList.execute();
      yield ProductCartState(
        carts: cart,
        totalPrice: _countTotalPrice(cart),
      );
    } else if (event is RemoveCartItem) {
      updateQuantity.execute(event.productOrder, 0);
      final cart = await getCartList.execute();
      yield ProductCartState(
        carts: cart,
        totalPrice: _countTotalPrice(cart),
      );
    }
  }

  int _countTotalPrice(List<ProductOrder> orders) => orders
      .map((order) => order.product.price * order.quantity)
      .fold<int>(0, (previousValue, amount) => previousValue + amount);
}
