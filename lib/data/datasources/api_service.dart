import 'package:kulina_app/data/models/product_dto.dart';

abstract class ApiService {
  Future<List<ProductDTO>> getProducts();
}
