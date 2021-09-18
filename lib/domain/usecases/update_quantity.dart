import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';

class UpdateQuantity {
  final ProductRepository repository;

  UpdateQuantity(this.repository);

  execute(ProductOrder product, int newQuantity) {
    if (newQuantity <= 0) {
      repository.removeFromCart(product);
    } else {
      product.quantity = newQuantity;
      repository.updateCart(product);
    }
  }
}
