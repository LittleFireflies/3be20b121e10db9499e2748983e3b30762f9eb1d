import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:kulina_app/presentation/pages/cart_screen.dart';
import 'package:kulina_app/presentation/widgets/cart_button.dart';
import 'package:kulina_app/presentation/widgets/product_item.dart';
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
                        final screenWidth = MediaQuery.of(context).size.width;
                        final gridHeight = 400;
                        final gridWidth = screenWidth / 2 - 16;

                        return GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: gridWidth / gridHeight,
                          // mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: state.products
                              .map((product) => ProductItem(
                                    product: product,
                                    selectedDate: _selectedDate,
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
                            state,
                            actionWidget: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              final String? resultMessage =
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CartScreen()));

                              if (resultMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(resultMessage)));
                              }
                            },
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
