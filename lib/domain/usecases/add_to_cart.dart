import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';

class AddToCart {
  final ProductRepository repository;

  AddToCart(this.repository);

  void execute(ProductOrder productOrder) {
    repository.saveToCart(productOrder);
  }
}
