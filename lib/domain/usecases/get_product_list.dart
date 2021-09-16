import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';

class GetProductList {
  final ProductRepository _repository;

  GetProductList(this._repository);

  Future<List<Product>> execute() {
    return _repository.getProductList();
  }
}
