import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function() onAddToCart;

  ProductItem({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(product.imageUrl),
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
            Flexible(
              child: Text(
                'Rp ${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 14),
              ),
            ),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                'termasuk ongkir',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        BlocBuilder<ProductCartBloc, ProductCartState>(
          builder: (context, state) {
            if (!state.carts.contains(product)) {
              return OutlinedButton(
                onPressed: onAddToCart,
                child: Text('Tambah ke keranjang'),
              );
            } else {
              return Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('-'),
                  ),
                  Expanded(
                    child: Text(
                      '1',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('+'),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
