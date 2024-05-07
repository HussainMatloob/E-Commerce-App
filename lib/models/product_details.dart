import 'dart:convert';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  final int? id;
  final String? productName;
  final String? type;
  final String? image;
  final int? price;
  final int? quantity;
  final String? details;

  ProductDetails({
    this.id,
    this.productName,
    this.type,
    this.image,
    this.price,
    this.quantity,
    this.details,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        productName: json["productName"],
        type: json["type"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "type": type,
        "image": image,
        "price": price,
        "quantity": quantity,
        "details": details,
      };
}
