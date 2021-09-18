import 'package:kulina_app/data/datasources/db_helper.dart';
import 'package:kulina_app/data/models/product_table.dart';

abstract class Database {
  void addToCart(ProductOrderTable productOrder);
  Future<List<ProductOrderTable>> getAllCarts();
}

class DatabaseSQLiteImpl extends Database {
  final DatabaseHelper helper;

  DatabaseSQLiteImpl(this.helper);

  @override
  void addToCart(ProductOrderTable productOrder) {
    helper.addToCart(productOrder);
  }

  @override
  Future<List<ProductOrderTable>> getAllCarts() {
    return helper.getCarts();
  }
}
