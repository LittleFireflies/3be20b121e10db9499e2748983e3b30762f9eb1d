import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:kulina_app/data/datasources/api_service.dart';
import 'package:kulina_app/data/datasources/database.dart';
import 'package:kulina_app/data/datasources/db_helper.dart';
import 'package:kulina_app/data/repositories/product_repository_impl.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';
import 'package:kulina_app/domain/usecases/add_to_cart.dart';
import 'package:kulina_app/domain/usecases/empty_cart.dart';
import 'package:kulina_app/domain/usecases/get_cart_list.dart';
import 'package:kulina_app/domain/usecases/get_product_list.dart';
import 'package:kulina_app/domain/usecases/update_quantity.dart';
import 'package:kulina_app/presentation/bloc/product_cart/product_cart_bloc.dart';
import 'package:kulina_app/presentation/bloc/product_list/product_list_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => ProductListBloc(locator()));
  locator.registerFactory(() => ProductCartBloc(
        getCartList: locator(),
        addToCart: locator(),
        updateQuantity: locator(),
        emptyCart: locator(),
      ));

  // use case
  locator.registerLazySingleton(() => GetProductList(locator()));
  locator.registerLazySingleton(() => GetCartList(locator()));
  locator.registerLazySingleton(() => AddToCart(locator()));
  locator.registerLazySingleton(() => UpdateQuantity(locator()));
  locator.registerLazySingleton(() => EmptyCart(locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(apiService: locator(), database: locator()));

  // data sources
  locator.registerLazySingleton<ApiService>(
      () => ApiServiceImpl(client: locator()));
  locator.registerLazySingleton<Database>(() => DatabaseSQLiteImpl(locator()));

  // helper
  locator.registerLazySingleton(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => Client());
}
