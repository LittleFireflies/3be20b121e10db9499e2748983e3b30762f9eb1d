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
            if (state.carts.isEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text('Keranjangmu masih kosong, nih.'),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 30),
                      primary: Colors.red,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Pesan Sekarang'),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Daftar Pesanan'),
                      TextButton(
                        child: Text('Hapus Pesanan'),
                        onPressed: () {
                          context.read<ProductCartBloc>().add(RemoveOrder());
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.carts.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          order: state.carts[index],
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
            }
          },
        ),
      ),
    );
  }
}
