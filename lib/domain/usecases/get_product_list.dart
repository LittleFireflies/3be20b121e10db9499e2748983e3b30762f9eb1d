import 'package:dartz/dartz.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';
import 'package:kulina_app/utils/failure.dart';

class GetProductList {
  final ProductRepository _repository;

  GetProductList(this._repository);

  Future<Either<Failure, List<Product>>> execute() {
    return _repository.getProductList();
  }
}
