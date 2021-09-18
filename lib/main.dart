import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:kulina_app/data/datasources/api_service.dart';
import 'package:kulina_app/data/datasources/database.dart';
import 'package:kulina_app/data/datasources/db_helper.dart';
import 'package:kulina_app/data/repositories/product_repository_impl.dart';
import 'package:kulina_app/domain/usecases/add_to_cart.dart';
import 'package:kulina_app/domain/usecases/get_cart_list.dart';
import 'package:kulina_app/domain/usecases/get_product_list.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:kulina_app/presentation/pages/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductListBloc(
            GetProductList(
              ProductRepositoryImpl(
                apiService: ApiServiceImpl(client: Client()),
                database: DatabaseSQLiteImpl(DatabaseHelper()),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ProductCartBloc(
            addToCart: AddToCart(
              ProductRepositoryImpl(
                apiService: ApiServiceImpl(client: Client()),
                database: DatabaseSQLiteImpl(DatabaseHelper()),
              ),
            ),
            getCartList: GetCartList(
              ProductRepositoryImpl(
                apiService: ApiServiceImpl(client: Client()),
                database: DatabaseSQLiteImpl(DatabaseHelper()),
              ),
            ),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductListScreen(),
      ),
    );
  }
}
