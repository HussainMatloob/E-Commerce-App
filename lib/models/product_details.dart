// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

ProductDetails productDetailsFromJson(String str) => ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  String? id;
  String? productName;
  String? type;
  List<dynamic>? image;
  int? price;
  int? quantity;
  String? details;
  int? salePrice;
  String? sale;
  String? likes;
  String? rating;
  String? createdAt;
  String? updatedAt;

  ProductDetails({
    this.id,
    this.productName,
    this.type,
    this.image,
    this.price,
    this.quantity,
    this.details,
    this.salePrice,
    this.sale,
    this.likes,
    this.rating,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["id"],
    productName: json["productName"],
    type: json["type"],
    image: json["image"] == null ? [] : List<dynamic>.from(json["image"]!.map((x) => x)),
    price: json["price"],
    quantity: json["quantity"],
    details: json["details"],
    salePrice: json["salePrice"],
    sale: json["sale"],
    likes: json["likes"],
    rating: json["rating"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productName": productName,
    "type": type,
    "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
    "price": price,
    "quantity": quantity,
    "details": details,
    "salePrice": salePrice,
    "sale": sale,
    "likes": likes,
    "rating": rating,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
