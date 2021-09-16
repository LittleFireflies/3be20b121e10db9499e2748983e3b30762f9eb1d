import 'package:dartz/dartz.dart';
import 'package:kulina_app/data/datasources/api_service.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';
import 'package:kulina_app/utils/failure.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ApiService _apiService;

  ProductRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, List<Product>>> getProductList() async {
    try {
      final result = await _apiService.getProducts();
      return Right(result.map((product) => product.toEntity()).toList());
    } on Exception {
      return Left(ServerFailure(''));
    }
  }
}
