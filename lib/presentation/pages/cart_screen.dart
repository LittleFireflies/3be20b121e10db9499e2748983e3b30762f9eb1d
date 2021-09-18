import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/presentation/widgets/cart_button.dart';
import 'package:kulina_app/presentation/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProductCartBloc, ProductCartState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Daftar Pesanan'),
                    TextButton(
                      child: Text('Hapus Pesanan'),
                      onPressed: () {},
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.carts.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        product: state.carts[index].product,
                      );
                    },
                  ),
                ),
                CartButton(
                  state,
                  actionWidget: TextButton(
                    child: Row(
                      children: [
                        Text('Checkout'),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
