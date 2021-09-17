import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kulina_app/domain/entities/product.dart';

List<ProductDTO> productDtoFromJson(String str) =>
    List<ProductDTO>.from(json.decode(str).map((x) => ProductDTO.fromJson(x)));

String productDtoToJson(List<ProductDTO> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDTO extends Equatable {
  ProductDTO({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.brandName,
    required this.packageName,
    required this.price,
    required this.rating,
  });

  int id;
  String name;
  String imageUrl;
  String brandName;
  String packageName;
  int price;
  double rating;

  factory ProductDTO.fromJson(Map<String, dynamic> json) => ProductDTO(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        brandName: json["brand_name"],
        packageName: json["package_name"],
        price: json["price"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "brand_name": brandName,
        "package_name": packageName,
        "price": price,
        "rating": rating,
      };

  Product toEntity() => Product(
        id,
        name,
        imageUrl,
        brandName,
        packageName,
        price,
        rating,
      );

  @override
  List<Object> get props => [
        id,
        name,
        imageUrl,
        brandName,
        packageName,
        price,
        rating,
      ];
}
