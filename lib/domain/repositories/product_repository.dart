import 'package:kulina_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductList();
}
