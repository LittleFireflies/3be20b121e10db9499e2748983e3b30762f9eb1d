import 'package:dartz/dartz.dart';
import 'package:kulina_app/data/datasources/api_service.dart';
import 'package:kulina_app/data/datasources/database.dart';
import 'package:kulina_app/data/models/product_table.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';
import 'package:kulina_app/utils/failure.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ApiService apiService;
  final Database database;

  ProductRepositoryImpl({
    required this.apiService,
    required this.database,
  });

  @override
  Future<Either<Failure, List<Product>>> getProductList() async {
    try {
      final result = await apiService.getProducts();
      return Right(result.map((product) => product.toEntity()).toList());
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  void saveToCart(ProductOrder productOrder) {
    database.addToCart(ProductOrderTable.fromEntity(productOrder));
  }

  @override
  Future<List<ProductOrder>> getCarts() async {
    final result = await database.getAllCarts();
    return Future.value(
        result.map((productOrder) => productOrder.toEntity()).toList());
  }
}
