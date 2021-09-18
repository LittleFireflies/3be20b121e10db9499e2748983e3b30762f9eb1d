import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';

class GetCartList {
  final ProductRepository repository;

  GetCartList(this.repository);

  Future<List<ProductOrder>> execute() {
    return repository.getCarts();
  }
}
