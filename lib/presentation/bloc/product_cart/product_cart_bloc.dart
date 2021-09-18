import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kulina_app/domain/entities/product.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  ProductCartBloc() : super(ProductCartState([]));

  @override
  Stream<ProductCartState> mapEventToState(
    ProductCartEvent event,
  ) async* {
    if (event is AddToCart) {
      final newCarts = List<Product>.from(state.carts);
      newCarts.add(event.product);
      yield ProductCartState(newCarts);
    }
  }
}
