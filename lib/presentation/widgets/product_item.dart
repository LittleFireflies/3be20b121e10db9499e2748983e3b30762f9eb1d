import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/utils/date_utils.dart';
import 'package:kulina_app/utils/number_utils.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final DateTime selectedDate;
  final Function() onAddToCart;

  ProductItem(
      {required this.product,
      required this.selectedDate,
      required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(imageUrl: product.imageUrl),
        Row(
          children: [
            Text(
              product.rating.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RatingBar.builder(
              itemSize: 15,
              itemCount: 5,
              initialRating: product.rating,
              allowHalfRating: true,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (_) {},
            )
          ],
        ),
        Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
        ),
        Text(
          'by ${product.brandName}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          product.packageName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 16),
        Wrap(
          children: [
            Text(
              '${currencyFormat(product.price)}',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14),
            ),
            SizedBox(width: 4),
            Text(
              'termasuk ongkir',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        BlocBuilder<ProductCartBloc, ProductCartState>(
          builder: (context, state) {
            for (var productOrder in state.carts) {
              if (product == productOrder.product &&
                  productOrder.date.isSameDate(selectedDate)) {
                return Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        context
                            .read<ProductCartBloc>()
                            .add(DecrementProductOrder(product: productOrder));
                      },
                      child: Text('-'),
                    ),
                    Expanded(
                      child: Text(
                        '${productOrder.quantity}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        context
                            .read<ProductCartBloc>()
                            .add(IncrementProductOrder(product: productOrder));
                      },
                      child: Text('+'),
                    ),
                  ],
                );
              }
            }
            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 12),
                  minimumSize: Size(double.infinity, 30)),
              onPressed: onAddToCart,
              child: Text('Tambah ke keranjang'),
            );
          },
        ),
      ],
    );
  }
}
