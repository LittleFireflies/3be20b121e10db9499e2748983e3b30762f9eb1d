import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatefulWidget {
  final ProductOrder order;

  CartItem({required this.order});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: CachedNetworkImage(
              imageUrl: widget.order.product.imageUrl,
            ),
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
                      child: Text(widget.order.product.name),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
                Text(widget.order.product.brandName),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          'Rp ${widget.order.product.price * widget.order.quantity}'),
                    ),
                    Container(
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('-'),
                          ),
                          Text('${widget.order.quantity}'),
                          TextButton(
                            onPressed: () {
                              context.read<ProductCartBloc>().add(
                                  IncrementProductOrder(product: widget.order));
                            },
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
