import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/presentation/bloc/product_list/product_list_bloc.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductListBloc>().add(LoadProductList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kulina'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kamis, 16 September 2021',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
                if (state is LoadingProductList) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductListHasData) {
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: state.products
                          .map((product) => ProductItem(
                                product: product,
                              ))
                          .toList(),
                    ),
                  );
                } else if (state is ProductListError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

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
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Rp ${product.price}',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
            ),
            SizedBox(width: 4),
            Text(
              'termasuk ongkir',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text('Tambah ke keranjang'),
        ),
      ],
    );
  }
}
