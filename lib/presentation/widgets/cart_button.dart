import 'package:flutter/material.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/utils/number_utils.dart';

class CartButton extends StatelessWidget {
  ProductCartState state;
  Widget? actionWidget;
  Function()? onPressed;

  CartButton(this.state, {this.actionWidget, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        padding: const EdgeInsets.all(16.0),
      ),
      onPressed: onPressed ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${state.carts.length} item | ${currencyFormat(state.totalPrice)}',
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
    );
  }
}
