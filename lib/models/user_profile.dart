// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  String? id;
  String? password;
  String? userName;
  String? image;
  String? contact;
  String? createdAt;
  String? userDeviceToken;

  UserProfile({
    this.id,
    this.password,
    this.userName,
    this.image,
    this.contact,
    this.createdAt,
    this.userDeviceToken,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    password: json["password"],
    userName: json["userName"],
    image: json["image"],
    contact: json["contact"],
    createdAt: json["createdAt"],
    userDeviceToken: json["userDeviceToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
    "userName": userName,
    "image": image,
    "contact": contact,
    "createdAt": createdAt,
    "userDeviceToken": userDeviceToken,
  };
}