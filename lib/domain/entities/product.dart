import 'package:equatable/equatable.dart';

class Product extends Equatable {
  int id;
  String name;
  String imageUrl;
  String brandName;
  String packageName;
  int price;
  double rating;

  Product(
    this.id,
    this.name,
    this.imageUrl,
    this.brandName,
    this.packageName,
    this.price,
    this.rating,
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
