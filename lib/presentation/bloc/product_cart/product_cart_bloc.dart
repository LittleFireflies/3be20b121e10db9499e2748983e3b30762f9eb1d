import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/usecases/add_to_cart.dart';
import 'package:kulina_app/domain/usecases/get_cart_list.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  final GetCartList getCartList;
  final AddToCart addToCart;

  ProductCartBloc({required this.getCartList, required this.addToCart})
      : super(ProductCartState([]));

  @override
  Stream<ProductCartState> mapEventToState(
    ProductCartEvent event,
  ) async* {
    if (event is AddToCartEvent) {
      addToCart.execute(ProductOrder(
          product: event.product, date: DateTime.now(), quantity: 1));
      yield ProductCartState(await getCartList.execute());
    }
  }
}
