import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:e_commerce_app/models/user_location-model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';

class ServicesOrApis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  //static User get user => auth.currentUser!;
  static User? get user => auth.currentUser;
  static Future<bool> userExists() async {
    return (await fireStore.collection('CartUser').doc(user!.uid).get()).exists;

  }


  static Future<void> createUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? Name = sp.getString('name');
    String? Contact = sp.getString('contact');
    String? password = sp.getString('password');
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final userProfile = UserProfile(
      id: user!.uid,
      password: password,
      userName: Name,
      contact: Contact,
      image: '',
      createdAt: time,
    );

    return await fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .set(userProfile.toJson());
  }

  static Future<void> createUserWithEmailAccount() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final userProfile = UserProfile(
      id: user!.uid,
      password: "",
      userName: user!.displayName.toString(),
      contact: user!.phoneNumber.toString(),
      image: '',
      createdAt: time,
    );

    return await fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .set(userProfile.toJson());
  }

  static Future<bool> addProductToCart(ProductDetails productDetails) async {
    var data = await fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .where('id', isEqualTo: productDetails.id.toString())
        .where('status', isEqualTo: "UnPayed")
        .get();

    if (data.docs.isEmpty) {
      final time = DateTime.now().millisecondsSinceEpoch.toString();
      final cartModel = CartModel(
        productId: time,
        id: productDetails.id.toString(),
        productName: productDetails.productName.toString(),
        initialPrice: productDetails.price!,
        totalPrice: productDetails.price!,
        image: productDetails.image.toString(),
        quantity: 1.toString(),
        status: "UnPayed",
      );

      fireStore
          .collection('CartUser')
          .doc(user!.uid)
          .collection('BuyerItemsDetail')
          .doc(time)
          .set(cartModel.toJson());

      return true;
    } else {
      return false;
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> currentUser(){
    return fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCartItems() {
    return fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .where('status', isEqualTo: "UnPayed")
        .snapshots();
  }

  static Future<void> DeleteItem(CartModel cartModel) async {
    fireStore
        .collection("CartUser")
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .doc(cartModel.productId)
        .delete();
  }

  static Future<void> addItemQuantity(CartModel cartModel,int price,int quantity) async {
    fireStore
        .collection("CartUser")
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .doc(cartModel.productId)
        .update({
      'totalPrice':price,
      'quantity':quantity.toString(),
    });
  }

  static Future<void> lessItemQuantity(CartModel cartModel,int price,int quantity) async {
    fireStore
        .collection("CartUser")
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .doc(cartModel.productId)
        .update({
      'totalPrice':price,
      'quantity':quantity.toString(),
    });
  }
  static Future<void> addLocation(String latitude,String longitude,String address) async {

    final locationModel=UserLocationModel(
      id: user!.uid,
      latitude: latitude,
      longitude: longitude,
      address: address
    );

    fireStore
        .collection("CustomerLocation")
        .doc(user!.uid)
        .set(locationModel.toJson());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getYourLocation() {

    return fireStore
        .collection("CustomerLocation")
        .doc(user!.uid)
        .snapshots();
  }
  static Future<void> forgotContactPassword(String newPassword) async{
    await fireStore
        .collection("CartUser")
        .doc(user!.uid)
        .update({
      "password":newPassword.toString(),
    });
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('customer_profile/${user!.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((po) {});

    var image = await ref.getDownloadURL();

    await fireStore.collection('CartUser').doc(user!.uid).update({
      'image': image,
    });
  }

}
