import 'package:kulina_app/domain/repositories/product_repository.dart';

class EmptyCart {
  final ProductRepository repository;

  EmptyCart(this.repository);

  execute() {
    repository.clearCart();
  }
}
