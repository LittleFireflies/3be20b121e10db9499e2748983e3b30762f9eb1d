import 'package:kulina_app/data/datasources/db_helper.dart';
import 'package:kulina_app/data/models/product_table.dart';

abstract class Database {
  void addToCart(ProductOrderTable productOrder);
  Future<List<ProductOrderTable>> getAllCarts();
  Future<ProductOrderTable?> getCartsByProductId(int id);
  void updateCart(ProductOrderTable productOrder);
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

  @override
  Future<ProductOrderTable?> getCartsByProductId(int id) {
    // TODO: implement getCartsByProductId
    throw UnimplementedError();
  }

  @override
  void updateCart(ProductOrderTable productOrder) {
    helper.updateCart(productOrder);
  }
}
