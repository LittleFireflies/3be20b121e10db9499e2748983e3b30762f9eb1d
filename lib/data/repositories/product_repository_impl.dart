import 'package:kulina_app/data/datasources/api_service.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ApiService _apiService;

  ProductRepositoryImpl(this._apiService);

  @override
  Future<List<Product>> getProductList() async {
    final result = await _apiService.getProducts();
    return result.map((product) => product.toEntity()).toList();
  }
}
