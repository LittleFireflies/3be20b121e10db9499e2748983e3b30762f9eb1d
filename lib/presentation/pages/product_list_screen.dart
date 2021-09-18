import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:kulina_app/presentation/pages/cart_screen.dart';
import 'package:kulina_app/utils/date_utils.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DateTime _selectedDate = getInitialDate();
  static const numberOfDays = 7;
  static const numberOfWeeks = 8;

  @override
  void initState() {
    super.initState();
    context.read<ProductListBloc>().add(LoadProductList());
    context.read<ProductCartBloc>().add(GetCartEvent());
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
            DatePicker(
              getInitialDate(),
              initialSelectedDate: _selectedDate,
              selectionColor: Colors.black,
              daysCount: numberOfDays * numberOfWeeks,
              inactiveDates: getSaturdayAndSunday(),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            Text(
              getFullDateFormat(_selectedDate),
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  BlocBuilder<ProductListBloc, ProductListState>(
                    builder: (context, state) {
                      if (state is LoadingProductList) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ProductListHasData) {
                        return GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 2.5,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: state.products
                              .map((product) => ProductItem(
                                    product: product,
                                    onAddToCart: () {
                                      context
                                          .read<ProductCartBloc>()
                                          .add(AddToCartEvent(
                                            product: product,
                                            date: _selectedDate,
                                          ));
                                    },
                                  ))
                              .toList(),
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
                  BlocBuilder<ProductCartBloc, ProductCartState>(
                    builder: (context, state) {
                      if (state.carts.isEmpty) {
                        return Container();
                      } else {
                        return Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: CartButton(
                            state.carts,
                            actionWidget: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen()));
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  List<ProductOrder> carts;
  Widget? actionWidget;

  CartButton(this.carts, {this.actionWidget});

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
                    '${carts.length} item',
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
