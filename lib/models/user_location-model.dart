// To parse this JSON data, do
//
//     final userLocationModel = userLocationModelFromJson(jsonString);

import 'dart:convert';

UserLocationModel userLocationModelFromJson(String str) => UserLocationModel.fromJson(json.decode(str));

String userLocationModelToJson(UserLocationModel data) => json.encode(data.toJson());

class UserLocationModel {
  String? id;
  String? address;
  String? latitude;
  String? longitude;

  UserLocationModel({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory UserLocationModel.fromJson(Map<String, dynamic> json) => UserLocationModel(
    id: json["id"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
  };
}
