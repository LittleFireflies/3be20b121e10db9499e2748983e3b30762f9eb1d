import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/presentation/pages/product_list_screen.dart';

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
                  state.carts,
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

class CartItem extends StatelessWidget {
  final Product product;

  CartItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Image.network(product.imageUrl),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(product.name),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
                Text(product.brandName),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text('Rp ${product.price}'),
                    ),
                    Container(
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('-'),
                          ),
                          Text('1'),
                          TextButton(
                            onPressed: () {},
                            child: Text('+'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
