import 'package:dartz/dartz.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/utils/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProductList();
  void saveToCart(ProductOrder productOrder);
  void removeFromCart(ProductOrder productOrder);
  Future<List<ProductOrder>> getCarts();
  void updateCart(ProductOrder product);
}
