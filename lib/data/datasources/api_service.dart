import 'dart:convert';

import 'package:kulina_app/data/models/product_dto.dart';
import 'package:http/http.dart' as http;

abstract class ApiService {
  Future<List<ProductDTO>> getProducts();
}

class ApiServiceImpl implements ApiService {
  static const baseUrl = 'https://kulina-recruitment.herokuapp.com';

  final http.Client client;

  ApiServiceImpl({required this.client});

  @override
  Future<List<ProductDTO>> getProducts() async {
    final response = await client.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      return productDtoFromJson(response.body);
    } else {
      throw Exception('Request Not Success');
    }
  }
}
