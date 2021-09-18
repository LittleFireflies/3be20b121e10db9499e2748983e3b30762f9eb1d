import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:kulina_app/data/datasources/api_service.dart';
import 'package:kulina_app/data/repositories/product_repository_impl.dart';
import 'package:kulina_app/domain/usecases/get_product_list.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:kulina_app/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProductListBloc(
              GetProductList(
                ProductRepositoryImpl(
                  ApiServiceImpl(client: Client()),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (_) => ProductCartBloc(),
          )
        ],
        child: ProductListScreen(),
      ),
    );
  }
}
