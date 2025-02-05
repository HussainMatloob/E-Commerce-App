// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String productId;
  String id;
  String productName;
  int initialPrice;
  int totalPrice;
  String image;
  String quantity;
  String status;

  CartModel({
    required this.productId,
    required this.id,
    required this.productName,
    required this.initialPrice,
    required this.totalPrice,
    required this.image,
    required this.quantity,
    required this.status,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    productId: json["productId"],
    id: json["id"],
    productName: json["productName"],
    initialPrice: json["initialPrice"],
    totalPrice: json["totalPrice"],
    image: json["image"],
    quantity: json["quantity"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "id": id,
    "productName": productName,
    "initialPrice": initialPrice,
    "totalPrice": totalPrice,
    "image": image,
    "quantity": quantity,
    "status": status,
  };
}
