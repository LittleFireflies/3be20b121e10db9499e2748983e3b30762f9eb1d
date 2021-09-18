import 'package:flutter/material.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';

class CartButton extends StatelessWidget {
  ProductCartState state;
  Widget? actionWidget;

  CartButton(this.state, {this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.carts.length} item | Rp ${state.totalPrice}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Termasuk ongkos kirim',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              actionWidget ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
