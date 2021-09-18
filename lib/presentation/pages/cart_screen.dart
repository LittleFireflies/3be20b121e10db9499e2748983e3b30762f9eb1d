import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/presentation/widgets/cart_button.dart';
import 'package:kulina_app/presentation/widgets/cart_item.dart';
import 'package:kulina_app/utils/date_utils.dart';

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
                      Text(
                        'Daftar Pesanan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        child: Text('Hapus Pesanan'),
                        onPressed: () {
                          context.read<ProductCartBloc>().add(RemoveOrder());
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: GroupedListView<ProductOrder, DateTime>(
                      elements: state.carts,
                      groupBy: (cart) => cart.date,
                      groupSeparatorBuilder: (date) {
                        return Text(
                          '${getFullDateFormat(date)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        );
                      },
                      itemBuilder: (context, productOrder) {
                        return CartItem(order: productOrder);
                      },
                    ),
                  ),
                  CartButton(
                    state,
                    actionWidget: Row(
                      children: [
                        Text('Checkout'),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                    onPressed: () {
                      context.read<ProductCartBloc>().add(RemoveOrder());
                      Navigator.pop(context, 'Order Successful!');
                    },
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
