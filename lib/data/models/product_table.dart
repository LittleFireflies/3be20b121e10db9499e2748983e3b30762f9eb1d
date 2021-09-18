import 'package:kulina_app/domain/entities/product.dart';

class ProductOrderTable {
  Product product;
  DateTime date;

  ProductOrderTable(this.product, this.date);

  factory ProductOrderTable.fromEntity(ProductOrder productOrder) =>
      ProductOrderTable(productOrder.product, productOrder.date);

  factory ProductOrderTable.fromJson(Map<String, dynamic> json) {
    final product = Product(
      json["id"],
      json["name"],
      json["imageUrl"] ?? "-",
      json["brandName"],
      json["packageName"],
      json["price"],
      json["rating"],
    );

    return ProductOrderTable(
      product,
      DateTime.parse(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": product.id,
        "name": product.name,
        "imageUrl": product.imageUrl,
        "brandName": product.brandName,
        "packageName": product.packageName,
        "price": product.price,
        "rating": product.rating,
        "date": date.toIso8601String()
      };

  ProductOrder toEntity() => ProductOrder(product: product, date: date);
}
