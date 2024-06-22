// To parse this JSON data, do
//
//     final userBuyProductDetails = userBuyProductDetailsFromJson(jsonString);

import 'dart:convert';

UserBuyProductDetails userBuyProductDetailsFromJson(String str) => UserBuyProductDetails.fromJson(json.decode(str));

String userBuyProductDetailsToJson(UserBuyProductDetails data) => json.encode(data.toJson());

class UserBuyProductDetails {
  String? name;
  String? contact;
  String? city;
  String? address;
  String? totalAmount;
  String? totalProducts;
  String? order;
  String? paymentmethod;

  UserBuyProductDetails({
    this.name,
    this.contact,
    this.city,
    this.address,
    this.totalAmount,
    this.totalProducts,
    this.order,
    this.paymentmethod,
  });

  factory UserBuyProductDetails.fromJson(Map<String, dynamic> json) => UserBuyProductDetails(
    name: json["name"],
    contact: json["contact"],
    city: json["city"],
    address: json["address"],
    totalAmount: json["totalAmount"],
    totalProducts: json["totalProducts"],
    order: json["order"],
    paymentmethod: json["paymentmethod"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "contact": contact,
    "city": city,
    "address": address,
    "totalAmount": totalAmount,
    "totalProducts": totalProducts,
    "order": order,
    "paymentmethod": paymentmethod,
  };
}
